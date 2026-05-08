# content_integration_search — optimization status

Status of the `content_integration_search` LookML project and Looker dashboard [1646](https://flighthub.looker.com/dashboards/1646?Date=7+day) "Content Integration - Search". Captures every change shipped, what is still pending, and the warehouse-side blockers that prevent finishing the job inside this repo.

Last updated: 2026-05-08.

## What this project backs

- One Looker explore: `content_integration_search` (defined in `models/content_integration_search.model.lkml`).
- One main view: `views/content_integration_search.view.lkml` (`sql_table_name: search_api_stats.gds_raw`).
- One join: `views/affiliate_mapping.view.lkml` (left outer, many-to-one on `affiliate_id`).
- Connection: `ota_phoenix` (ClickHouse, Looker user `analytics_ro`, **read-only**).
- Dashboard: 1646 ("Content Integration - Search"), broken into tabs by the team in May 2026.

## What we did

Listed in order. Each item links to the GitHub commit on `master`.

| # | Change | Commit | Tier | Notes |
|---|--------|--------|------|-------|
| 1 | Add `is_returned` hidden boolean dimension; switch `returned_packages_count` measure to filter on it. | [`a45c7f2`](https://github.com/filmozolevskiy/content_integration_search/commit/a45c7f2dd6e07f4870dff5f8e2c8ecd536dec350) | 1 | Cleaner boolean for aggregate-table use; values unchanged. |
| 2 | Add `datagroup: content_integration_search_datagroup` (1h cache, `sql_trigger` on `gds_raw`). Attach `persist_with` on the explore. | [`9327d51`](https://github.com/filmozolevskiy/content_integration_search/commit/9327d5110cfb1e6009983a389e9dc0affb687840) | 1 | Looker result-cache invalidates hourly with new data. Works on read-only connections. |
| 3 | Reverted `aggregate_table:` block on the explore. | [`9327d51`](https://github.com/filmozolevskiy/content_integration_search/commit/9327d5110cfb1e6009983a389e9dc0affb687840) | 1 | The `ota_phoenix` Looker user is read-only; PDTs / aggregate tables cannot materialize from Looker. See blockers below. |
| 4 | Drop dead `dayd_raw >= '2025-01-01'` predicate from `sql_always_where`. | [`d0d4cd1`](https://github.com/filmozolevskiy/content_integration_search/commit/d0d4cd16fb7ceab1a7ab119a49c8bc0c1c6ee67b) | 1 | `gds_raw` retention floor is ~2 months (oldest row 2026-03-09; zero rows pre-2025-01-01 across 10B rows). Predicate was filtering nothing. Verified post-deploy via Looker `query_sql`. |

Dashboard-side actions performed via the Looker UI (no LookML, no MCP):

- Dashboard 1646 broken into multiple tabs (Overview, Volume & Sources, Latency, Health, Geography & GDS, Supplier Breakdowns).
- `Top Countries` and `Top Routes` tile row limits trimmed from 5000 → 50.
- Defensive sweep: every tile on 1646 listens to the dashboard `Date` filter.

## Blockers we cannot fix inside this repo

These are the reasons further optimization has to land in ClickHouse (data-eng) or in dashboard UI, not in LookML.

### 1. The Looker connection `ota_phoenix` is read-only

The Looker user is `analytics_ro`. Looker cannot create, write, or refresh PDTs, aggregate tables, or scratch schemas on this connection.

Direct consequence: the `aggregate_table:` block we tried to ship as part of change (3) had no warehouse to land in, and Looker's `Unbuilt PDTs (0)` panel reports zero registered PDTs because none can be registered. We reverted the block and kept the `datagroup` (which is client-side and works fine on read-only connections).

To unblock the warehouse-side rollup, see Trello [#2827](https://trello.com/c/ttwtB7vb) — the daily MV is data-eng work; LookML can swap to it once it ships.

### 2. JSON parsing on `request_options` is the dominant per-tile cost

Every tile that uses `is_amadeusndc`, `suppliers_to_fetch`, `airline_codes`, `preferred_carriers`, `is_ffp`, `custom_search`, or `is_returned` (via `num_packages_returned`) re-parses the same 6–9 JSON keys out of `gds_raw.request_options` over ~1B rows for the dashboard's 7d window. A 4-key `uniqCombined(JSONExtractString(...))` smoke test against the 7d window timed out at 2+ minutes.

To unblock: physical columns on `gds_raw` for those keys, owned by data-eng. Trello [#2827](https://trello.com/c/ttwtB7vb).

### 3. The `Only AmadeusNDC (very slow)` dashboard filter (`amadeusndc_only`) cannot be removed

The team uses it. It stays.

The "(very slow)" suffix is honest: the underlying `is_amadeusndc` dimension is defined as `content_source = 'amadeus' AND visitParamHas(request_options, 'enable_ndc_content') = 1` — a JSON probe over 1B rows. We cannot make this filter cheap inside LookML alone; the win is gated on Trello [#2827](https://trello.com/c/ttwtB7vb) Phase 1 landing the materialized `enable_ndc_content` column. Once that column exists:

1. Redefine `is_amadeusndc` as `content_source = 'amadeus' AND enable_ndc_content = 1` (column read, no JSON).
2. Re-bind the `amadeusndc_only` dashboard filter to the (now cheap) `is_amadeusndc` dimension.
3. Drop the "(very slow)" parenthetical from the filter label.

Items 1 and 3 are LookML / dashboard-UI changes; item 2 is dashboard-UI only.

### 4. The `content_source` dimension is a 9-branch CASE on `office_id`

It works, but every new GDS / office onboarding requires a LookML edit + Looker deploy. Better home is a ClickHouse Dictionary so the mapping is one row update. Tracked on Trello [#2829](https://trello.com/c/KGbJtiqm) — data-eng creates `search_api_stats.content_source_mapping` + `content_source_dict`, then a small follow-up LookML PR on this repo swaps the CASE for `dictGetOrDefault(...)`.

## Looker MCP gaps that hit this dashboard

For the team's reference, these are tasks the agent **cannot** automate against this dashboard today and that always require a manual Looker UI step:

- Editing or deleting an existing dashboard tile (no `update_dashboard_element` / `delete_dashboard_element` MCP tool).
- Editing an existing dashboard filter's binding to a different dimension (no `update_dashboard_filter` MCP tool).
- Listing per-tile `dashboard_filters` config / `listens_to_filters` audit (no `get_dashboard_elements` MCP tool).

Anything in those buckets is a manual action on the dashboard editor in Looker.

## Open menu

| Item | Owner | Where |
|------|-------|-------|
| Materialize `gds_raw` JSON dims as physical columns + daily rollup MV | Data-eng | Trello [#2827](https://trello.com/c/ttwtB7vb) |
| `content_source` office_id → label as a ClickHouse Dictionary | Data-eng + small LookML PR on this repo | Trello [#2829](https://trello.com/c/KGbJtiqm) |
| Re-bind `Only AmadeusNDC (very slow)` filter (label rename + dimension rebind) | Dashboard UI; gated on [#2827](https://trello.com/c/ttwtB7vb) Phase 1 | This doc, Blocker 3 |
| Hide unused `dayd_5minute` / `dayd_10minute` / `dayd_30minute` from the field picker | LookML edit on this repo | Pending — small Tier 1 PR when prioritized |

When [#2827](https://trello.com/c/ttwtB7vb) Phase 1 lands, this doc gets a final pass: the LookML simplification of `is_amadeusndc`, the dashboard filter rebind, and the optional rename of the now-cheap dimensions.

connection: "ota_phoenix"


include: "/views/**/*.view.lkml"
include: "content_integration_search.ref.lkml"


datagroup: content_integration_search_datagroup {
  sql_trigger: SELECT toStartOfHour(max(date_added)) FROM search_api_stats.gds_raw ;;
  max_cache_age: "1 hour"
}


explore: content_integration_search {
  persist_with: content_integration_search_datagroup

  sql_always_where:
    ${content_integration_search.dayd_raw} >= '2025-01-01'
    AND ((${content_integration_search.api_user} IN ('kayak', 'kayakapp') AND ${content_integration_search.site_id} = 1)
         OR ${content_integration_search.api_user} NOT IN ('kayak', 'kayakapp')) ;;
  join: affiliate_mapping {
    type: left_outer
    sql_on: ${content_integration_search.affiliate_id} = ${affiliate_mapping.affiliate_id} ;;
    relationship: many_to_one
  }
}

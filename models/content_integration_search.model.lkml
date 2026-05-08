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

  aggregate_table: rollup_daily_dim {
    query: {
      dimensions: [
        content_integration_search.dayd_date,
        content_integration_search.content_source,
        content_integration_search.office_id,
        content_integration_search.device_type,
        content_integration_search.api_user,
        content_integration_search.search_engine,
        content_integration_search.search_source,
        content_integration_search.class,
        content_integration_search.site_currency,
        content_integration_search.is_amadeusndc,
        content_integration_search.is_multiticket,
        content_integration_search.is_multicurrency,
        content_integration_search.custom_search,
        content_integration_search.api_call,
        content_integration_search.response_time_bucket,
        content_integration_search.response,
        content_integration_search.is_returned,
      ]
      measures: [
        content_integration_search.all_requests_count,
        content_integration_search.returned_packages_count,
        content_integration_search.error_count,
        content_integration_search.max_response_time,
      ]
      timezone: "America/New_York"
    }
    materialization: {
      datagroup_trigger: content_integration_search_datagroup
    }
  }
}

view: content_integration_search {
  sql_table_name: search_api_stats.gds_raw ;;

  # ===========================
  # DIMENSION GROUPS / KEYS
  # ===========================

  dimension_group: dayd {
    type: time
    timeframes: [raw, hour, date, week, month, quarter, year]
    sql: ${TABLE}.date_added ;;
    group_label: "1. Time"
  }

  dimension: dayd_5minute {
    type: string
    label: "Dayd 05 Minute"
    sql: substring(toString(toStartOfFiveMinute(${dayd_raw})), 1, 16) ;;
    group_label: "1. Time"
    description: "Date and time at 5-minute granularity (YYYY-MM-DD HH:MM)"
  }

  dimension: dayd_10minute {
    type: string
    label: "Dayd 10 Minute"
    sql: substring(toString(toStartOfInterval(${dayd_raw}, toIntervalMinute(10))), 1, 16) ;;
    group_label: "1. Time"
    description: "Date and time at 10-minute granularity (YYYY-MM-DD HH:MM)"
  }

  dimension: dayd_30minute {
    type: string
    label: "Dayd 30 Minute"
    sql: substring(toString(toStartOfInterval(${dayd_raw}, toIntervalMinute(30))), 1, 16) ;;
    group_label: "1. Time"
    description: "Date and time at 30-minute granularity (YYYY-MM-DD HH:MM)"
  }

  dimension: search_id {
    type: string
    sql: ${TABLE}.search_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
    hidden: yes
  }

  # ===========================
  # HIDDEN HELPER DIMENSIONS
  # ===========================

  dimension: ff_hash {
    type: string
    sql: JSONExtractString(${TABLE}.request_options, 'fare_fetch_hash') ;;
    hidden: yes
  }

  dimension: custom_search_raw {
    type: string
    sql: JSONExtractString(${TABLE}.request_options, 'custom_search') ;;
    hidden: yes
  }

  dimension: site_currency_normalized {
    type: string
    sql:
      CASE
        WHEN upperUTF8(trim(${TABLE}.site_currency)) IN ('USD','CAD','GBP')
          THEN upperUTF8(trim(${TABLE}.site_currency))
        ELSE 'Other'
      END ;;
    hidden: yes
  }

  dimension: content_currency_normalized {
    type: string
    sql:
      CASE
        WHEN upperUTF8(trim(${TABLE}.currency)) IN ('USD','CAD','GBP')
          THEN upperUTF8(trim(${TABLE}.currency))
        ELSE 'Other'
      END ;;
    hidden: yes
  }

  dimension: class_normalized {
    type: string
    sql:
      CASE
        WHEN NULLIF(trim(${TABLE}.class), '') IS NULL THEN NULL
        WHEN upperUTF8(trim(${TABLE}.class)) IN ('ECONOMY', 'ECONMY', 'Y', 'M') THEN 'Economy'
        WHEN upperUTF8(trim(${TABLE}.class)) IN ('BUSINESS', 'C') THEN 'Business'
        WHEN upperUTF8(trim(${TABLE}.class)) IN ('FIRST') THEN 'First'
        WHEN upperUTF8(trim(${TABLE}.class)) IN ('ECONOMYPREMIUM', 'ECONOMY_PREMIUM', 'PREMIUMECONOMY', 'ECONOMY PREMIUM') THEN 'Economy Premium'
        ELSE ${TABLE}.class
      END ;;
    hidden: yes
  }

  # ===========================
  # DIMENSIONS
  # ===========================

  dimension: content_source {
    type: string
    sql:
      CASE
        WHEN ${office_id} IN ('AF8A','AF8B') THEN 'LH_Farelogix'
        WHEN ${office_id} IN ('AB2L','AB2O') THEN 'AA_Farelogix'
        WHEN ${office_id} = 'AHYI' THEN 'WS_Farelogix'
        WHEN ${office_id} IN ('BOGJ','BPNL') THEN 'AA_FarelogixNDC'
        WHEN ${office_id} IN ('BWKG','BV6I') THEN 'CM_FarelogixNDC'
        WHEN ${office_id} IN ('BXVU', 'BYZA') THEN 'TS_FarelogixNDC'
        WHEN ${office_id} IN ('NAVPDCAD', 'NAVPDUSD') THEN 'PD_Navitaire-NDC'
        WHEN ${office_id} IN ('NAVNKUSDMC', 'NAVNKUSD') THEN 'NK_Navitaire-NDC'
        ELSE ${TABLE}.content_source
      END ;;
    group_label: "2. Content"
  }

  dimension: office_id {
    type: string
    sql: ${TABLE}.office_id ;;
    group_label: "2. Content"
  }

  dimension: suppliers_to_fetch {
    type: string
    sql: JSONExtractString(${TABLE}.request_options, 'suppliers_to_fetch') ;;
    group_label: "2. Content"
  }

  dimension: airline_codes {
    type: string
    sql: JSONExtractString(${TABLE}.request_options, 'airline_codes') ;;
    group_label: "2. Content"
  }

  dimension: preferred_carriers {
    type: string
    sql: JSONExtractString(${TABLE}.request_options, 'preferred_carrier_codes') ;;
    group_label: "2. Content"
  }

  dimension: num_packages_returned {
    type: number
    value_format: "0"
    sql: ${TABLE}.num_packages_returned ;;
    group_label: "2. Content"
    hidden: yes
  }

  dimension: multiticket_part {
    type: string
    sql: ${TABLE}.multiticket_part ;;
    group_label: "2. Content"
    hidden: yes
  }

  dimension: class {
    type: string
    sql: ${class_normalized} ;;
    group_label: "2. Content"
    description: "Normalized service class for the flight search. Maps variations (economy/Economy/econmy/Y/M, business/Business/C, first/First, economypremium/EconomyPremium/Economy Premium, etc.) to standard values: Economy, Business, First, Economy Premium"
    suggestions: ["Economy", "Business", "First", "Economy Premium"]
  }

  dimension: is_multiticket{
    type: yesno
    sql: (NULLIF(TRIM(${TABLE}.multiticket_part), '') IS NOT NULL) ;;
    group_label: "2. Content"
    hidden: yes
  }

  dimension: is_ffp {
    label: "Is Fare Fetch +"
    type: yesno
    sql: (NULLIF(TRIM(${ff_hash}), '') IS NOT NULL) ;;
    group_label: "3. Search Source"
    description: "Indicates if the search belongs to Fare Fetch Plus (FF+) service. Determined by presence of fare_fetch_hash."
    hidden: yes
  }

  dimension: is_google_search {
    label: "Is Google Flight Search"
    type: yesno
    sql: (${api_user} = 'gfs' AND NOT ${is_ffp}) ;;
    group_label: "3. Search Source"
    hidden: yes
  }

  dimension: is_fare_alert {
    label: "Is Fare Alert"
    type: yesno
    sql: (${api_user} IN ('fhub_fare_alert', 'jfly_fare_alert') AND NOT ${is_ffp}) ;;
    group_label: "3. Search Source"
    hidden: yes
  }

  dimension: is_repricer {
    label: "Is Repricer"
    type: yesno
    sql: (${TABLE}.source = 'repricer' AND NOT ${is_ffp}) ;;
    group_label: "3. Search Source"
    hidden: yes
  }

  dimension: is_regular_search {
    label: "Is Regular Search"
    type: yesno
    sql: (NOT ${is_ffp} AND NOT ${is_google_search} AND NOT ${is_fare_alert} AND NOT ${is_repricer}) ;;
    group_label: "3. Search Source"
    hidden: yes
  }

  dimension: custom_search {
    label: "Custom Search"
    type: yesno
    sql: (${custom_search_raw} = '1') ;;
    group_label: "3. Search Source"
    description: "Indicates if the search is a custom search (custom_search = '1' in request_options)"
  }

  # Note: source = 'alert' is excluded; it is addressed in search_engine dimension
  dimension: search_source {
    type: string
    label: "External or Internal"
    group_label: "3. Search Source"
    sql:
    CASE
      WHEN ${TABLE}.source = 'search' THEN 'internal'
      WHEN ${TABLE}.source = 'repricer' THEN 'repricer'
      WHEN ${TABLE}.source = 'external' THEN 'external'
      WHEN ${TABLE}.source = 'other' THEN 'other'
      WHEN ${TABLE}.source = 'scraper' THEN 'scraper'
      WHEN ${TABLE}.source = 'alert' THEN 'fare alert'
      WHEN ${TABLE}.source = 'self-serve' THEN 'self-serve'
    END ;;
    suggestions: ["internal","external","scraper","self-serve","repricer","other"]
  }

  dimension: search_engine {
    label: "Search Engine"
    description: "Who searches: Google Search, FF+, Regular Search, Fare Alert"
    type: string
    group_label: "3. Search Source"
    sql:
    CASE
      WHEN ${is_google_search}    THEN 'Google Search'
      WHEN ${is_ffp}              THEN 'Fare Fetch+'
      WHEN ${is_fare_alert}       THEN 'Fare Alert'
      WHEN ${is_regular_search}   THEN 'Regular Search'
      WHEN ${is_repricer}         THEN 'Repricer'
      ELSE 'Other'
    END ;;
    suggestions: ["Google Search","Fare Fetch+","Regular Search","Fare Alert", "Repricer", "Other"]
  }

  dimension: affiliate_id {
    type: number
    sql: ${TABLE}.affiliate_id ;;
    group_label: "3. Search Source"
    description: "Numeric ID of the affiliate partner"
    hidden: yes
  }

  dimension: target_id {
    type: number
    sql: ${TABLE}.target_id ;;
    group_label: "3. Search Source"
  }

  dimension: api_user {
    type: string
    sql: ${TABLE}.api_user ;;
    group_label: "3. Search Source"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    group_label: "3. Search Source"
  }

  dimension: site_currency {
    label: "Site Currency"
    type: string
    group_label: "3. Search Source"
    sql: ${site_currency_normalized} ;;
    suggestions: ["USD","CAD","GBP","Other"]
  }

  dimension: content_currency {
    label: "Content Currency"
    type: string
    group_label: "3. Search Source"
    sql: ${content_currency_normalized} ;;
    suggestions: ["USD","CAD","GBP","Other"]
    hidden: yes
  }

  dimension: is_multicurrency {
    label: "Is Multicurrency"
    type: yesno
    group_label: "3. Search Source"
    sql:
    CASE
      WHEN ${site_currency} IS NULL OR ${content_currency} IS NULL THEN NULL
      WHEN ${site_currency} <> ${content_currency} THEN TRUE
      ELSE FALSE
    END ;;
  }

  dimension: api_call {
    label: "Api Call"
    type: string
    group_label: "3. Search Source"
    sql: ${TABLE}.api_call;;
    description: "Amadeus API method used for the search: Fare_InstantTravelBoardSearch or Fare_MasterPricerTravelBoardSearch."
    suggestions: ["Fare_InstantTravelBoardSearch","Fare_MasterPricerTravelBoardSearch"]
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
    group_label: "4. Locations"
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
    group_label: "4. Locations"
  }

  dimension: origin_country {
    type: string
    sql: ${TABLE}.origin_country ;;
    group_label: "4. Locations"
  }

  dimension: destination_country {
    type: string
    sql: ${TABLE}.destination_country ;;
    group_label: "4. Locations"
  }

  dimension: response_time {
    label: "Response Time (ms, 0 if not success)"
    type: number
    value_format: "0.00"
    sql:
      CASE
        WHEN ${TABLE}.response != 'success' THEN 0
        WHEN ${TABLE}.response_time IS NULL THEN 0
        ELSE ${TABLE}.response_time
      END ;;
    group_label: "5. Results"
  }

  dimension: response_time_bucket {
    type: string
    label: "Response Time Bucket"
    group_label: "5. Results"
    sql:
    CASE
      WHEN ${TABLE}.response != 'success' THEN NULL
      WHEN ${TABLE}.response_time IS NULL THEN NULL
      WHEN ${TABLE}.response_time * 1000 <= 200 THEN '0-200ms (Fastest)'
      WHEN ${TABLE}.response_time * 1000 <= 500 THEN '201-500ms (Fast)'
      WHEN ${TABLE}.response_time * 1000 <= 1000 THEN '501-1000ms (Medium)'
      WHEN ${TABLE}.response_time * 1000 <= 2000 THEN '1001-2000ms (Slow)'
      WHEN ${TABLE}.response_time * 1000 <= 4000 THEN '2001-4000ms (Very Slow)'
      ELSE '4000ms+ (Slowest)'
    END ;;
    description: "Response time divided into 6 fixed buckets. Database stores response_time in seconds, converted to milliseconds for bucketing. Failed requests are excluded."
    suggestions: ["0-200ms (Fastest)", "201-500ms (Fast)", "501-1000ms (Medium)", "1001-2000ms (Slow)", "2001-4000ms (Very Slow)", "4000ms+ (Slowest)"]
  }

  dimension: response {
    type: string
    sql: ${TABLE}.response ;;
    group_label: "5. Results"
  }

  dimension: errors {
    type: string
    sql: CASE
          WHEN ${TABLE}.response != 'success'
          THEN ${TABLE}.response
        END;;
    group_label: "5. Results"
  }

  # ===========================
  # MEASURES
  # ===========================

  # Volume
  measure: all_requests_count {
    type: count
    value_format_name: decimal_0
    group_label: "Volume"
  }

  measure: regular_request_count {
    type: count
    value_format_name: decimal_0
    filters: [is_regular_search: "yes"]
    label: "Regular Request Count"
    group_label: "Volume"
  }

  measure: ffp_request_count {
    type: count
    value_format_name: decimal_0
    filters: [is_ffp: "yes"]
    label: "FF+ Request Count"
    group_label: "Volume"
  }

  measure: google_search_request_count {
    type: count
    value_format_name: decimal_0
    filters: [is_google_search: "yes"]
    label: "Google Search Request Count"
    group_label: "Volume"
  }

  measure: fare_alerts_request_count {
    type: count
    value_format_name: decimal_0
    filters: [is_fare_alert: "yes"]
    label: "Fare Alerts Request Count"
    group_label: "Volume"
  }

  measure: repricer_request_count {
    type: count
    value_format_name: decimal_0
    filters: [is_repricer: "yes"]
    label: "Repricer Request Count"
    group_label: "Volume"
  }

  measure: returned_packages_count {
    type: count
    filters: [num_packages_returned: ">0"]
    group_label: "Volume"
    description: "Count of searches that returned at least one package"
    hidden: yes
  }

  # Latency
  measure: avg_response_time {
    type: average
    sql: ${response_time} ;;
    value_format: "0.00"
    label: "Avg Response Time (ms)"
    group_label: "Latency"
  }

  measure: max_response_time {
    type: max
    sql: ${response_time} ;;
    value_format: "0.00"
    label: "Max Response Time (ms)"
    group_label: "Latency"
  }

  # Health
  measure: returned_requests_rate {
    type: number
    value_format_name: percent_2
    sql: ${returned_packages_count} / NULLIF(${all_requests_count}, 0) ;;
    label: "Returned Packages Rate / Search Health (%)"
    group_label: "Health"
  }

  measure: error_count {
    type: sum
    sql: (CASE WHEN ${response} != 'success' THEN 1 ELSE 0 END) ;;
    value_format_name: decimal_0
    group_label: "Health"
  }

  measure: error_rate {
    type: number
    value_format_name: percent_2
    sql: ${error_count} / NULLIF(${all_requests_count}, 0) ;;
    label: "Error Requests Rate (%)"
    group_label: "Health"
  }

}

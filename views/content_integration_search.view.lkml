view: content_integration_search {
  parameter: start_date {
    type: date
    default_value: "2025-01-01"
  }

  derived_table: {
    sql:
    SELECT
      date_added AS dayd,
      IF(office_id IN ('AF8A','AF8B'), 'LH_Farelogix',
          IF(office_id IN ('AB2L','AB2O'), 'AA_Farelogix',
              IF(office_id IN ('BWKG','BV6I'), 'CM_Farelogix',
                  IF(office_id = 'AHYI','WS_Farelogix', content_source)))) AS content_source,
      JSONExtractString(request_options, 'suppliers_to_fetch') AS suppliers_to_fetch,
      JSONExtractString(request_options, 'airline_codes') AS airline_codes,
      JSONExtractString(request_options, 'preferred_carrier_codes') AS preferred_carriers,
      JSONExtractString(request_options, 'fare_fetch_hash') AS ff_hash,
      affiliate_id,
      target_id,
      office_id,
      origin,
      destination,
      origin_country,
      destination_country,
      api_user,
      device_type,
      search_id,
      num_packages_returned,
      response,
      site_currency as site_currency,
      source,
      IF(response != 'success', 0, response_time) AS response_time
    FROM search_api_stats.gds_raw
    WHERE
        date_added > {% parameter start_date %}
        AND ((api_user IN ('kayak', 'kayakapp') AND site_id = 1) OR api_user NOT IN ('kayak', 'kayakapp'))
        ;;
  }

  # -------------------------
  # Dimension groups / keys
  # -------------------------

  dimension_group: dayd {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.dayd ;;
    group_label: "1. Time"
  }

  dimension: search_id {
    type: string
    sql: ${TABLE}.search_id ;;
    primary_key: yes
    hidden: yes
  }

  # -------------------------
  # Dimensions
  # -------------------------

  dimension: content_source {
    type: string
    sql: ${TABLE}.content_source ;;
    group_label: "2. Content & Suppliers"
  }

  dimension: suppliers_to_fetch {
    type: string
    sql: ${TABLE}.suppliers_to_fetch ;;
    group_label: "2.  Content & Suppliers"
  }

  dimension: airline_codes {
    type: string
    sql: ${TABLE}.airline_codes ;;
    group_label: "2. Content & Suppliers"
  }

  dimension: preferred_carriers {
    type: string
    sql: ${TABLE}.preferred_carriers ;;
    group_label: "2. Content & Suppliers"
  }

  dimension: response {
    type: string
    sql: ${TABLE}.response ;;
    group_label: "2. Content & Suppliers"
  }

  dimension: errors {
    type: string
    sql: CASE
          WHEN ${TABLE}.response != 'success'
          THEN ${TABLE}.response
        END;;
    group_label: "2. Content & Suppliers"
  }

  dimension: num_packages_returned {
    type: number
    value_format: "0"
    sql: ${TABLE}.num_packages_returned ;;
    group_label: "2. Content & Suppliers"
  }

  dimension: is_ffp {
    label: "Is Fare Fetch +"
    type: yesno
    sql: NOT empty(${TABLE}.ff_hash) ;;
    group_label: "3. Search Source"
  }

  dimension: affiliate_id {
    type: number
    sql: ${TABLE}.affiliate_id ;;
    group_label: "3. Search Source"
  }

  dimension: target_id {
    type: number
    sql: ${TABLE}.target_id ;;
    group_label: "3. Search Source"
  }

  dimension: office_id {
    type: string
    sql: ${TABLE}.office_id ;;
    group_label: "Keys & IDs"
  }


  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
    group_label: "Markets & Geography"
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
    group_label: "Markets & Geography"
  }

  dimension: origin_country {
    type: string
    sql: ${TABLE}.origin_country ;;
    group_label: "Markets & Geography"
  }

  dimension: destination_country {
    type: string
    sql: ${TABLE}.destination_country ;;
    group_label: "Markets & Geography"
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
    type: string
    sql: ${TABLE}.site_currency ;;
    group_label: "3. Search Source"
  }


  dimension: source {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.source = 'search' THEN 'internal'
      WHEN ${TABLE}.source = 'repricer' THEN 'optimizer'
      WHEN ${TABLE}.source = 'external' THEN 'external'
      WHEN ${TABLE}.source = 'other' THEN 'other'
      WHEN ${TABLE}.source = 'alert' THEN 'fare_alert'
    END ;;
    group_label: "Response & Results"
  }

  dimension: response_time {
    label: "Response Time (ms, 0 if not success)"
    type: number
    value_format: "0"
    sql: ${TABLE}.response_time ;;
    group_label: "Response & Results"
  }

  # -------------------------
  # Measures
  # -------------------------

  # Volume
  measure: all_requests_count {
    type: count
    group_label: "Volume"
  }

  measure: regular_request_count {
    type: count
    value_format_name: decimal_2
    filters: [is_ffp: "no"]
    label: "Regular Request Count"
    group_label: "Volume"
  }

  measure: ffp_request_count {
    type: count
    value_format_name: decimal_2
    filters: [is_ffp: "yes"]
    label: "FF+ Request Count"
    group_label: "Volume"
  }

  measure: returned_packages_count {
    type: sum
    sql: (CASE WHEN ${num_packages_returned} > 0 THEN 1 ELSE 0 END) ;;
    group_label: "Volume"
  }

  # Latency
  measure: avg_response_time {
    type: average
    sql: ${response_time} ;;
    value_format: "0"
    label: "Avg Response Time (ms)"
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

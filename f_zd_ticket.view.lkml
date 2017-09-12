view: f_zd_ticket {
  sql_table_name: ZENDESK.F_ZD_TICKET ;;

  dimension: minutes_to_first_response {
    type: number
    sql:  ${TABLE}.MINUTES_TO_FIRST_RESPONSE ;;
  }

  dimension: minutes_to_resolve {
    type:  number
    sql: ${TABLE}.MINUTES_TO_RESOLVE ;;
  }

  dimension: num_opened {
    type: number
    sql: ${TABLE}.NUM_OPENED ;;
  }

  dimension: num_resolved {
    type: number
    sql: ${TABLE}.NUM_RESOLVED ;;
  }

  dimension: ticket_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: time_id {
    type: number
    sql: ${TABLE}.TIME_ID ;;
  }

  measure:  hours_to_first_response_avg {
    type: average
    sql: ${minutes_to_first_response}/60 ;;
  }

  measure:  hours_to_resolve_avg {
    type:  average
    sql:  ${minutes_to_resolve}/60 ;;
  }

  measure: count_num_opened {
    type:  sum
    sql:  ${num_opened} ;;
  }

  measure: count_num_resolved {
    type:  sum
    sql: ${num_resolved} ;;
  }

  measure: num_tickets_resolved_under_8_hrs {
    type: sum
    sql:  case when ${minutes_to_resolve} < (8*60) and ${minutes_to_resolve} is not null then 1 else 0 end;;
  }

  measure: perc_resolved_under_8_hrs {

    sql: (${num_tickets_resolved_under_8_hrs}/(case when sum(${num_resolved}) = 0 then 1 else sum(${num_resolved}) end))*100;;
  }

}

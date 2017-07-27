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

}

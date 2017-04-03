view: f_zd_ticket {
  sql_table_name: ZENDESK.F_ZD_TICKET ;;

  dimension: num_opened {
    type: string
    sql: ${TABLE}.NUM_OPENED ;;
  }

  dimension: num_resolved {
    type: string
    sql: ${TABLE}.NUM_RESOLVED ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: time_id {
    type: string
    sql: ${TABLE}.TIME_ID ;;
  }

  measure: count_num_opened{
    type: sum
    sql: ${num_opened} ;;
  }

  measure: count_num_solved{
    type: sum
    sql: ${num_resolved} ;;
  }

  measure: count {
    type: count
    drill_fields: [tickets.id]
  }
}

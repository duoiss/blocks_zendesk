view: d_ticket {
  sql_table_name: ZENDESK.D_TICKET ;;

  dimension: rours_to_resolve {
    type: string
    sql: ${TABLE}.ROURS_TO_RESOLVE ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: ticket_status {
    type: string
    sql: ${TABLE}.TICKET_STATUS ;;
  }

  measure: count {
    type: count
    drill_fields: [tickets.id]
  }
}

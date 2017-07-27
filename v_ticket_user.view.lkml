view: v_ticket_user {
  sql_table_name: ZENDESK.V_TICKET_USER ;;

  dimension: ticket_assignee_name {
    type: string
    sql: ${TABLE}.TICKET_ASSIGNEE_NAME ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.TICKET_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [ticket_assignee_name]
  }
}

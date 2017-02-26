view: _ticket_resolution_history {
  sql_table_name: ZENDESK.TICKET_HISTORY ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: new_value {
    type: string
    sql: CASE WHEN ${TABLE}.NEW_VALUE='solved' THEN ${TABLE}.NEW_VALUE END ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.PROPERTY ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: timestamp {
    type: string
    sql: MAX(${TABLE}.TIMESTAMP) ;;
  }

  dimension: updater_id {
    type: string
    sql: ${TABLE}.UPDATER_ID ;;
  }

  dimension: via {
    type: string
    sql: ${TABLE}.VIA ;;
  }

  measure: count {
    type: count
    drill_fields: [id, tickets.id]
  }
}

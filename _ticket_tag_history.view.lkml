view: _ticket_tag_history {
  sql_table_name: ZENDESK.TICKET_TAG_HISTORY ;;

  dimension: action {
    type: string
    sql: ${TABLE}.ACTION ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.TAG ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: timestamp {
    type: string
    sql: ${TABLE}.TIMESTAMP ;;
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

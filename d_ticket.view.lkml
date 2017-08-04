view: d_ticket {
  sql_table_name: ZENDESK.D_TICKET ;;

  dimension: groupname {
    type: string
    sql: ${TABLE}.GROUPNAME ;;
  }

  dimension: hours_to_resolve {
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

  dimension: location {
    type: string
    sql: ${TABLE}.LOCATION ;;
  }

##measure##

  measure: Num_Tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
  }

  measure: Num_Current_Open_Tickets {
    type:  count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: ticket_status
      value: "open, new, pending, hold"
    }
  }
}

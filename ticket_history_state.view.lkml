view: ticket_history_state {
  derived_table: {
    sql: SELECT *
            , row_number() over(partition by ticket_id order by timestamp asc) as status_change_number
      FROM ZENDESK.TICKET_HISTORY
      where property = 'status'
      and new_value = 'solved'
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.PROPERTY ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: updater_id {
    type: string
    sql: ${TABLE}.UPDATER_ID ;;
  }

  dimension: via {
    type: string
    sql: ${TABLE}.VIA ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.TIMESTAMP ;;
  }

  dimension: new_value {
    type: string
    sql: ${TABLE}.NEW_VALUE ;;
  }

  dimension: status_change_number {
    type: string
    sql: ${TABLE}.STATUS_CHANGE_NUMBER ;;
  }

  dimension: pk {
    primary_key: yes
    sql: ${id} || ${status_change_number} ;;
  }

  set: detail {
    fields: [
      id,
      property,
      ticket_id,
      updater_id,
      via,
      new_value,
      status_change_number
    ]
  }
}

view: _ticket_history {
  derived_table: {
   sql: SELECT * FROM ticket_history where Property = 'status' ;;
  }

  dimension: id {
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: new_value {
    type: string
    sql: ${TABLE}.new_value ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.property ;;
  }

  dimension: ticket_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.ticket_id ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp ;;
  }

  dimension: updater_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.updater_id ;;
  }

  dimension: via {
    type: string
    sql: ${TABLE}.via ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

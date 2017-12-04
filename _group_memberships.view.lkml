view: _group_memberships {
  sql_table_name: zendesk.group_memberships ;;



  dimension: _default {
    type: yesno
    sql: ${TABLE}._default ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: default {
    type: yesno
    sql: ${TABLE}."default" ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: group_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.group_id ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: user_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

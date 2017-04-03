view: d_time {
  sql_table_name: ZENDESK.D_TIME ;;

  dimension: day {
    type: string
    sql: ${TABLE}.DAY ;;
  }

  dimension_group: day {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.DAY_DATE ;;
  }

  dimension: day_of_week {
    type: string
    sql: ${TABLE}.DAY_OF_WEEK ;;
  }

  dimension: day_of_year {
    type: string
    sql: ${TABLE}.DAY_OF_YEAR ;;
  }

  dimension: hour {
    type: string
    sql: ${TABLE}.HOUR ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.MONTH ;;
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}.QUARTER ;;
  }

  dimension: time_id {
    type: string
    sql: ${TABLE}.TIME_ID ;;
  }

  dimension: week {
    type: string
    sql: ${TABLE}.WEEK ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.YEAR ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

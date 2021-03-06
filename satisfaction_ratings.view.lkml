view: satisfaction_ratings {
  sql_table_name: ZENDESK.SATISFACTION_RATING ;;

  dimension: assignee_id {
    type: string
    sql: ${TABLE}.ASSIGNEE_ID ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time,date,week,month]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: group_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.GROUP_ID ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: requester_id {
    type: string
    sql: ${TABLE}.REQUESTER_ID ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.SCORE ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension_group: updated_at {
    type: time
    timeframes: [time,date,week,month]
    sql: ${TABLE}.UPDATED_AT ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  measure: count {
    type: count
    drill_fields: [id, groups.id, groups.name, tickets.id]
  }

  measure: count_good_ratings {
    type: count
    drill_fields: [id, groups.id, groups.name, tickets.id]
    filters: {
      field: score
      value: "good"
    }
  }
  measure: count_bad_ratings {
    type: count
    filters: {
      field: score
      value: "bad"
    }
  }

  measure: satisfaction_percentage {
    type: number
    sql: CASE WHEN (${count_good_ratings} + ${count_bad_ratings} = 0)
          THEN NULL
          ELSE (${count_good_ratings}/(${count_good_ratings}+${count_bad_ratings}))*100
         END;;
  }
}

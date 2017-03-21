view: satisfaction_ratings {
  sql_table_name: ZENDESK.SATISFACTION_RATINGS ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

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

  dimension: updated_at {
    type: string
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
  measure: count_surveys_replied {
    type: count
    filters: {
      field: score
      value: "good"
    }
    filters: {
      field: score
      value: "bad"
    }
  }
}

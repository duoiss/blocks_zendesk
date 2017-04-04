view: ticket_resolution_calc {
  sql_table_name: ZENDESK.TICKET_RESOLUTION_CALC ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.ASSIGNEE ;;
  }

  dimension: assignee_id {
    type: string
    sql: ${TABLE}.ASSIGNEE_ID ;;
  }

  dimension: closed_time {
    type: string
    sql: ${TABLE}.CLOSED_TIME ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: due_at {
    type: string
    sql: ${TABLE}.DUE_AT ;;
  }

  dimension: effective_open_time {
    type: string
    sql: ${TABLE}.EFFECTIVE_OPEN_TIME ;;
  }

  dimension: effictive_close_time {
    type: string
    sql: ${TABLE}.EFFICTIVE_CLOSE_TIME ;;
  }

  dimension: effictive_time_to_resolve_hours {
    type: string
    sql: ${TABLE}.EFFICTIVE_TIME_TO_RESOLVE_HOURS ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.EXTERNAL_ID ;;
  }

  dimension: forum_topic_id {
    type: string
    sql: ${TABLE}.FORUM_TOPIC_ID ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."GROUP" ;;
  }

  dimension: group_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.GROUP_ID ;;
  }

  dimension: has_incidents {
    type: yesno
    sql: ${TABLE}.HAS_INCIDENTS ;;
  }

  dimension: organization_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ORGANIZATION_ID ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.PRIORITY ;;
  }

  dimension: problem_id {
    type: string
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.RECIPIENT ;;
  }

  dimension: requester_id {
    type: string
    sql: ${TABLE}.REQUESTER_ID ;;
  }

  dimension: resolve_time {
    type: string
    sql: ${TABLE}.RESOLVE_TIME ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.SUBJECT ;;
  }

  dimension: submitter_id {
    type: string
    sql: ${TABLE}.SUBMITTER_ID ;;
  }

  dimension: ticket_form_id {
    type: string
    sql: ${TABLE}.TICKET_FORM_ID ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: ticket_type {
    type: string
    sql: ${TABLE}.TICKET_TYPE ;;
  }

  dimension: time_in_hours_ {
    type: number
    sql: ${TABLE}.TIME_IN_HOURS_ ;;
  }

  dimension: time_to_resolve_hours {
    type: string
    sql: ${TABLE}.TIME_TO_RESOLVE_HOURS ;;
  }

  dimension: transfer_to_ {
    type: string
    sql: ${TABLE}.TRANSFER_TO_ ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: updated_at {
    type: string
    sql: ${TABLE}.UPDATED_AT ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.VIA_CHANNEL ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      organizations.id,
      organizations.name,
      groups.id,
      groups.name,
      tickets.id
    ]
  }
}

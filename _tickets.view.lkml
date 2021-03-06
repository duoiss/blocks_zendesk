view: _tickets {
  sql_table_name: zendesk.ticket ;;

  dimension: assignee_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.assignee_id ;;
  }

  dimension: bug {
    type: yesno
    sql: ${TABLE}.bug ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: description {
    sql: ${TABLE}.description ;;
  }

  dimension_group: due {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.due_at ;;
  }

  dimension: external_id {
    sql: ${TABLE}.external_id ;;
  }

  dimension: forum_topic_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.forum_topic_id ;;
  }

  dimension: group_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.group_id ;;
  }

  dimension: has_incidents {
    type: yesno
    sql: ${TABLE}.has_incidents ;;
  }

  dimension: id {
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: organization_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.organization_id ;;
  }

  dimension: priority {
    sql: ${TABLE}.priority ;;
  }

  dimension: problem_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.problem_id ;;
  }

  dimension: recipient {
    sql: ${TABLE}.recipient ;;
  }

  dimension: requester_id {
    description: "the requester is the customer who initiated the ticket"
    type: number
    value_format_name: id
    sql: ${TABLE}.requester_id ;;
  }

  dimension: requester_locale_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.requester_locale_id ;;
  }

  dimension: status {
    sql: ${TABLE}.status ;;
  }

  ## depending on use, either this field or "via_channel" will represent the channel the ticket came through
  dimension: subject {
    sql: ${TABLE}.subject ;;
  }

  ## The submitter is always the first to comment on a ticket
  dimension: submitter_id {
    description: "a submitter is either a customer or an agent submitting on behalf of a customer"
    type: number
    value_format_name: id
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: team_progress {
    type: string
    sql: ${TABLE}.TEAM_PROGRESS ;;
  }

  dimension: ticket_form_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.ticket_form_id ;;
  }

  dimension: ticket_category_iss {
    type: string
    sql: ${TABLE}.CUSTOM_TICKET_CATEGORY_ISS_ ;;
  }

  dimension: ticket_category_security {
    type: string
    sql: ${TABLE}.TICKET_CATEGORY_SECURITY_ ;;
  }

  dimension: ticket_category_compliance {
    type: string
    sql: ${TABLE}.TICKET_CATEGORY_COMPLIANCE_ ;;
  }

  dimension: time_in_hours {
    type: number
    sql: ${TABLE}.time_in_hours_ ;;
  }

  dimension: type {
    sql: ${TABLE}.type ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: url {
    sql: ${TABLE}.url ;;
  }

  dimension: via_channel {
    sql: ${TABLE}.via_channel ;;
  }

  measure: count {
    type: count_distinct
    sql: ${tickets.id} ;;
    drill_fields: [id,type,ticket_category_iss,created_month]
  }

  measure: time_in_hours_total {
    type: sum
    sql: ${time_in_hours} ;;
  }
}

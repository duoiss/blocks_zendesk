connection: "snowflake_zendesk"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: tickets {
  join: category {
    sql_on: ${tickets.group_id} = ${category.id} ;;
    relationship: many_to_one
  }

  join: category_memberships {
    sql_on: ${category_memberships.group_id} = ${category.id} ;;
    relationship: one_to_many
  }

  join: organizations {
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: assignee {
    from: users
    sql_on: ${tickets.assignee_id} = ${assignee.id} ;;
    relationship: many_to_one
  }

  join: ticket_assignee_facts {
    sql_on: ${tickets.assignee_id} = ${ticket_assignee_facts.assignee_id} ;;
    relationship: many_to_one
  }

  join: ticket_status_history  {
    view_label: "Ticket Status History"
    sql_on: ${ticket_status_history.property} = 'status' AND ${ticket_history.ticket_id} = ${tickets.id}  ;;
    relationship: many_to_one
  }

  join: ticket_history {
    sql_on: ${ticket_history.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join:  ticket_tag_history {
    view_label: "Ticket Tags"
    sql_on: ${ticket_tag_history.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
    fields: [count, tag, timestamp, action]
  }

}

## Create "ticket_history" as new explore, because not all tickets have a history, so left_joining
explore: ticket_history {
  join: tickets {
    sql_on: ${ticket_history.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }
  join: category {
    sql_on: ${tickets.group_id} = ${category.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_history_audit {}

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

  join: satisfaction_ratings {
    sql_on: ${tickets.id} = ${satisfaction_ratings.ticket_id} ;;
    relationship: one_to_one
  }

  join: ticket_assignee_facts {
    sql_on: ${tickets.assignee_id} = ${ticket_assignee_facts.assignee_id} ;;
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

  join: ticket_resolution_calc {
    sql_on: ${ticket_resolution_calc.id} = ${tickets.id} ;;
    relationship: one_to_one
  }
}

explore: f_zd_ticket {
  join: tickets {
    sql_on: ${f_zd_ticket.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: ticket_history {
    sql_on: ${ticket_history.ticket_id} = ${tickets.id};;
    relationship: many_to_one
  }

  join: d_time {
    sql_on: ${f_zd_ticket.time_id} = ${d_time.time_id} ;;
    relationship: many_to_one
  }

  join: d_ticket {
    sql_on: ${d_ticket.ticket_id} = ${f_zd_ticket.ticket_id} ;;
    relationship: many_to_one
  }
}

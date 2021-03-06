include: "_tickets.view.lkml"
include: "_ticket_history.view.lkml"
include: "_ticket_tag_history.view.lkml"
include: "_users.view.lkml"
include: "_group_memberships.view.lkml"
include: "_groups.view.lkml"
include: "_organizations.view.lkml"
include: "ticket_history_state.view.lkml"

view: organizations {
  extends: [_organizations]
}

view: category {
  extends: [_groups]
}

view: category_memberships {
  extends: [_group_memberships]
}

view: users {
  extends: [_users]
}

view: ticket_history {
  extends: [_ticket_history]
  ## The SQL in this dimensions should be updated to reflect whatever your business
  dimension: number_of_agent_touches {
    ## considers and "agent touch"
    type: number
    hidden: yes
    sql: CASE
      WHEN ${new_value} IN ('true','false','incident') THEN 1
      ELSE 0
      END
       ;;
  }

  measure: total_agent_touches {
    type: sum
    sql: ${number_of_agent_touches} ;;
  }

  measure: count_unique_tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
  }

  measure: average_agents_touches {
    type: average
    sql: ${number_of_agent_touches} ;;
  }
}

view: tickets {
  extends: [_tickets]

####### Start time to response logic
## Strategy is to
## 1. Case created and resolution timestamps to only be between 8 and 6
## 2. Hour diff those fields
## 3. Date diff those fields using this crazy pattern to exclude weekends
##      https://discourse.looker.com/t/how-to-count-only-weekdays-between-two-dates/3345
## 4. Hour diff (2) plus 16-8*Date diff (3)
## The dimension group created is referenced multiple places but doesn't exist
## added here by Daniel 3/28
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, hour_of_day, month_num, day_of_month, day_of_week, week, month, quarter, year]
    sql: ${TABLE}.created_at::timestamp ;;
  }

  ## Normalize the times into working hours
  dimension_group: created_adjusted  {
    type:  time
#     hidden: yes
    timeframes: [raw, date, time, hour_of_day, minute]
    sql: case when date_part(hour,${created_raw}) <= 9
                then TIMESTAMP_FROM_PARTS(to_date(${created_raw}), '09:00:00')
              when date_part(hour,${created_raw}) >= 20
                then TIMESTAMP_FROM_PARTS(DATEADD(DAY, 1, ${created_raw}), '09:00:00')
              else ${created_raw} end  ;;
  }

  dimension_group: resolution_adjusted  {
    type:  time
 #   hidden: yes
    timeframes: [raw, date,month, time,hour_of_day]
    sql: case when date_part(hour,${resolution_raw}) >= 20
               then TIMESTAMP_FROM_PARTS(DATEADD(DAY, 1, ${resolution_raw}), '09:00:00')
              when date_part(hour,${resolution_raw}) <= 9
               then TIMESTAMP_FROM_PARTS(to_date(${resolution_raw}), '09:00:00')
               else ${resolution_raw} end  ;;
  }

  ## Number of hours between the adjusted times
  dimension: hours_to_resolve {
    type: number
    hidden: yes
    sql: (${resolution_adjusted_hour_of_day}-${created_adjusted_hour_of_day});;
  }

  # Number of minutes between the adjusted times
  dimension: minutes_to_resolve {
    type: number
    hidden: yes
    sql: (${hours_to_resolve})*60.0
         + (extract(minute from ${resolution_adjusted_raw}) - extract(minute from ${created_adjusted_raw})) ;;
  }


  ## Days between without weekends.  We multiply this by 16-8 and add to the hour diff
  dimension: days_between_response_no_weekends {
    type:  number
    hidden: yes
    sql:
        DATEDIFF('day',${created_adjusted_raw},${resolution_adjusted_raw}) - ((FLOOR(DATEDIFF('day', ${created_adjusted_raw}, ${resolution_adjusted_raw}) / 7) * 2) +
        CASE WHEN DATE_PART(dow, ${created_adjusted_raw}) - DATE_PART(dow, ${resolution_adjusted_raw}) IN (1, 2, 3, 4, 5) AND DATE_PART(dow, ${resolution_adjusted_raw}) != 0
        THEN 2 ELSE 0 END  +
        CASE WHEN DATE_PART(dow, ${created_adjusted_raw}) != 0 AND DATE_PART(dow, ${resolution_adjusted_raw}) = 0
        THEN 1 ELSE 0 END +
        CASE WHEN DATE_PART(dow, ${created_adjusted_raw}) = 0 AND DATE_PART(dow, ${resolution_adjusted_raw}) != 0
        THEN 1 ELSE 0 END) ;;
  }

  ## This is the field that adds up the working hour time to response
  dimension: time_diff_to_resolve {
    type: number
    description: "Total working it took to resolve a ticket"
    sql:  (${hours_to_resolve} + (${days_between_response_no_weekends}*11.0)) ;;
  }

  dimension: time_diff_to_resolve_in_minutes {
    type: number
    sql: (${minutes_to_resolve} +  (${days_between_response_no_weekends}*11.0*60.0)) ;;
  }

  dimension: time_to_resolve_in_hours_float {
    type: number
    sql: (${time_diff_to_resolve_in_minutes}/60) ;;
  }

  dimension_group: resolution {
    type: time
    timeframes: [raw,date,time,month]
    sql:CASE
      WHEN
        (${ticket_history_state.property}='status'
        AND (${ticket_history_state.new_value} IN ('solved')))
      THEN  ${ticket_history_state.timestamp_time}::timestamp
      else null
      END;;
  }

  dimension: less_than_8_hours_to_resolve {
    type: yesno
    sql: CASE
          WHEN (${time_to_resolve_in_hours_float} < 8)
            THEN TRUE
          ELSE FALSE
         END;;
  }

################### End working hour response logic ###################

  dimension: is_backlogged {
    type: yesno
    sql: ${status} = 'pending' ;;
  }

  dimension: is_new {
    type: yesno
    sql: ${status} = 'new' ;;
  }

  dimension: is_open {
    type: yesno
    sql: ${status} = 'open' ;;
  }

  ### THIS ASSUMES NO DISTINCTION BETWEEN SOLVED AND CLOSED
  dimension: is_solved {
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed';;
  }

  dimension: subject_category {
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }


  ############ CHAT FIELDS: INCLUDE ONLY IF YOUR ZENDESK APP UTILIZES CHAT ###########

  # Chat times are based off the 'description' column until Zopim's integration is updated. This is because
  # the timestamps Zopim uses are inconsistent w/r/t data structure and timezone conversions

  dimension: is_chat {
    type: yesno
    sql: POSITION('Chat started on ' IN ${description}) > 0
      ;;
  }

  dimension: chat_start_time_string {
    hidden: yes
    sql: CASE
        WHEN POSITION('Chat started on ' IN ${description}) > 0
          THEN SUBSTRING(${description}, POSITION('Chat started on ' IN ${description}) + 16, 19)
      END
       ;;
  }

  dimension: chat_start_date_no_tz_convert {
    type: date
    hidden: yes
    convert_tz: no
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0 OR POSITION('AM' IN ${chat_start_time_string}) > 0
        THEN ${chat_start_time_string}::timestamp
      END
       ;;
  }

  dimension_group: chat_start {
    type: time
    timeframes: [date,week,month,time,day_of_week,hour_of_day]
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0 OR POSITION('AM' IN ${chat_start_time_string}) > 0
        THEN ${chat_start_time_string}::timestamp
      END
       ;;
  }

  ## runs off the last time a comment was made by either a customer or an internal user
  # can be thrown off if customers stay on between separate chats
  dimension: chat_end_time_string {
    hidden: yes
    sql: CONCAT(${chat_start_date_no_tz_convert}, CONCAT(' ',
        LEFT(RIGHT(${description}, POSITION(')M' IN SUBSTRING(REVERSE(${description}),
            POSITION(')M' IN SUBSTRING(REVERSE(${description}), POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
            POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
                POSITION(')M' IN SUBSTRING(REVERSE(${description}), POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
                POSITION(')M' IN REVERSE(${description})) + 11), 11)
        )
      )
       ;;
  }

  dimension_group: chat_end {
    type: time
    timeframes: [date, time, hour_of_day]
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    # assumes chats will not run from AM day 1 to AM day 2
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0  AND POSITION('AM' IN ${chat_end_time_string}) > 0
        THEN DATEADD(hour, 24, ${chat_end_time_string}::timestamp)
        ELSE ${chat_end_time_string}::timestamp
      END
       ;;
  }

  dimension: chat_duration_seconds {
    type: number
    #     hidden: true
    sql: DATEDIFF(second, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) ;;
  }

  dimension: chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: number
    sql: ${chat_duration_seconds}/60 ;;
  }

  dimension: chat_duration_minutes_tier {
    #     hidden: true
    type: tier
    tiers: [0,5,10,20,40,60,80,100,120,140,160,180,200,300,400,500,600]
    sql: ${chat_duration_minutes} ;;
  }

  ## Assumes working chat hours from 8am-6pm
  dimension: first_reply_time_chat {
    label: "First Reply Time (Chat)"
    description: "Time to first reponse; assumes chat does not last longer than 2 days or chat becomes null"
    ## does not account for chats lasting longer than 2 days
    type: number
    sql: CASE
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) < 1 THEN DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp)
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) = 1 THEN (DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) - 840)
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) = 2 THEN (DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) - 1740)
      ELSE NULL
      END
       ;;
  }

  ## Assumes working  hours from 8am-6pm
  dimension: first_reply_time_email {
    label: "First Reply Time (Email)"
    description: "Time to first reponse; assumes lag not last longer than 2 days or chat becomes null"
    ## does not account for chats lasting longer than 2 days
    type: number
    sql: CASE
      WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) < 1 THEN DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp)
      WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) = 1 THEN (DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp) - 840)
      WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) = 2 THEN (DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp) - 1740)
      ELSE NULL
      END
       ;;
  }

  dimension: first_reply_time_chat_tiers {
    type: tier
    tiers: [0,5,10,20,40,60,90,120,180,240,300,360,420]
    sql: ${first_reply_time_chat} ;;
  }

  measure: count_resolution_time_less_than_8 {
    type: count
    filters: {
      field: less_than_8_hours_to_resolve
      value: "yes"
    }
  }

  measure: percentage_of_tickets_less_than_8_hours_to_solve {
    type: number
    sql: (${count_resolution_time_less_than_8}/${count_solved_tickets})*100 ;;
  }

  measure: sum_of_resolution_in_hours {
    type: sum
    sql: ${time_to_resolve_in_hours_float};;
    filters: {
      field: is_solved
      value: "yes"
    }
  }

  measure: mean_time_to_resolve {
    type: number
    sql: round(${sum_of_resolution_in_hours}/${count_solved_tickets},2)  ;;
  }

  measure: count_backlogged_tickets {
    type: count

    filters: {
      field: is_backlogged
      value: "Yes"
    }
  }

  measure: count_new_tickets {
    type: count

    filters: {
      field: is_new
      value: "Yes"
    }
  }

  measure: count_open_tickets {
    type: count

    filters: {
      field: is_open
      value: "Yes"
    }
  }

  measure: count_solved_tickets {
    type: count
#     sql: ${id} ;;

    filters: {
      field: is_solved
      value: "Yes"
    }
  }

  measure: average_chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: average
    sql: ${chat_duration_minutes} ;;
  }

  measure: total_chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: sum
    sql: ${chat_duration_minutes} ;;
  }

  measure: average_first_reply_time_chat {
    label: "Average First Reply Time Chat (Minutes)"
    type: average
    sql: ${first_reply_time_chat} ;;
  }

  measure: total_first_reply_time_chat {
    label: "Total First Reply Time Chat (Minutes)"
    description: "Does not make sense to aggregate response time over anything other than ticket number"
    type: sum
    sql: ${first_reply_time_chat} ;;
  }

  measure: average_first_reply_time_email {
    label: "Average First Reply Time Email (Hours)"
    type: average
    sql: ${first_reply_time_email}/60 ;;
  }

  measure: total_first_reply_time_email {
    label: "Total First Reply Time Email (Hours)"
    description: "Does not make sense to aggregate response time over anything other than ticket number"
    type: sum
    sql: ${first_reply_time_email}/60 ;;
  }

  measure: count_chats {
    type: count

    filters: {
      field: is_chat
      value: "yes"
    }
  }

  measure: count_non_chats {
    label: "Count Non-Chats"
    type: count

    filters: {
      field: is_chat
      value: "No"
    }
  }

  ############ VOICE FIELDS: INCLUDE ONLY IF YOUR ZENDESK APP UTILIZES VOICE CAPABILITIES  ###########

  dimension: is_incoming_call {
    type: yesno
    sql: ${description} ILIKE '%Call From%' ;;
  }

  dimension: is_outgoing_call {
    type: yesno
    sql: ${description} ILIKE '%Call To%' ;;
  }

  dimension: is_abandoned {
    sql: CASE
      WHEN ${description} ILIKE '%Call FROM%'
      AND ${description} NOT ILIKE '%Answered by:%'
      THEN 'Yes' ELSE 'No'
      END
       ;;
  }

  #   - dimension: weekend_call_time
  #     sql: |
  #          CASE
  #          WHEN EXTRACT(doy FROM ${created_time}::timestamp) < 68 THEN ${created_time}::timestamp

  dimension: weekend_call {
    type: yesno
    sql: ${created_day_of_week} ILIKE 'Sunday' OR ${created_day_of_week}  ILIKE 'Saturday' ;;
  }

  measure: incoming_call_count {
    type: count

    filters: {
      field: is_incoming_call
      value: "Yes"
    }
  }

  measure: outgoing_call_count {
    type: count

    filters: {
      field: is_outgoing_call
      value: "Yes"
    }
  }

  measure: abandoned_call_count {
    type: count

    filters: {
      field: is_abandoned
      value: "Yes"
    }

    filters: {
      field: weekend_call
      value: "No"
    }
  }

  measure: answered_call_count {
    type: count

    filters: {
      field: is_abandoned
      value: "No"
    }

    filters: {
      field: weekend_call
      value: "No"
    }
  }
}

view:  ticket_tag_history {
  extends: [_ticket_tag_history]
}

### SATISFACTION FIELDS - TO BE INCLUDED ONLY IF YOUR ZENDESK APP UTILIZES SATISFACTION SCORING ###


#   - dimension: satisfaction_rating_percent_tier
#     type: tier
#     tiers: [10,20,30,40,50,60,70,80,90]
#     sql: ${satisfaction_rating}

#   - measure: average_satisfaction_rating
#     type: avg
#     sql: ${satisfaction_rating}
#     value_format: '#,#00.00%'

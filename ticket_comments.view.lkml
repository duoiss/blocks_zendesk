view: ticket_comments {
  sql_table_name: ZENDESK.TICKET_COMMENTS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: author_id {
    type: number
    sql: ${TABLE}.AUTHOR_ID ;;
  }

  dimension: body {
    type: string
    sql: ${TABLE}.BODY ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: metadata_system_client {
    type: string
    sql: ${TABLE}.METADATA_SYSTEM_CLIENT ;;
  }

  dimension: metadata_system_ip_address {
    type: string
    sql: ${TABLE}.METADATA_SYSTEM_IP_ADDRESS ;;
  }

  dimension: metadata_system_latitude {
    type: number
    sql: ${TABLE}.METADATA_SYSTEM_LATITUDE ;;
  }

  dimension: metadata_system_location {
    type: string
    sql: ${TABLE}.METADATA_SYSTEM_LOCATION ;;
  }

  dimension: metadata_system_longitude {
    type: number
    sql: ${TABLE}.METADATA_SYSTEM_LONGITUDE ;;
  }

  dimension: metadata_system_message_id {
    type: string
    sql: ${TABLE}.METADATA_SYSTEM_MESSAGE_ID ;;
  }

  dimension: metadata_trusted {
    type: yesno
    sql: ${TABLE}.METADATA_TRUSTED ;;
  }

  dimension: public {
    type: yesno
    sql: ${TABLE}.PUBLIC ;;
  }

  dimension: public_comment {
    type: yesno
    sql: ${TABLE}.PUBLIC_COMMENT ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.TICKET_ID ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.VIA_CHANNEL ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

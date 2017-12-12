- dashboard: secops_quarterly
  title: SecOps Quarterly Dashboard
  layout: newspaper
  refresh_interval: 5 minutes
  embed_style:
    background_color: "#f6f8fa"
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - name: Security@ - New vs Solved Tickets
    title: Security@ - New vs Solved Tickets
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.count_num_opened
    - f_zd_ticket.count_num_resolved
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Security
      #d_time.day_month: 3 months
      ticket_tag_history.tag: "-%internal^_push^_phishing%"
    sorts:
    - d_time.day_month desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_labels:
      f_zd_ticket.count_num_opened: New Tickets
      f_zd_ticket.count_num_resolved: Resolved Tickets
    series_colors:
      f_zd_ticket.count_num_opened: "#666c6e"
      f_zd_ticket.count_num_resolved: "#76bd5d"
    y_axes:
    - label: ''
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 4
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: f_zd_ticket.count_num_opened
        name: New Tickets
      - id: f_zd_ticket.count_num_resolved
        name: Resolved Tickets
    x_axis_reversed: true
    x_axis_datetime_label: "%b %y"
    x_axis_label: ''
    label_value_format: ''
    label_color:
    - black
    font_size: '14'
    x_axis_datetime_tick_count:
    listen:
      Select Month: d_time.day_month
    row: 0
    col: 0
    width: 6
    height: 6
  - name: Compliance@ - Mean Time to Resolve (In Hrs)
    title: Compliance@ - Mean Time to Resolve (In Hrs)
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.hours_to_resolve_avg
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Compliance
      #d_time.day_month: 3 months
    sorts:
    - d_time.day_month desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 21
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      f_zd_ticket.hours_to_resolve_avg: "#76bd5d"
    label_color:
    - black
    x_axis_reversed: true
    x_axis_datetime_label: "%b  %y"
    y_axes:
    - label: Mean Time to Resolve (In Hrs)
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: f_zd_ticket.hours_to_resolve_avg
        name: F Zd Ticket Hours to Resolve Avg
    label_value_format: '0.00'
    font_size: '14'
    listen:
      Select Month: d_time.day_month
    row: 6
    col: 12
    width: 6
    height: 6
  - name: Compliance@ - Mean Time to Respond (In Hrs)
    title: Compliance@ - Mean Time to Respond (In Hrs)
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.hours_to_first_response_avg
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Compliance
      #d_time.day_month: 3 months
    sorts:
    - d_time.day_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      f_zd_ticket.hours_to_first_response_avg: "#76bd5d"
    label_color:
    - black
    y_axes:
    - label: Avg. time to Respond (In Hours)
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '0'
      series:
      - id: f_zd_ticket.hours_to_first_response_avg
        name: F Zd Ticket Hours to First Response Avg
    x_axis_datetime_label: "%b  %y"
    label_value_format: '0.00'
    x_axis_label: Month
    font_size: '14'
    listen:
      Select Month: d_time.day_month
    row: 6
    col: 6
    width: 6
    height: 6
  - name: Compliance - New vs Solved Tickets
    title: Compliance - New vs Solved Tickets
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.count_num_opened
    - f_zd_ticket.count_num_resolved
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Compliance
      #d_time.day_month: 3 months
    sorts:
    - d_time.day_month desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_labels:
      f_zd_ticket.count_num_opened: New Tickets
      f_zd_ticket.count_num_resolved: Resolved Tickets
    series_colors:
      f_zd_ticket.count_num_opened: "#666c6e"
      f_zd_ticket.count_num_resolved: "#76bd5d"
    label_rotation:
    y_axes:
    - label: ''
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 4
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: f_zd_ticket.count_num_opened
        name: New Tickets
      - id: f_zd_ticket.count_num_resolved
        name: Resolved Tickets
    x_axis_reversed: true
    x_axis_datetime_label: "%b %y"
    x_axis_label: ''
    label_value_format: ''
    label_color:
    - black
    font_size: '14'
    x_axis_datetime_tick_count:
    listen:
      Select Month: d_time.day_month
    row: 6
    col: 0
    width: 6
    height: 6
  - name: Security@ - Tickets By Category Type
    title: Security@ - Tickets By Category Type
    model: zendesk
    explore: tickets
    type: looker_bar
    fields:
    - tickets.count
    - ticket_tag_history.tag
    filters:
      category.name: Security
      ticket_tag_history.tag: "-internal^_push^_phishing"
      tickets.created_month: 1 months
    sorts:
    - tickets.count desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      tickets.count: "#76bd5d"
    series_labels: {}
    y_axes:
    - label: Count Per Category
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: tickets.count
        name: Tickets Count
    x_axis_reversed: true
    label_color:
    - black
    x_axis_datetime_label: ''
    font_size: '14'
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    label_rotation: 0
    row: 0
    col: 18
    width: 6
    height: 6
  - name: Compliance@ - Tickets By Category Type
    title: Compliance@ - Tickets By Category Type
    model: zendesk
    explore: tickets
    type: looker_bar
    fields:
    - tickets.count
    - tickets.ticket_category_compliance
    filters:
      category.name: Compliance
      tickets.created_month: 1 months
    sorts:
    - tickets.count desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      tickets.count: "#76bd5d"
    series_labels: {}
    y_axes:
    - label: Count Per Category
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: tickets.count
        name: Tickets Count
    x_axis_reversed: true
    label_color:
    - black
    x_axis_datetime_label: ''
    font_size: '14'
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    label_rotation: 0
    row: 6
    col: 18
    width: 6
    height: 6
  - name: Security@ - Mean Time to Respond (In Hrs)
    title: Security@ - Mean Time to Respond (In Hrs)
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.hours_to_first_response_avg
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Security
      #d_time.day_month: 3 months
      ticket_tag_history.tag: "-%internal^_push^_phishing%"
    sorts:
    - d_time.day_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      f_zd_ticket.hours_to_first_response_avg: "#76bd5d"
    label_color:
    - black
    y_axes:
    - label: Avg. time to Respond (In Hours)
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '0'
      series:
      - id: f_zd_ticket.hours_to_first_response_avg
        name: F Zd Ticket Hours to First Response Avg
    x_axis_datetime_label: "%b  %y"
    label_value_format: '0.00'
    x_axis_label: Month
    font_size: '14'
    listen:
      Select Month: d_time.day_month
    row: 0
    col: 6
    width: 6
    height: 6
  - name: Security@ - Mean Time to Resolve (In Hrs)
    title: Security@ - Mean Time to Resolve (In Hrs)
    model: zendesk
    explore: f_zd_ticket
    type: looker_column
    fields:
    - d_time.day_month
    - f_zd_ticket.hours_to_resolve_avg
    fill_fields:
    - d_time.day_month
    filters:
      d_ticket.groupname: Security
      #d_time.day_month: 3 months
      ticket_tag_history.tag: "-%internal^_push^_phishing%"
    sorts:
    - d_time.day_month desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 21
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      f_zd_ticket.hours_to_resolve_avg: "#76bd5d"
    label_color:
    - black
    x_axis_reversed: true
    x_axis_datetime_label: "%b  %y"
    y_axes:
    - label: Mean Time to Resolve (In Hrs)
      maxValue:
      minValue: 0
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: f_zd_ticket.hours_to_resolve_avg
        name: F Zd Ticket Hours to Resolve Avg
    label_value_format: '0.00'
    font_size: '14'
    listen:
      Select Month: d_time.day_month
    row: 0
    col: 12
    width: 6
    height: 6
  filters:
  - name: Select Month
    title: Select Month
    type: date_filter
    default_value: 3 months
    model:
    explore:
    field:
    listens_to_filters: []
    allow_multiple_values: true
    required: false

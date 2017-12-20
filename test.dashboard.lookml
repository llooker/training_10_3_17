- dashboard: test
  title: Business Pulse
  layout: newspaper
  elements:
  - name: Average Sale Price
    title: Average Sale Price
    model: ecommerce_data
    explore: order_items
    type: single_value
    fields:
    - order_items.average_sale_price
    filters:
      order_items.created_date: 90 days
    sorts:
    - order_items.average_sale_price desc
    limit: 500
    query_timezone: America/Los_Angeles
    color_palette: Default
    font_size: medium
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    text_color: black
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 0
    col: 6
    width: 6
    height: 3
  - name: Average Spend Per User
    title: Average Spend Per User
    model: ecommerce_data
    explore: order_items
    type: single_value
    fields:
    - order_items.average_spend_per_user
    filters:
      inventory_items.created_date: 90 days
    sorts:
    - order_items.average_sale_price desc
    limit: 500
    query_timezone: America/Los_Angeles
    color_palette: Default
    font_size: medium
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    text_color: black
    listen:
      Order Date: order_items.created_date
      Brand: products.brand
      State: users.state
      City: users.city
    row: 0
    col: 18
    width: 6
    height: 3
  - name: Total Sales, Year Over Year
    title: Total Sales, Year Over Year
    model: ecommerce_data
    explore: order_items
    type: looker_line
    fields:
    - order_items.created_year
    - order_items.created_month_num
    - order_items.total_revenue
    pivots:
    - order_items.created_year
    filters:
      order_items.total_revenue: ">20000"
      order_items.created_date: 48 months ago for 48 months
    sorts:
    - order_items.created_year desc
    - order_items.created_month_num
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_null_points: false
    limit_displayed_rows: false
    y_axis_scale_mode: linear
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 3
    col: 0
    width: 12
    height: 6
  - name: Marketing Channel by User Demographic
    title: Marketing Channel by User Demographic
    model: ecommerce_data
    explore: order_items
    type: looker_donut_multiples
    fields:
    - products.department
    - users.traffic_source
    - users.count
    pivots:
    - users.traffic_source
    filters:
      products.brand: ''
      users.state: ''
    sorts:
    - order_items.created_year desc
    - order_items.created_month_num
    - users.count_percent_of_total desc 0
    - products.department
    - users.traffic_source
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_view_names: true
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_value_labels: true
    font_size: 12
    value_labels: legend
    label_type: labPer
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 9
    col: 12
    width: 12
    height: 8
  - name: Orders by Day and Category
    title: Orders by Day and Category
    model: ecommerce_data
    explore: order_items
    type: looker_area
    fields:
    - order_items.created_date
    - products.category
    - order_items.order_item_count
    pivots:
    - products.category
    filters:
      products.category: Jeans,Accessories,Active,Dresses,Sleep & Lounge,Shorts
      order_items.created_date: 90 days
    sorts:
    - order_items.created_year desc
    - order_items.created_month_num
    - users.count_percent_of_total desc 0
    - products.department
    - users.traffic_source
    - products.category
    - order_items.created_date desc
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    color_palette: Default
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    limit_displayed_rows: false
    y_axis_scale_mode: linear
    show_null_points: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 26
    col: 0
    width: 24
    height: 10
  - name: Brand Sales
    title: Brand Sales
    model: ecommerce_data
    explore: order_items
    type: table
    fields:
    - products.brand
    - order_items.order_count
    - products.count
    - order_items.average_spend_per_user
    filters:
      order_items.created_date: 7 days
    sorts:
    - order_items.order_count desc
    limit: 10
    column_limit: 50
    query_timezone: America/New_York
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Order Date: order_items.created_date
      Brand: products.brand
      State: users.state
      City: users.city
    row: 3
    col: 12
    width: 12
    height: 6
  - name: User Count
    title: User Count
    model: ecommerce_data
    explore: order_items
    type: single_value
    fields:
    - users.count
    filters:
      users.created_date: 90 days
    sorts:
    - order_items.order_count desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    color_palette: Default
    font_size: medium
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    text_color: "#49719a"
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    note_state: expanded
    note_display: hover
    note_text: TOtal amount
    row: 0
    col: 12
    width: 6
    height: 3
  - name: Order Count By Zipcode
    title: Order Count By Zipcode
    model: ecommerce_data
    explore: order_items
    type: looker_geo_coordinates
    fields:
    - users.zip
    - order_items.order_count
    sorts:
    - order_items.order_count desc
    limit: 1000
    query_timezone: America/New_York
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    color_palette: Default
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    map: usa
    map_projection: ''
    quantize_colors: false
    loading: false
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 17
    col: 0
    width: 24
    height: 9
  - name: Revenue by Marketing Channel
    title: Revenue by Marketing Channel
    model: ecommerce_data
    explore: order_items
    type: looker_column
    fields:
    - order_items.created_week
    - order_items.total_revenue
    - users.traffic_source
    pivots:
    - users.traffic_source
    fill_fields:
    - order_items.created_week
    filters:
      order_items.created_date: 10 weeks ago for 10 weeks
    sorts:
    - order_items.created_week desc
    - users.traffic_source
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
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
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Brand: products.brand
      State: users.state
      City: users.city
    row: 9
    col: 0
    width: 12
    height: 8
  - name: Orders in the Past 90 Days
    title: Orders in the Past 90 Days
    model: ecommerce_data
    explore: order_items
    type: single_value
    fields:
    - order_items.order_item_count
    - inventory_items.created_week
    fill_fields:
    - inventory_items.created_week
    filters:
      inventory_items.created_date: 90 days
      products.brand: ''
      users.city: ''
      users.state: ''
    sorts:
    - order_items.created_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    font_size: medium
    colors:
    - "#64518A"
    - "#8D7FB9"
    - "#EA8A2F"
    - "#F2B431"
    - "#20A5DE"
    - "#57BEBE"
    - "#7F7977"
    - "#B2A898"
    - "#494C52"
    - purple
    text_color: "#49719a"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 0
    width: 6
    height: 3
  filters:
  # - name: Order Date
  #   title: Order Date
  #   type: field_filter
  #   default_value: 90 days
  #   model: ecommerce_data
  #   explore: order_items
  #   field: order_items.created_date
  #   listens_to_filters: []
  #   allow_multiple_values: true
  #   required: false
  # - name: Brand
  #   title: Brand
  #   type: field_filter
  #   default_value: ''
  #   model: ecommerce
  #   explore: order_items
  #   field: products.brand
  #   listens_to_filters: []
  #   allow_multiple_values: true
  #   required: false
  # - name: State
  #   title: State
  #   type: field_filter
  #   default_value:
  #   model: ecommerce
  #   explore: users
  #   field: users.state
  #   listens_to_filters: []
  #   allow_multiple_values: true
  #   required: false
  # - name: City
  #   title: City
  #   type: field_filter
  #   default_value:
  #   model: ecommerce
  #   explore: users
  #   field: users.city
  #   listens_to_filters:
  #   - State
  #   allow_multiple_values: true
  #   required: false

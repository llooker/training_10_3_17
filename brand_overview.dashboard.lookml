- dashboard: brand_overview
  title: Brand Overview
  layout: grid
  tile_size: 150

  rows:
    - elements: [orders_over_time]
      height: 400
    - elements: [order_by_zipcode, product_list]
      height: 400
#  filters:

  elements:

  - name: orders_over_time
    title: Orders per Month
    type: looker_line
    model: ecommerce
    explore: order_items
    dimensions: [order_items.created_month]
    measures: [order_items.order_count]
    filters:
      products.brand: Calvin Klein
    sorts: [orders.created_month desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/New_York
    stacking: ''
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
    show_null_points: true
    point_style: none
    interpolation: linear

  - name: order_by_zipcode
    title: Order Count by Zipcode
    type: looker_geo_coordinates
    model: ecommerce
    explore: order_items
    dimensions: [users.zip]
    measures: [order_items.order_count]
    sorts: [order_items.order_count desc]
    limit: '1000'
    query_timezone: America/New_York
    colors: ['#64518A', '#8D7FB9', '#EA8A2F', '#F2B431', '#20A5DE', '#57BEBE', '#7F7977',
      '#B2A898', '#494C52', purple]
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

  - name: product_list
    title: Product List
    type: table
    model: ecommerce
    explore: order_items
    dimensions: [products.name, products.brand]
    measures: [order_items.order_count, products.count, order_items.average_spend_per_user]
    sorts: [order_items.order_count desc]
    limit: '10'
    column_limit: '50'
    query_timezone: America/New_York

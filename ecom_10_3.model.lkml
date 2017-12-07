connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

map_layer: map_regions {
  file: "map.topojson"
  property_key: "region"
}


# explore: order_items_2 {
#   from: order_items
#   label: "Standalone Orders"
# }

explore: order_items {
  fields: [ALL_FIELDS*, -order_items.total_active_users]
  access_filter: {
    field: products.brand
    user_attribute: allowed_brand
  }
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

 join: user_order_facts {
   type: left_outer
   sql_on: ${user_order_facts.user_id} = ${user_id} ;;
   relationship: many_to_one
 }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

#explore: users {
#  hidden: yes
#  }
#}

connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

map_layer: map_regions {
  file: "map.topojson"
  property_key: "region"
}

explore: distribution_centers {
  hidden: yes
}

explore: events {
  hidden:  yes
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  hidden: yes
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
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

explore: products {
  hidden: yes
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

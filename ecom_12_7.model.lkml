connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: nightly_etl {
  sql_trigger: select current_date ;;
  max_cache_age: "24 hours"
}

view: ndt_user_facts {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: order_count {}
      column: total_revenue {
        field: order_items.total_revenue
      }
      column: order_item_count {}
      derived_column: rank {
        sql: rank() OVER (order by ${total_revenue}) ;;
      }
    }
    datagroup_trigger: nightly_etl
    sortkeys: ["id"]
    distribution_style: even
  }
  dimension: id {
    type: number
  }
  dimension: order_count {
    description: "A count of unique orders"
    type: number
  }
  dimension: total_revenue {
    hidden: yes
    value_format: "$#,##0.00"
    type: number
  }
  dimension: order_item_count {
    type: number
  }

  measure: avg_lifetime_rev {
    type: average
    sql: ${total_revenue} ;;
  }
}

explore: order_items {
#   fields: [ALL_FIELDS*, -order_items.profit]
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
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


}


# explore: users {
#   join: user_order_facts {
#     type: left_outer
#     sql_on: ${user_order_facts.user_id} = ${user_id} ;;
#     relationship: many_to_one
#   }
# }

# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: inventory_items {
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }

#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }

explore: ndt_user_facts {}


map_layer: map_regions {
  file: "map.topojson"
  property_key: "region"
}

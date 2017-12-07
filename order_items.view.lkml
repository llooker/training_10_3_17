view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    hidden:  yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#   dimension: pk {
#     type: string
#     sql: ${id} || '-' || ${order_id} ;;
#     primary_key: yes
#   }


  dimension: reporting_period {
    group_label: "Order Date"
    sql: CASE
        WHEN date_part('year',${created_raw}) = date_part('year',current_date)
        AND ${created_raw} < CURRENT_DATE
        THEN 'This Year to Date'

        WHEN date_part('year',${created_raw}) + 1 = date_part('year',current_date)
        AND date_part('dayofyear',${created_raw}) <= date_part('dayofyear',current_date)
        THEN 'Last Year to Date'

      END
       ;;
  }


  dimension_group: created {
    description: "When the order was created"
    type: time
    timeframes: [
      raw,
      time,
      date,
      hour_of_day,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

#
#   dimension: created_hour_of_day {
#     type: date_hour_of_day
#     sql: ${TABLE}.created_at ;;
#   }

  dimension: shift_type {
    group_label: "Created Date"
    type: string
    sql:
      CASE
        WHEN ${order_items.created_hour_of_day} or ${created_hour_of_day} > 19 THEN 'Night Shift'
        ELSE 'Day Shift'
      END
    ;;
  }



  dimension_group: delivered {
    description: "When the order was delivered"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension_group: returned {
    description: "When the order was returned"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

dimension: tax_rate {
  hidden: yes
  type: number
  sql: 0.70  ;;
}

  dimension: sale_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.sale_price  * ${tax_rate} ;;
  }

  dimension_group: shipped {
    description: "When the order was shipped"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    description: "Whether order is processing, shipped, completed, etc."
    type: string
    sql: lower(${TABLE}.status) ;;
  }

  dimension: shipping_time {
    description: "Shipping time in days"
    type: number
    #REdshift Specific
    sql: DATEDIFF(day, ${order_items.shipped_date}, ${order_items.delivered_date}) ;;
  }

## HIDDEN DIMENSIONS ##

  dimension: inventory_item_id {
  hidden:  yes
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  measure: total_active_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

# filter: currency {
#   type: string
# }

parameter: currency {
  type: string
  suggestions: ["USD","EUR","JPY"]
}

  dimension: profit {
    description: "Profit made on any one item"
    hidden:  yes
    type: number
    value_format_name: usd
    sql:
    CASE WHEN {% parameter currency %} = 'USD' THEN ${sale_price} - ${inventory_items.cost}
    ELSE (${sale_price} - ${inventory_items.cost}) * .9
    END
     ;;

  }

## MEASURES ##

measure: return_count {
  type: count
  filters: {
    field: returned_date
    value: "-NULL"
  }
  drill_fields: [user_id, order_id, returned_date]
}

measure:  return_rate {
  type: number
  sql:  ${return_count}*1.0 / NULLIF(${order_item_count},0);;
  value_format_name: percent_2
  drill_fields: [return_count, order_item_count]
}

  measure: order_item_count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [detail*]
  }

  measure: order_count {
    description: "A count of unique orders"
    type: count_distinct
    sql: ${order_id} ;;
  }

  dimension: user_attribute {
    type: string
    sql:
    '{{ _user_attributes["category"] }}'
    ;;
  }


  measure: average_sale_price {
    type: average
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [detail*]
    html:
      {% if _user_attributes["category"] == "Jeans" %}
        <p style="color:red;">{{rendered_value}}</p>
      {% else %}
        <p style="color:black;">{{rendered_value}}</p>
      {% endif %}
    ;;
  }

  measure: average_spend_per_user {
    type: number
    value_format_name: usd
    sql: 1.0 * ${total_revenue} / NULLIF(${users.count},0) ;;
  }

  measure: total_profit {
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
    drill_fields: [id, created_date, total_profit]
  }

  measure: is_greater_than_9k {
    type: yesno
    sql: ${total_profit} >= 9000 ;;
  }


  measure: average_shipping_time {
    type: average
    sql: ${shipping_time} ;;
    value_format: "0\" days\""
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}

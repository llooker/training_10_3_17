  view: user_order_facts {
    derived_table: {
      sql: SELECT
        order_items.user_id as user_id
        , COUNT(DISTINCT order_items.order_id) as lifetime_orders
        , SUM(order_items.sale_price) AS lifetime_revenue
        , MIN(NULLIF(order_items.created_at,0)) as first_order
        , MAX(NULLIF(order_items.created_at,0)) as latest_order
        , COUNT(DISTINCT DATE_TRUNC('month', NULLIF(order_items.created_at,0))) as number_of_distinct_months_with_orders
        , SUM(order_items.sale_price) AS order_value
      FROM order_items
      WHERE
        1=1
        AND {% condition my_fact_filter %} order_items.created_at  {% endcondition %}
      GROUP BY user_id
       ;;
      # sortkeys: ["user_id","lifetime_orders"]
      # distribution: "user_id"
#       sql_trigger_value: select current_date;;
#       persist_for: "24 hours"
    # datagroup_trigger: nightly_etl

    }

  filter: my_fact_filter {
    type: date
  }

    dimension_group: first_order {
      type: time
      timeframes: [date, week, month, year]
      sql: ${TABLE}.first_order ;;
    }

    dimension_group: latest_order {
      type: time
      timeframes: [date, week, month, year]
      sql: ${TABLE}.latest_order ;;
    }

    dimension: user_id {
      primary_key: yes
      #     hidden: true
      sql: ${TABLE}.user_id ;;
    }

    dimension: order_value {
      type: number
      value_format_name: usd
      sql: ${TABLE}.order_value ;;
    }

    dimension: lifetime_orders {
      type: number
      sql: ${TABLE}.lifetime_orders ;;
    }

    dimension: lifetime_orders_tier {
      type: tier
      tiers: [
        0,
        1,
        2,
        3,
        5,
        10
      ]
      sql: ${lifetime_orders} ;;
      style: integer
    }

    dimension: lifetime_revenue {
      type: number
      value_format_name: usd
      sql: ${TABLE}.lifetime_revenue ;;
    }

    dimension: lifetime_revenue_tier {
      type: tier
      tiers: [
        0,
        25,
        50,
        100,
        200,
        500,
        1000
      ]
      sql: ${lifetime_revenue} ;;
      style: integer
    }


    dimension: repeat_customer {
      description: "Lifetime Count of Orders > 1"
      type: yesno
      sql: ${lifetime_orders} > 1 ;;
    }

    dimension: distinct_months_with_orders {
      type: number
      value_format_name: decimal_0
      sql: ${TABLE}.number_of_distinct_months_with_orders ;;
    }

    measure: average_order_value {
      type: average
      value_format_name: usd
      sql:${TABLE}.order_value ;;
    }

    measure: average_lifetime_revenue {
      type: average
      value_format_name: usd
      sql: ${lifetime_revenue} ;;
    }
  }

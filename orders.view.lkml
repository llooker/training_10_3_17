 view: orders {
    derived_table: {
      sql:
      SELECT
        order_id as order_id
        , id as pk
        , created_at as created
        , status as status
        , user_id as user_id
      FROM public.order_items  AS order_items
       ;;
      sql_trigger_value: select 1 ;;
      distribution: "order_id"
      sortkeys: ["order_id"]
    }

    dimension: pk {
      sql: ${TABLE}.pk ;;
      primary_key: yes
      hidden: yes
    }


    dimension: order_id {
      type: number
      sql: ${TABLE}.order_id ;;
    }

    dimension_group: created {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        month_num,
        quarter,
        year
      ]
      sql: ${TABLE}.created ;;
    }

    dimension: status {
      type: string
      sql: ${TABLE}.status ;;
    }

    dimension: user_id {
      type: number
      sql: ${TABLE}.user_id ;;
    }

    set: detail {
      fields: [order_id, created_time, status, user_id]
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }
  }

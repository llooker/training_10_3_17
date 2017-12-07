include: "ecom_12_7_base.model.lkml"


explore: order_items_general {
  extends: [order_items]
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

}

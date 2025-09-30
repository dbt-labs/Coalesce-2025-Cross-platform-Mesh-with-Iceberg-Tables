with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

locations as (
    select * from {{ ref('stg_locations') }}
),

order_items as (
    select 
        order_id,
        sum(supply_cost) as total_supply_cost
    from {{ ref('order_items') }}
    group by order_id
),

joined as (
    select
        orders.order_id, 
        orders.location_id,
        orders.customer_id,
        orders.order_total,
        orders.tax_paid,
        orders.ordered_at,
        customers.customer_name,
        locations.location_name,
        locations.tax_rate,
        locations.opened_date,
        order_items.total_supply_cost,
        order_total - tax_paid - total_supply_cost as net_profit_per_order
    from 
       orders 
        left join customers 
            on orders.customer_id = customers.customer_id
        left join locations 
            on orders.location_id = locations.location_id
        left join order_items
            on orders.order_id = order_items.order_id
)

select * from joined
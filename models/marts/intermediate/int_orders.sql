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
    select * from {{ ref('order_items') }}
), 

aggregate_order_cost as (
    select
        order_id,
        sum(supply_cost) as total_order_supply_cost
    from
        order_items
    group by
        order_id

),

joined as (
    select
        orders.order_id, 
        orders.location_id,
        orders.customer_id,
        orders.order_total,
        orders.tax_paid,
        aggregate_order_cost.total_order_supply_cost,
        orders.ordered_at,
        customers.customer_name,
        locations.location_name,
        locations.tax_rate,
        locations.opened_date

    from 
       orders 
        left join customers 
            on orders.customer_id = customers.customer_id
        left join locations 
            on orders.location_id = locations.location_id 
        inner join aggregate_order_cost
            on orders.order_id = aggregate_order_cost.order_id    
),

net_profit_per_order as (
    select
        order_id,
        location_id,
        customer_id,
        order_total,
        tax_paid,
        total_order_supply_cost,
        (order_total - tax_paid - total_order_supply_cost) as net_profit_per_order,
        ordered_at,
        customer_name,
        location_name,
        tax_rate,
        opened_date
    from
        joined
)

select * from net_profit_per_order
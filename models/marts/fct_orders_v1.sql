{{
    config(
        enabled=false
    )
}}

with orders as (
    select * from {{ ref('int_orders') }}
),

final as (
    select 
        order_id,
        location_id,
        customer_id,
        order_total,
        tax_paid,
        net_profit_per_order,
        ordered_at,
        customer_name,
        location_name,
        tax_rate,
        opened_date,
        date_part(month, ordered_at) as ordered_month,
        date_part(day, ordered_at) as ordered_day, 
        date_part(year, ordered_at) as ordered_year
    from orders
)

select * 
from final
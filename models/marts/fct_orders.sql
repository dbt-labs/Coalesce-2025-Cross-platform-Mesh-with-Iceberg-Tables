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
        ordered_at,
        customer_name,
        location_name,
        tax_rate,
        opened_date,
        month(ordered_at) as ordered_month,
        day(ordered_at) as ordered_day, 
        year(ordered_at) as ordered_year
    from orders
)

select * 
from final
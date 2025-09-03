select
    * exclude(ordered_at),
    ordered_at::timestamp_ntz(6) as ordered_at

from {{ ref('orders') }}
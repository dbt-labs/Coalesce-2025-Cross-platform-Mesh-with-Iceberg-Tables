select

    * except(ordered_at),
    cast(ordered_at as timestamp_ntz) AS ordered_at

from {{ ref('orders') }}
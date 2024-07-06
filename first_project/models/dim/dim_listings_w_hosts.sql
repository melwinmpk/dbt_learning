WITH 
l AS (
    SELECT * FROM 
    {{ ref('dim_listings_cleansed')}}
),
h AS (
    SELECT * FROM
    {{ ref('dim_hosts_cleansed')}} 
)
SELECT 
l.listing_id,
l.listing_name,
l.room_type,
l.minimum_nights,
l.host_id,
l.price,
h.name as host_name,
h.is_superhost as host_is_superhost,
l.created_at,
GREATEST(l.updated_at,h.updated_at)
FROM l 
LEFT JOIN h ON (h.id = l.host_id)




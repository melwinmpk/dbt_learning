{{
    config(materialized = 'view')
}}
WITH src_hosts as (
    SELECT * FROM {{ ref('src_hosts')}}
)
SELECT 
id,
CASE WHEN name is NULL 
	 then 'Anonymous'
     else name end
     as name,
is_superhost,
created_at,
updated_at
FROM 
src_hosts

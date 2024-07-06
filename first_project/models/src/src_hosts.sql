WITH raw_hosts as (
    SELECT * FROM {{ source('raw','hosts')}} 
)
SELECT * FROM raw_hosts
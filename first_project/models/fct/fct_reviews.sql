{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)
SELECT 
 md5(
    CONCAT(
    coalesce(cast(listing_id as CHAR), '_dbt_utils_surrogate_key_null_'), '-' , 
    coalesce(cast(review_date as CHAR), '_dbt_utils_surrogate_key_null_') , '-' , 
    coalesce(cast(reviewer_name as CHAR), '_dbt_utils_surrogate_key_null_') , '-' , 
    coalesce(cast(comments as CHAR), '_dbt_utils_surrogate_key_null_')
    )
    ) as review_id,
src_reviews.* FROM src_reviews 
WHERE comments is not NULL 
{% if is_incremental() %}
    AND review_date > (select max(review_date) from {{ this }})
{% endif %}

-- {{ dbt_utils.generate_surrogate_key(['listing_id','review_date','reviewer_name', 'comments']) }} as review_id 
-- Melwin Note to concat strings in mysql Concat() only works this  "||" does not work

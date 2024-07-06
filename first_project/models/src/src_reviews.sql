WITH raw_reviews AS (
    SELECT * FROM dbtlearn_raw.raw_reviews
)
SELECT 
	listing_id,
    date as review_date,
    reviewer_name,
    comments,
    sentiment
FROM 
    raw_reviews
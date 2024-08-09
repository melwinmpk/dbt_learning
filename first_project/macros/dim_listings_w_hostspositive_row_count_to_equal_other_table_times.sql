{% test dim_listings_w_hostspositive_row_count_to_equal_other_table_times(model) %}
select
      count(*) as failures,
      case
        when count(*) <> 0 then 'true'
        else 'false'
      end as should_warn,
      case
        when count(*) <> 0 then 'true'
        else 'false'
      end as should_error
    from (
    with a as (
    select
        count(*) as expression
    from
        `dbtlearning_dev`.`dim_listings_w_hosts`
    ),
    b as (
    select
        count(*) as expression
    from
        `dbtlearn_raw`.`raw_listings`    -- {{source('raw','listings')}} 
    ),
    final as (
        select
            
            a.expression,
            b.expression as compare_expression,
            abs(coalesce(a.expression, 0) - coalesce(b.expression, 0)) as expression_difference,
            abs(coalesce(a.expression, 0) - coalesce(b.expression, 0))/
                nullif(a.expression * 1.0, 0) as expression_difference_percent
        from
            a cross join b  
    )
    -- DEBUG:
    -- select * from final
    select
        *
    from final
    where
        expression_difference > 0.0

    ) dbt_internal_test
{% endtest %}
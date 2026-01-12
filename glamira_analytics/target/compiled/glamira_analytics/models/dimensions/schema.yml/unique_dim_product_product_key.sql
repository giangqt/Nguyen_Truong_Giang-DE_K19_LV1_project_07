
    
    

with dbt_test__target as (

  select product_key as unique_field
  from `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_product`
  where product_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1



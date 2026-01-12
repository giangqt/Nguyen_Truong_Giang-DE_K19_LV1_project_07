
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_product`
where product_id is null



  
  
      
    ) dbt_internal_test
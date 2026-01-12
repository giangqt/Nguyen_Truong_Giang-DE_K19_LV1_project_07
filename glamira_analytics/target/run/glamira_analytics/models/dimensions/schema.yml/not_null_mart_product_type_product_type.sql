
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_type
from `stone-album-475912-b9`.`analytics_dev`.`mart_product_type`
where product_type is null



  
  
      
    ) dbt_internal_test
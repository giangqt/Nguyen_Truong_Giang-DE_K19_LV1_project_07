
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select user_id
from `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_user`
where user_id is null



  
  
      
    ) dbt_internal_test
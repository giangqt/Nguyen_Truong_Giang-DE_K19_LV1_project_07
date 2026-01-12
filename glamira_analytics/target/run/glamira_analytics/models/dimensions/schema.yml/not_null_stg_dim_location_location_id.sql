
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select location_id
from `stone-album-475912-b9`.`analytics_dev_staging`.`stg_dim_location`
where location_id is null



  
  
      
    ) dbt_internal_test
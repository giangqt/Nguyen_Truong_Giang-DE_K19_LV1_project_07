
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_day
from `stone-album-475912-b9`.`analytics_dev`.`mart_overall`
where date_day is null



  
  
      
    ) dbt_internal_test

    
    

with child as (
    select product_id as from_field
    from `stone-album-475912-b9`.`analytics_dev_dimensions`.`fact_sales_order_tt`
    where product_id is not null
),

parent as (
    select product_id as to_field
    from `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_product`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



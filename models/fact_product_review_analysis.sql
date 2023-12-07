with stg_products as 
(
    select
        product_id,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as productkey,
        product_name,
        product_department
    from {{ source('dvp_fudgemart','fm_products')}}
),
stg_customer_product_reviews as
(
    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customerkey,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as productkey,
        replace(to_date(review_date)::varchar,'-','')::int as reviewdatekey,
        avg(review_stars) as productrating
    from {{ source('dvp_fudgemart','fm_customer_product_reviews')}} 
    group by productkey,customer_id,reviewdatekey
)
select
p.*,
r.customerkey,r.reviewdatekey,r.productrating 
from stg_products p join stg_customer_product_reviews r on p.productkey=r.productkey

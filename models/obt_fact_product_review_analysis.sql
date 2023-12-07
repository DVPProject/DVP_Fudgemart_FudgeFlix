
with f_fact_product_review_analysis as (
    select * from {{ref("fact_product_review_analysis")}}
),
d_customer as (
    select * from {{ref("dim_customers")}}
),
d_date as (
    select * from {{ref('dim_date')}}
)

select
    d_customer.*,
    d_date.*,
    f.product_name, f.product_department, f.reviewdatekey, f.productrating
    from f_fact_product_review_analysis as f
    left join d_customer on f.customerkey = d_customer.customerkey
    left join d_date on f.reviewdatekey = d_date.datekey
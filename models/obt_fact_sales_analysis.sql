with f_fact_sales_analysis as (
    select * from {{ref("fact_sales_analysis")}}
),
d_customer as (
    select * from {{ref("dim_customers")}}
),
d_product as (
    select * from {{ref('dim_products')}}
),
d_date as (
    select * from {{ref('dim_date')}}
)

select
    d_customer.*,
    d_product.*,
    d_date.*,
    f.orderquantity, f.productprice
    
    from f_fact_sales_analysis as f
    left join d_customer on f.customerkey = d_customer.customerkey
    left join d_product on f.productkey = d_product.productkey
    left join d_date on f.orderdatekey = d_date.datekey
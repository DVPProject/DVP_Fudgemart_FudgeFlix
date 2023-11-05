with stg_products as (
    select * from {{ source('dvp_fudgemart','fm_products')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_products.product_id']) }} as productkey, 
    stg_products.* 
from stg_products

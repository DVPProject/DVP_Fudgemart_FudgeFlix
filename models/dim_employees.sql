with stg_employees as (
    select * from {{ source('dvp_fudgemart','fm_employees')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_employees.employee_id']) }} as employeekey, 
    stg_employees.* 
from stg_employees


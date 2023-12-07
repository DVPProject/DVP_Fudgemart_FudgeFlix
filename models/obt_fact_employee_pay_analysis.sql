with f_fact_employee_pay_analysis as (
    select * from {{ref("fact_employee_pay_analysis")}}
),
d_date as (
    select * from {{ref('dim_date')}}
)

select
    f.*,
    d_date.*    
    from f_fact_employee_pay_analysis as f
    left join d_date on f.timesheetpayrolldatekey = d_date.datekey
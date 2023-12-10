/*with stg_accounts as 
(
    select
        account_id as accountskey
    from {{ source('dvp_fudgemart','ff_accounts')}}
),
stg_plans as
(
    select
        plan_id as plankey,
        plan_price as planprice
    from {{ source('dvp_fudgemart','ff_plans')}}    
),
stg_customers as
(
    select
        customer_id as customerkey
    from {{ source('dvp_fudgemart','fm_customers')}}
),
stg_customer_survey as
(
    select
        income as customerincome
    from {{ source('dvp_fudgemart','fudgemart_customer_survey')}}
)
*/
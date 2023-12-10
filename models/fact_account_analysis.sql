with stg_accounts as 
(
    select
        account_id as accountskey,
        replace(to_date(account_opened_on)::varchar,'-','')::int as accountopendate
    from {{ source('dvp_fudgemart','ff_accounts')}}
),
stg_account_billing as 
(
    select
        ab_id as accountbillid,
        ab_billed_amount,
        replace(to_date(ab_date)::varchar,'-','')::int as accountbilleddate,
        ab_account_id,
        ab_plan_id
    from {{ source('dvp_fudgemart','ff_account_billing')}}
),
stg_plans as
(
    select
        plan_id,
        plan_price
    from {{ source('dvp_fudgemart','ff_plans')}}    
)
select 
ab.accountbillid,
a.accountskey,
p.plan_id,
ab.ab_billed_amount,
a.accountopendate,
ab.accountbilleddate,
p.plan_price
from stg_accounts a 
join stg_account_billing ab on a.accountskey=ab.ab_account_id
join stg_plans p on ab.ab_plan_id=p.plan_id

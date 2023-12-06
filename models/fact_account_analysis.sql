with stg_accounts as 
(
    select
        account_id,
        replace(to_date(account_opened_on)::varchar,'-','')::int as accountopendatekey,
        account_plan_id,
    from {{ source('dvp_fudgemart','ff_accounts')}}
),
stg_account_billing as
(
    select
        ab_id,
        ab_billed_amount,
        replace(to_date(ab_date)::varchar,'-','')::int as accountbilleddate,
        ab_account_id
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
ab.ab_id as accountbillid,
a.account_id as accountskey,
p.plan_id as plankey,
ab.ab_billed_amount as totalamount,
a.accountopendatekey,
ab.accountbilleddate,
p.plan_price
from stg_accounts a 
join stg_account_billing ab on a.account_id=ab.ab_account_id
join stg_plans p on a.account_plan_id=p.plan_id
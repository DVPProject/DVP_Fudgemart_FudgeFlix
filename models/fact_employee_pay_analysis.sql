with stg_employees as 
(
    select
        employee_id,
        employee_lastname,
        employee_firstname,
        employee_jobtitle,
        employee_hourlywage,
        employee_hiredate
    from {{ source('dvp_fudgemart','fm_employees')}}
),
stg_employee_timesheets as 
(
    select
        timesheet_employee_id as employeekey,
        replace(to_date(timesheet_payrolldate)::varchar,'-','')::int as timesheetpayrolldatekey,
        timesheet_hourlyrate,
        timesheet_hours
    from {{ source('dvp_fudgemart','fm_employee_timesheets')}}
)
select
    t.employeekey,
    concat(e.employee_firstname,' ',e.employee_lastname) as employee_name,
    e.employee_jobtitle,
    t.timesheetpayrolldatekey,
    t.timesheet_hourlyrate*t.timesheet_hours as totalwage,
    round(e.employee_hourlywage-t.timesheet_hourlyrate,2) as deltahourlyrates,
    DATEDIFF(DAY, e.employee_hiredate, GETDATE() ) as employeeterm
from stg_employees e join stg_employee_timesheets t on e.employee_id=t.employeekey




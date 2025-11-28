-- Question 20: Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative),
-- 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. 
-- Filter for weeks 10-20 only.

select 
    service,
    week,
    patients_admitted,
    sum(patients_admitted) over (
        partition by service 
        order by week
        rows between unbounded preceding and current row
    ) as cumulative_admissions,
    avg(patient_satisfaction) over (
        partition by service 
        order by week
        rows between 2 preceding and current row
    ) as moving_avg_satisfaction,
    patients_admitted - avg(patients_admitted) over (partition by service) as diff_from_service_avg
from services_weekly
where week between 10 and 20
order by service, week;

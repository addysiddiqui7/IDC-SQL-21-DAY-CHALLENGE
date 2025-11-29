-- Question: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 
-- 1) Service-level metrics (total admissions, refusals, avg satisfaction), 
-- 2) Staff metrics per service (total staff, avg weeks present),
-- 3) Patient demographics per service (avg age, count). 
-- Then combine all three CTEs to create a final report showing service name, all calculated metrics,
-- and an overall performance score (weighted average of admission rate and satisfaction).
-- Order by performance score descending.

with 
   Service_level_metrics as (
    select 
        service,
        sum(patients_admitted) as total_admissions, sum(patients_refused) as total_refusals,
        avg(patient_satisfaction) as avg_satisfaction
    from services_weekly group by service ),
    
    Staff_metrics as (
     select 
        service, count(distinct staff_id) as total_staff, avg(present) as avg_weeks_present
    from staff_schedule group by service),
    
   Patients_Demographics as (
     select 
        service, avg(age) as avg_age, count(*) as patient_count
    from patients group by service)
    
select 
    s.service, s.total_admissions, s.total_refusals, s.avg_satisfaction,
    st.total_staff, st.avg_weeks_present, p.avg_age, p.patient_count,
    -- Performance score: weighted average of admission rate and satisfaction
    (
        (s.total_admissions * 0.5) / nullif((s.total_admissions + s.total_refusals),0)  + (s.avg_satisfaction * 0.5)
    ) as performance_score
from Service_level_metrics s
join Staff_metrics st on s.service = st.service
join Patients_Demographics p on s.service = p.service
order by performance_score desc;


use idc21;

-- Question: Create a comprehensive service analysis report for week 20 showing:
-- service name, total patients admitted that week, total patients refused,
-- average patient satisfaction, count of staff assigned to service,
-- and count of staff present that week. Order by patients admitted descending.

select 
    sw.service,
    sum(sw.patients_admitted) as total_admitted,
    sum(sw.patients_refused) as total_refused,
    avg(sw.patient_satisfaction) as avg_satisfaction,
    count(distinct s.staff_id) as staff_assigned,
    count(distinct case when ss.present = 1 and ss.week = 20 then ss.staff_id end) as staff_present
from services_weekly sw
left join staff s on sw.service = s.service
left join staff_schedule ss on s.staff_id = ss.staff_id and ss.week = 20
where sw.week = 20
group by sw.service
order by total_admitted desc;

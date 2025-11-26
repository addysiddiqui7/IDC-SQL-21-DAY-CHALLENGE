-- Question: Find all patients who were admitted to services that had at least one week where patients were refused 
-- AND the average patient satisfaction for that service was below the overall hospital average satisfaction.
-- show patient_id, name, service, and their personal satisfaction score.

select 
    p.patient_id,
    p.name,
    p.service,
    p.satisfaction
from patients p
where p.service in (
    -- Subquery: services with at least one week where patients were refused
    select sw.service
    from services_weekly sw
    where sw.patients_refused > 0
    group by sw.service
    having avg(sw.patient_satisfaction) < (
        -- Subquery: overall hospital average satisfaction
        select avg(patient_satisfaction) 
        from services_weekly
    )
);

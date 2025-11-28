-- Question 19: For each service, rank the weeks by patient satisfaction score (highest first). 
-- Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.

select 
    service, week, patient_satisfaction, patients_admitted,
    satisfaction_rank
from (
    select 
        service, week, patient_satisfaction, patients_admitted,
        rank() over (
            partition by service 
            order by patient_satisfaction desc
        ) as satisfaction_rank
    from services_weekly
) ranked
where satisfaction_rank <= 3
order by service, satisfaction_rank, week;

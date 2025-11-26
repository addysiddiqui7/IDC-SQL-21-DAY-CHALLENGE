-- Question: Create a report showing each service with: service name, total patients admitted, 
-- the difference between their total admissions and the average admissions across all services, 
-- and a rank indicator ('Above Average', 'Average', 'Below Average'). 
-- Order by total patients admitted descending.

select 
    service, 
    sum(patients_admitted) as total_patients_admitted, 
    sum(patients_admitted) - (select avg(total_admissions) from (select sum(patients_admitted) as total_admissions from services_weekly group by service) t) as Score,
    case 
        when sum(patients_admitted) > (select avg(total_admissions) 
              from (select sum(patients_admitted) as total_admissions from services_weekly group by service) t) then 'Above Average'
        when sum(patients_admitted) = (select avg(total_admissions) 
              from (select sum(patients_admitted) as total_admissions from services_weekly group by service) t) then 'Average'
        else 'Below Average'
    end as Rank_indicator
from services_weekly
group by service
order by total_patients_admitted desc;

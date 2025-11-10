-- Question: Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order.

select * from services_weekly;
select week, service, patients_refused, patients_request from services_weekly
order by patients_refused desc
limit 5;

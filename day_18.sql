-- Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'),
-- and associated service.
-- Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.

select 
    patient_id as identifier, name as full_name, 'Patient' as type, service
from patients
where service in ('surgery', 'emergency')

union

select 
    staff_id as identifier, staff_name as full_name, 'Staff' as type, service
from staff
where service in ('surgery', 'emergency')

order by type, service, full_name;



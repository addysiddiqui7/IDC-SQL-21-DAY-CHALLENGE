
-- Question: Create a patient summary that shows patient_id, full name in uppercase, 
-- service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. 
-- Only show patients whose name length is greater than 10 characters.

select patient_id, UPPER(name) as 'Full name',
	   lower(service) as 'Service', 
       CASE when age >=65 then 'senior'
			when age >= 18 then 'Adult' 
       else 'Minor'
       end 'Age Category',
       LENGTH(name) as 'Name Length'
from patients;

--UPDATE allowance a

--SET allowance_id = a.employee_id || '_11_2024'

--WHERE a.allowance_id LIKE '%_6_2024'

--

-- SELECT 1

-- FROM payroll p

-- WHERE p.payroll_id = a.employee_id || '_11_2024'

-- );

SELECT distinct a.employee_id

FROM allowance a

WHERE a.allowance_id = a.employee_id || '_6_2024' -- Ensure they have _6_2024

AND NOT EXISTS (

SELECT 1

FROM payroll p

WHERE p.payroll_id = a.employee_id || '_11_2024' -- Check if _11_2024 is missing in payroll

);
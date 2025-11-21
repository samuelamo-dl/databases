SELECT

a.allowance_id AS current_allowance_id,

a.employee_id,

a.employee_id || '_11_2024' AS new_allowance_id_preview,

a.monthly_allowance,

a.description

FROM allowance a

WHERE a.monthly_allowance = 250

AND a.description LIKE '%Lunch%'

AND a.allowance_id LIKE '%_12_2024%'

AND NOT EXISTS (

SELECT 1

FROM allowance b

WHERE b.allowance_id = a.employee_id || '_11_2024'

)

AND a.employee_id = REPLACE(a.allowance_id, '_12_2024', '')

AND EXISTS (

SELECT 1

FROM payroll p

WHERE p.payroll_id = a.employee_id || '_11_2024'

);
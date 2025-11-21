SELECT p.id, p.journal_id, p.name, p.department, p.rate, p.credit, p.debit,

CASE

WHEN c.id IS NOT NULL THEN CAST(c.id AS VARCHAR)

ELSE p.department

END AS cost_center_id

FROM (

SELECT *,

CASE

WHEN department = 'TR' THEN 'TC'

WHEN department = 'Accra office' THEN 'SC-Accra'

WHEN department = 'Accra SC' THEN 'SC-Accra'

WHEN department = 'OP' THEN 'OPS'

ELSE department

END AS modified_department

FROM temporary_particulars

) p

LEFT JOIN cost_centers c ON p.modified_department = c.code;
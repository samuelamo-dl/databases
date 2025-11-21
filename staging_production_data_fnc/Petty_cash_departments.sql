SELECT

pcv.id as petty_cash_id,

CASE

WHEN departments.id IS NOT NULL THEN departments.id

ELSE TRIM('[]" ' FROM REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(pcv.department, '","', n.n), '","', -1), '["', ''), '"]', ''))

END AS departments_id

FROM

petty_cash_vouchers pcv

JOIN

(SELECT @row := @row + 1 AS n

FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS nums

CROSS JOIN (SELECT @row := 0) r) n

ON

CHAR_LENGTH(pcv.department) - CHAR_LENGTH(REPLACE(pcv.department, ',', '')) >= n.n - 1

LEFT JOIN

departments ON TRIM('[]" ' FROM REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(pcv.department, '","', n.n), '","', -1), '["', ''), '"]', '')) = departments.name

WHERE

YEAR(pcv.created_at) = 2024

ORDER BY

pcv.id, n.n;
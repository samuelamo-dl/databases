SELECT

dv.id as direct_payment_id,

CASE

WHEN departments.id IS NOT NULL THEN departments.id

ELSE TRIM('[]" ' FROM REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(dv.cost_center, '","', n.n), '","', -1), '["', ''), '"]', ''))

END AS departments_id

FROM

direct_vouchers dv

JOIN

(SELECT @row := @row + 1 AS n

FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS nums

CROSS JOIN (SELECT @row := 0) r) n

ON

CHAR_LENGTH(dv.cost_center) - CHAR_LENGTH(REPLACE(dv.cost_center, ',', '')) >= n.n - 1

LEFT JOIN

departments ON TRIM('[]" ' FROM REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(dv.cost_center, '","', n.n), '","', -1), '["', ''), '"]', '')) = departments.name

WHERE

YEAR(dv.created_at) = 2024

ORDER BY

dv.id, n.n;
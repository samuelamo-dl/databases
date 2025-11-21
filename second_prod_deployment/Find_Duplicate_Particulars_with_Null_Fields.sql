WITH DuplicateParticulars AS (

SELECT p.*

FROM particulars p

WHERE (p.credit || '-' ||

p.debit || '-' ||

p.name || '-' ||

COALESCE(p.rate, '') || '-' ||

COALESCE(p.cost_center_id::text, '') || '-' ||

p.journal_id) IN (

SELECT

credit || '-' ||

debit || '-' ||

name || '-' ||

COALESCE(rate, '') || '-' ||

COALESCE(cost_center_id::text, '') || '-' ||

journal_id

FROM particulars

WHERE credit IS NOT NULL

AND debit IS NOT NULL

AND name IS NOT NULL

AND journal_id IS NOT NULL -- Ensure journal_id is not null for comparison

GROUP BY

credit,

debit,

name,

COALESCE(rate, ''),

COALESCE(cost_center_id::text, ''),

journal_id

HAVING COUNT(*) > 1

)

)

SELECT dp.*

FROM DuplicateParticulars dp

ORDER BY dp.journal_id DESC;
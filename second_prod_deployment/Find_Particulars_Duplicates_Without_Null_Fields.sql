WITH DuplicateParticulars AS (

SELECT p.*

FROM particulars p

WHERE (p.credit, p.debit, p.name, p.rate, p.cost_center_id, p.journal_id) IN (

SELECT credit, debit, name, rate, cost_center_id, journal_id

FROM particulars

GROUP BY credit, debit, name, rate, cost_center_id, journal_id

HAVING COUNT(*) > 1

)

)

SELECT dp.*

FROM DuplicateParticulars dp

order by dp.journal_id desc;
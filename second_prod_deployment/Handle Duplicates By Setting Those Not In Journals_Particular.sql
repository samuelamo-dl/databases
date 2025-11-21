WITH unmatched_particulars AS (

SELECT p.id, p.journal_id

FROM particulars p

LEFT JOIN journals_particulars jp

ON p.id = jp.particulars_id

AND p.journal_id = jp.journal_id

WHERE p.journal_id IN (3188,3181)

AND jp.particulars_id IS NULL

)

UPDATE particulars

SET journal_id = NULL

FROM unmatched_particulars up

WHERE particulars.id = up.id;
select pcv.id, pcv.ref AS ref_no,

CASE

WHEN name_count > 1 THEN CONCAT(pcv.name, ' ', ROW_NUMBER() OVER (PARTITION BY pcv.name ORDER BY pcv.created_at ASC))

ELSE pcv.name

END AS name,

pcv.`date`as transaction_date,

pcv.amount_in_figures as amount, pcv.amount_in_words as amount_words, pcva.disapproval_comment as comment,

TRIM(REGEXP_REPLACE(REGEXP_REPLACE(pcv.description, '<[^>]*>', ''), '\\s+', ' '))AS description,

pcv.prepared_by_id as prepared_by_user_id, pcv.prepare_by_signature as signature, pcv.created_at, pcv.updated_at,

CONVERT_TZ(

CASE

WHEN pcva.approve_date IS NOT NULL AND pcva.approved_at IS NOT NULL THEN CAST(CONCAT(pcva.approve_date, ' ', pcva.approved_at) AS DATETIME)

WHEN pcva.disapprove_date IS NOT NULL THEN CAST(CONCAT(pcva.disapprove_date, ' 00:00:00') AS DATETIME)

ELSE NULL

END,

'+00:00',

'+00:00'

) AS approved_at,

COALESCE (pcva.approved_by_id, pcva.disapproved_by_id) AS approved_by_user_id,

pcva.approved_by_signature AS approver_signature,

UPPER(

CASE

WHEN pcva.approval_status = 'complete' THEN 'COMPLETED'

WHEN pcva.approval_status = 'posted' THEN 'COMPLETED'

WHEN pcva.approval_status = 'issued' THEN 'COMPLETED'

ELSE pcva.approval_status

END

) AS status,

CONVERT_TZ(CAST(CONCAT(pcva.post_date, ' ', pcva.posted_at)AS DATETIME),'+00:00', '+00:00') AS posted_at,

pcva.posted_by_id AS posted_by_user_id,

CASE

WHEN pcv.department LIKE '%Training%' THEN 25

ELSE 1

END AS organization_id,

CASE

WHEN pcv.department LIKE '%Training%' THEN 6

ELSE 2

END AS office_id,

'false' AS archived

FROM (SELECT pcv.*, COUNT(*) OVER (PARTITION BY pcv.name) AS name_count

FROM petty_cash_vouchers pcv) pcv

LEFT JOIN petty_cash_voucher_approvals pcva ON pcv.id = pcva.pcv_id

WHERE YEAR(pcv.created_at) = 2024

ORDER BY pcv.id ASC
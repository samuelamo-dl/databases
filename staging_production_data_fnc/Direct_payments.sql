select dv.id, dv.transfer_number AS transfer_ref_no, dv.jv_number AS jv_ref_no,

dv.po_ref as po_ref_no, dv.req_ref AS req_ref_no, CASE

WHEN name_count > 1 THEN CONCAT(dv.name, ' ', ROW_NUMBER() OVER (PARTITION BY dv.name ORDER BY dv.created_at ASC))

ELSE dv.name

END AS name,

dv.`date`as transa

dv.amount_in_figures as amount, dv.amount_in_words as amount_words, dva.disapproval_comment as comment,

TRIM(REGEXP_REPLACE(REGEXP_REPLACE(dv.description, '<[^>]*>', ''), '\\s+', ' '))AS description,

dv.prepared_by_id as prepared_by_user_id, dv.prepared_by_signature as signature, dv.created_at, dv.updated_at,

CONVERT_TZ(

CASE

WHEN dva.approve_date IS NOT NULL AND dva.approved_at IS NOT NULL THEN CAST(CONCAT(dva.approve_date, ' ', dva.approved_at) AS DATETIME)

WHEN dva.disapprove_date IS NOT NULL THEN CAST(CONCAT(dva.disapprove_date, ' 00:00:00') AS DATETIME)

ELSE NULL

END,

'+00:00',

'+00:00'

) AS approved_at,

COALESCE (dva.approved_by_id, dva.disapproved_by_id) AS approved_by_user_id,

dva.approved_by_signature AS approver_signature,

UPPER(

CASE

WHEN dva.approval_status = 'complete' THEN 'COMPLETED'

WHEN dva.approval_status = 'posted' THEN 'COMPLETED'

WHEN dva.approval_status = 'issued' THEN 'COMPLETED'

ELSE dva.approval_status

END

) AS status,

CONVERT_TZ(CAST(CONCAT(dvp.post_date, ' ', dvp.posted_at)AS DATETIME),'+00:00', '+00:00') AS posted_at,

dvp.posted_by_id AS posted_by_user_id,

CASE

WHEN dv.cost_center LIKE '%Training%' THEN 25

ELSE 1

END AS organization_id,

CASE

WHEN dv.cost_center LIKE '%Training%' THEN 6

ELSE 2

END AS office_id,

'false' AS archived

FROM (SELECT dv.*, COUNT(*) OVER (PARTITION BY dv.name) AS name_count

FROM direct_vouchers dv) dv

LEFT JOIN direct_voucher_approvals dva ON dv.id = dva.dv_id

LEFT JOIN direct_voucher_posts dvp ON dv.id = dvp.dv_id

WHERE YEAR(dv.created_at) = 2024

ORDER BY dv.id ASC
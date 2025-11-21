select jv.id, jv.po_ref as po_ref_no, jv.cheque_ref AS payment_ref_no, jv.ref AS req_ref_no,

CASE

WHEN jv_ref_count > 1 THEN CONCAT(jv.jv_ref, ' ', ROW_NUMBER() OVER (PARTITION BY jv.jv_ref ORDER BY jv.created_at ASC))

ELSE jv.jv_ref

END AS jv_ref_no,

jv.transaction_date,

jva.disapproval_comment as comment,

TRIM(REGEXP_REPLACE(REGEXP_REPLACE(jv.narration, '<[^>]*>', ''), '\\s+', ' ')) AS narration,

jv.prepared_by_id as prepared_by_user_id, jv.prepared_by_signature as signature, jv.created_at, jv.updated_at,

CONVERT_TZ(

CASE

WHEN jva.approve_date IS NOT NULL THEN CAST(CONCAT(jva.approve_date , ' 00:00:00') AS DATETIME)

WHEN jva.disapprove_date IS NOT NULL THEN CAST(CONCAT(jva.disapprove_date, ' 00:00:00') AS DATETIME)

ELSE NULL

END,

'+00:00',

'+00:00'

) AS approved_at,

COALESCE (jva.approved_by_id, jva.disapproved_by_id) AS approved_by_user_id,

jva.approved_by_signature AS approver_signature,

UPPER(

CASE

WHEN jva.approval_status = 'complete' THEN 'COMPLETED'

WHEN jva.approval_status = 'posted' THEN 'COMPLETED'

WHEN jva.approval_status = 'issued' THEN 'COMPLETED'

ELSE jva.approval_status

END

) AS status,

CONVERT_TZ(CAST(CONCAT(jva.post_date, ' ', jva.posted_at)AS DATETIME),'+00:00', '+00:00') AS posted_at,

jva.posted_by_id AS posted_by_user_id,

CASE

WHEN jv.jv_ref LIKE '%AWS TC%' THEN 25

WHEN jv.jv_ref LIKE '%TC%' THEN 25

ELSE 1

END AS organization_id,

CASE

WHEN jv.jv_ref LIKE '%AWS TC%' THEN 6

WHEN jv.jv_ref LIKE '%TC%' THEN 6

ELSE 2

END AS office_id,

'false' AS archived

FROM (SELECT jv.*, COUNT(*) OVER (PARTITION BY jv.jv_ref) AS jv_ref_count

FROM journal_vouchers jv) jv

LEFT JOIN journal_voucher_approvals jva ON jv.id = jva.jv_id

LEFT JOIN direct_voucher_posts dvp ON jv.id = dvp.dv_id

WHERE YEAR(jv.created_at) = 2024

ORDER BY jv.id ASC
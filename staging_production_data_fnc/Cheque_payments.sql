select cv.id, cv.cheque_number AS cheque_no,cv.jv_number AS jv_ref_no,

cv.po_ref as po_ref_no, cv.req_ref as req_ref_no, cv.`date`as transaction_date,

cv.amount_in_figures as amount, cv.amount_in_words as amount_words, cva.disapproval_comment as comment,

TRIM(REGEXP_REPLACE(REGEXP_REPLACE(cv.description, '<[^>]*>', ''), '\\s+', ' '))AS description,

cv.prepared_by_id as prepared_by_user_id, cv.prepared_by_signature as signature, cv.created_at, cv.updated_at,

CASE

WHEN name_count > 1 THEN CONCAT(cv.name, ' ', ROW_NUMBER() OVER (PARTITION BY cv.name ORDER BY cv.created_at ASC))

ELSE cv.name

END AS name,

CONVERT_TZ(

CASE

WHEN cva.approve_date IS NOT NULL AND cva.approved_at IS NOT NULL THEN CAST(CONCAT(cva.approve_date, ' ', cva.approved_at) AS DATETIME)

WHEN cva.disapprove_date IS NOT NULL THEN CAST(CONCAT(cva.disapprove_date, ' 00:00:00') AS DATETIME)

ELSE NULL

END,

'+00:00',

'+00:00'

) AS approved_at,

COALESCE (cva.approved_by_id, cva.disapproved_by_id) AS approved_by_user_id,

cva.approved_by_signature AS approver_signature,

UPPER(

CASE

WHEN cva.approval_status = 'complete' THEN 'COMPLETED'

WHEN cva.approval_status = 'posted' THEN 'COMPLETED'

WHEN cva.approval_status = 'issued' THEN 'COMPLETED'

ELSE cva.approval_status

END

) AS status,

CONVERT_TZ(CAST(CONCAT(cvp.post_date, ' ', cvp.posted_at)AS DATETIME),'+00:00', '+00:00') AS posted_at,

cvp.posted_by_id AS posted_by_user_id,

CASE

WHEN cv.department LIKE '%Training%' THEN 25

ELSE 1

END AS organization_id,

CASE

WHEN cv.department LIKE '%Training%' THEN 6

ELSE 2

END AS office_id,

NULL AS updated_by_user_id,

'false' AS archived

FROM (SELECT cv.*, COUNT(*) OVER (PARTITION BY cv.name) AS name_count

FROM cheque_vouchers cv) cv

LEFT JOIN cheque_voucher_approvals cva ON cv.id = cva.cv_id

LEFT JOIN cheque_voucher_posts cvp ON cv.id = cvp.cv_id

WHERE YEAR(cv.created_at) = 2024
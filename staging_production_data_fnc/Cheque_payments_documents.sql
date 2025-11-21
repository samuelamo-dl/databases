SELECT cvd.cv_id as cheque_payment_id, cvd.document_name, cvd.url AS document_url

FROM cheque_voucher_documents cvd

JOIN cheque_vouchers cv ON cvd.cv_id = cv.id

WHERE YEAR(cv.created_at) = 2024

ORDER BY cvd.cv_id ASC
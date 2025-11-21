SELECT jvd.jv_id as journal_id, jvd.document_name, jvd.url AS document_url

FROM journal_voucher_documents jvd

JOIN journal_vouchers jv ON jvd.jv_id = jv.id

WHERE YEAR(jv.created_at) = 2024

ORDER BY jvd.jv_id ASC
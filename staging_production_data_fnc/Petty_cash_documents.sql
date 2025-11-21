SELECT pcvd.pcv_id as petty_cash_id, pcvd.document_name, pcvd.url AS document_url

FROM petty_cash_voucher_documents pcvd

JOIN petty_cash_vouchers pcv ON pcvd.pcv_id = pcv.id

WHERE YEAR(pcv.created_at) = 2024

ORDER BY pcvd.pcv_id ASC
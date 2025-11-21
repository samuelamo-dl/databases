SELECT dvd.dv_id as direct_payment_id, dvd.document_name, dvd.url AS document_url

FROM direct_voucher_documents dvd

JOIN direct_vouchers dv ON dvd.dv_id = dv.id

WHERE YEAR(dv.created_at) = 2024

ORDER BY dvd.dv_id ASC
SELECT bank.id,account_name, account_number , bank_name , branch, swift_key FROM bank

LEFT JOIN client on bank.client_id = client.id

WHERE client."isOrganization" = false

ORDER BY id ASC;
SELECT client.id, client.client_name AS organization_name, client.logo , client.website , client.parent_id , client."isOrganization" AS is_organization, client.archive, client.currency, address.id AS address_id, bank.id as bank_id FROM client

LEFT JOIN address on client.id = address.client_id

LEFT JOIN bank on client.id = bank.client_id

WHERE client."isOrganization" = true

ORDER BY client.id ASC;
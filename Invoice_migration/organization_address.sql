SELECT address.id,city, state_region, street_address, time_zone, zip_code, country FROM address

LEFT JOIN client on address.client_id = client.id

WHERE client."isOrganization" = true

ORDER BY id ASC;
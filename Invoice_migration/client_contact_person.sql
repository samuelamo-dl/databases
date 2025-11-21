SELECT client_contact_person.id, client_id, email , "name" , phone FROM client_contact_person

LEFT JOIN client on client_contact_person.client_id = client.id

WHERE client."isOrganization" = false

ORDER BY id ASC;
SELECT project.id, project.name, project.client_id, project.technical_manager_id, project.start_date , project.end_date, project.contract_id, project.archive as is_archived, contract_id FROM project

LEFT JOIN client on project.client_id = client.id

WHERE client."isOrganization" = false

ORDER BY id ASC;
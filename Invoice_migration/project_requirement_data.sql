SELECT project_requirements.id, project_id, specialization.name as specialization_name FROM project_requirements

LEFT JOIN specialization ON project_requirements.specialization_id = specialization.id

LEFT JOIN project ON project_requirements.project_id = project.id

LEFT JOIN client ON project.client_id = client.id

WHERE client."isOrganization" = false;
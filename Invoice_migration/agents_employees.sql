SELECT employee_bios.user_id, profile_image, full_name, COALESCE (null) AS access_level_id, work_email AS email,

organization_id, employee_organizations.name AS organization_name, specialization.id AS specialization_id, employee_bios.deleted,

seniority_level.name AS seniority_level, active FROM employee_bios

LEFT JOIN employee_contacts ON employee_bios.user_id = employee_contacts. user_id

LEFT JOIN employee_infos ON employee_bios. user_id = employee_infos. user_id AND employee_infos.active = TRUE

LEFT JOIN specialization ON employee_infos.specialization_id = specialization.id

LEFT JOIN positions ON employee_infos.position_id = positions.id

LEFT JOIN seniority_level ON positions.seniority_level_id = seniority_level.id

LEFT JOIN employee_organizations ON employee_infos.organization_id = employee_organizations.id

ORDER BY employee_bios.user_id ASC;
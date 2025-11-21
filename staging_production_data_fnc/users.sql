SELECT

eb.user_id,

eb.profile_image,

eb.full_name,

COALESCE(NULL) AS access_level_id,

ec.work_email AS email,

eb.deleted,

ei.active,

ei.department_id,

ei.office_id,

ei.organization_id

FROM

employee_bios AS eb

LEFT JOIN

employee_contacts AS ec ON eb.user_id = ec.user_id

LEFT JOIN

employee_infos AS ei ON eb.user_id = ei.user_id AND ei.active = TRUE

WHERE eb.deleted = false

ORDER BY

eb.user_id ASC;
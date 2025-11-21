INSERT INTO contract (id, contract_type, discount, is_archived, rate_type, client_id, organization_id, supplier_id, contract_ref_id, status)

SELECT

id,

contract_type,

discount,

is_archived,

rate_type,

CASE WHEN client_id IN (SELECT id FROM clients) THEN client_id ELSE NULL END as client_id,

CASE WHEN organization_id IN (SELECT id FROM organizations) THEN organization_id ELSE NULL END as organization_id,

supplier_id,

contract_ref_id,

status

FROM

contract_sample ;

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

WHERE

eb.deleted = false

AND ei.organization_id IN (1001, 339, 1042, 1043, 1044)

AND ei.office_id IN (25, 158, 164, 24, 155, 32, 173, 174, 175, 176)

ORDER BY

eb.user_id ASC;

SELECT id, department_name, deleted, codename FROM departments where id in (9, 185, 10, 69, 68, 7, 15, 4, 12, 185, 1, 114, 131, 42)

SELECT id, client_name AS name, archive AS archived

FROM client

WHERE "isOrganization" = true

AND id IN (1042, 1043, 1044);

SELECT id, organization_id, office_name, archive AS archived FROM office

where id in (173, 174, 175, 176, 32);
ORGS

SELECT id, name AS name, archive AS archived FROM employee_organizations eo where archive = false;

OFFICES

SELECT

eo.id,

eo.organization_id,

eo.name AS office_name,

eo.archive AS archived

FROM

employee_offices eo

JOIN

employee_organizations eorg ON eo.organization_id = eorg.id

WHERE

eo.archive = false

AND NOT eorg.archive

DEPARTMENTS

SELECT id, department_name, deleted, codename FROM departments where deleted = false
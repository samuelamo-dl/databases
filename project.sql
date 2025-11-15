SELECT
    p.id,
    p.archive AS archived,
    p.business_manager_id,
    p.technical_manager_id,
    p."name" AS project_name
FROM
    project p
WHERE
    p.archive = FALSE;
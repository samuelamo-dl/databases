SELECT
    c.id,
    c.archive AS archived,
    c.client_name AS organization_name,
    a.street_address,
    a.city,
    a.country
FROM
    client c
JOIN
    address a ON a.client_id = c.id
WHERE
    c."isOrganization" = TRUE;
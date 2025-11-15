select c.id, c.archive as archived, c.client_name as organization_name, a.street_address , a.city , a.country
from client c
join address a
on a.client_id = c.id
where c."isOrganization" = true;

select p.id , p.archive as archived, p.business_manager_id , p.technical_manager_id , p."name" as project_name
from project p
where p.archive = false;
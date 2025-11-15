select
eb.user_id,
eb.profile_image as image_url,
eb.full_name ,
ec.work_email as email,
eb.deleted ,
ei.office_id ,
ec.phone_number_1 as phone,
ei.department_id,
ei.position_id
from  arms_employee_stage.employee_bio eb
left join arms_employee_stage.employee_contact ec
on eb.user_id = ec.user_id
left join arms_employee_stage.employee_info ei
on eb.user_id = ei.user_id and ei.active = true
where eb.deleted = false;
SELECT
    eb.user_id,
    eb.profile_image AS image_url,
    eb.full_name,
    ec.work_email AS email,
    eb.deleted,
    ei.office_id,
    ec.phone_number_1 AS phone,
    ei.department_id,
    ei.position_id
FROM
    employee_bios eb
LEFT JOIN
    employee_contacts ec ON eb.user_id = ec.user_id
LEFT JOIN
    employee_infos ei ON eb.user_id = ei.user_id AND ei.active = TRUE
WHERE
    eb.deleted = FALSE;
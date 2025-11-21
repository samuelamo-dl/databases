UPDATE cheque_payments

SET bank_id = 2

WHERE organization_id = 25;

UPDATE cheque_payments

SET bank_id = 1

WHERE organization_id = 1;

UPDATE direct_payments

SET bank_id = 1

WHERE organization_id = 1;

UPDATE direct_payments

SET bank_id = 2

WHERE organization_id = 25;
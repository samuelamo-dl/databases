ALTER TABLE journals

DROP CONSTRAINT journals_status_check, ADD CONSTRAINT journals_status_check

CHECK (status IN ('PENDING', 'APPROVED', 'DISAPPROVED', 'COMPLETED', 'CANCELLED', 'REVERSED'));

ALTER TABLE petty_cash

DROP CONSTRAINT petty_cash_status_check,

ADD CONSTRAINT petty_cash_status_check

CHECK (status IN ('PENDING', 'APPROVED', 'DISAPPROVED', 'COMPLETED', 'CANCELLED', 'VOID'));

ALTER TABLE cheque_payments

DROP CONSTRAINT cheque_payments_status_check,

ADD CONSTRAINT cheque_payments_status_check

CHECK (status IN ('PENDING', 'APPROVED', 'DISAPPROVED', 'COMPLETED', 'CANCELLED', 'VOID'));

ALTER TABLE direct_payments

DROP CONSTRAINT direct_payments_status_check,

ADD CONSTRAINT direct_payments_status_check

CHECK (status IN ('PENDING', 'APPROVED', 'DISAPPROVED', 'COMPLETED', 'CANCELLED', 'VOID'));
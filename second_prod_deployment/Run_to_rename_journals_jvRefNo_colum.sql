ALTER TABLE journals RENAME COLUMN quick_book_ref_id TO jv_ref;

ALTER TABLE journals RENAME COLUMN jv_ref_no TO jv_name;

Update particulars null journal_id column

-- UPDATE particulars
--
-- SET journal_id = jp.journal_id
--
-- FROM journals_particulars jp
--
-- WHERE particulars.id = jp.particulars_id
--
-- AND particulars.journal_id IS NULL;

UPDATE cost_centers

SET archived=false

WHERE archived isnull;
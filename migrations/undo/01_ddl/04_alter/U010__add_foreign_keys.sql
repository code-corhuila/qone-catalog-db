ALTER TABLE catalog.seat_reservation DROP CONSTRAINT IF EXISTS fk_seat_reservation_section;
ALTER TABLE catalog.section_slot DROP CONSTRAINT IF EXISTS fk_section_slot_section;
ALTER TABLE catalog.section DROP CONSTRAINT IF EXISTS fk_section_subject;
ALTER TABLE catalog.subject_prerequisite DROP CONSTRAINT IF EXISTS fk_subject_prerequisite_prerequisite;
ALTER TABLE catalog.subject_prerequisite DROP CONSTRAINT IF EXISTS fk_subject_prerequisite_subject;

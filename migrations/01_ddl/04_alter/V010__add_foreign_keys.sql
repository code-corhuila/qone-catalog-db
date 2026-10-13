-- Foreign keys inside the domain, after every table exists (Annex A rule 2). Each one says
-- what happens on delete; nothing is deleted by the application in v2.
ALTER TABLE catalog.subject_prerequisite
    ADD CONSTRAINT fk_subject_prerequisite_subject      FOREIGN KEY (subject_id)      REFERENCES catalog.subject (id) ON DELETE CASCADE,
    ADD CONSTRAINT fk_subject_prerequisite_prerequisite FOREIGN KEY (prerequisite_id) REFERENCES catalog.subject (id) ON DELETE RESTRICT;
ALTER TABLE catalog.section
    ADD CONSTRAINT fk_section_subject FOREIGN KEY (subject_id) REFERENCES catalog.subject (id) ON DELETE RESTRICT;
ALTER TABLE catalog.section_slot
    ADD CONSTRAINT fk_section_slot_section FOREIGN KEY (section_id) REFERENCES catalog.section (id) ON DELETE CASCADE;
ALTER TABLE catalog.seat_reservation
    ADD CONSTRAINT fk_seat_reservation_section FOREIGN KEY (section_id) REFERENCES catalog.section (id) ON DELETE RESTRICT;

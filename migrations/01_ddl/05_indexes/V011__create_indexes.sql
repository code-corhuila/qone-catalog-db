-- Every foreign key column has its index; every other index names the query it serves (Annex A rule 3).
CREATE UNIQUE INDEX ux_subject_code ON catalog.subject (code);                                   -- INV-SUB-001, CA-04
CREATE INDEX ix_subject_semester_created_at ON catalog.subject (semester, created_at DESC);     -- CA-02
CREATE INDEX ix_subject_prerequisite_prerequisite_id ON catalog.subject_prerequisite (prerequisite_id);
CREATE UNIQUE INDEX ux_section_subject_term_group ON catalog.section (subject_id, term, group_number);  -- one group per subject and term
CREATE INDEX ix_section_professor_id_term ON catalog.section (professor_id, term);               -- CA-07
CREATE INDEX ix_section_term_created_at ON catalog.section (term, created_at DESC);              -- CA-06
CREATE UNIQUE INDEX ux_section_slot_section_day_start ON catalog.section_slot (section_id, day, start_time);  -- seed upserts
CREATE INDEX ix_seat_reservation_status_expires_at ON catalog.seat_reservation (status, expires_at);  -- the worker's sweep
CREATE INDEX ix_seat_reservation_section_student ON catalog.seat_reservation (section_id, student_id);  -- the saga's lookups
CREATE INDEX ix_outbox_unpublished ON catalog.outbox (occurred_at) WHERE published_at IS NULL;
CREATE INDEX ix_idempotency_key_created_at ON catalog.idempotency_key (created_at);

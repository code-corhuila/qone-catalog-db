-- Nothing is deleted by the application (no soft delete in v2); keys are pruned by age.
GRANT USAGE ON SCHEMA catalog TO catalog_reader, catalog_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA catalog TO catalog_reader;
GRANT SELECT, INSERT, UPDATE ON catalog.subject, catalog.section, catalog.seat_reservation, catalog.outbox TO catalog_writer;
GRANT SELECT, INSERT         ON catalog.subject_prerequisite, catalog.section_slot TO catalog_writer;
GRANT SELECT, INSERT, DELETE ON catalog.idempotency_key TO catalog_writer;

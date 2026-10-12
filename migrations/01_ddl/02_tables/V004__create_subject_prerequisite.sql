-- subject_prerequisite: a link table. The database forbids self-reference; the acyclic rule
-- (INV-SUB-002) is graph logic and lives in the domain on every write. Keys arrive in 04_alter.
CREATE TABLE catalog.subject_prerequisite (
    subject_id      uuid NOT NULL,
    prerequisite_id uuid NOT NULL,
    CONSTRAINT pk_subject_prerequisite       PRIMARY KEY (subject_id, prerequisite_id),
    CONSTRAINT chk_subject_prerequisite_self CHECK (prerequisite_id <> subject_id)
);

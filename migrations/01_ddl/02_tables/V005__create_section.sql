-- section: a group of a subject in a term with its professor (snapshot from identity, no FK
-- across domains) and its seats. seats_available is decremented under a row lock by a
-- reservation and never goes below zero (INV-SEC-001): the CHECK is the last line.
CREATE TABLE catalog.section (
    id              uuid        NOT NULL DEFAULT gen_random_uuid(),
    subject_id      uuid        NOT NULL,
    term            text        NOT NULL,
    group_number    integer     NOT NULL,
    professor_id    uuid        NOT NULL,
    professor_name  text        NOT NULL,
    capacity        integer     NOT NULL,
    seats_available integer     NOT NULL,
    created_at      timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_section                PRIMARY KEY (id),
    CONSTRAINT chk_section_term          CHECK (term ~ '^[0-9]{4}-[AB]$'),
    CONSTRAINT chk_section_group_number  CHECK (group_number BETWEEN 1 AND 99),
    CONSTRAINT chk_section_professor_name CHECK (length(professor_name) BETWEEN 2 AND 120),
    CONSTRAINT chk_section_capacity      CHECK (capacity BETWEEN 1 AND 500),
    CONSTRAINT chk_section_seats         CHECK (seats_available >= 0 AND seats_available <= capacity)
);

COMMENT ON COLUMN catalog.section.professor_id IS 'Id in identity.app_user; no foreign key across domains.';

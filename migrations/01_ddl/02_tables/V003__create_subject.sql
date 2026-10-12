-- subject: the pensum (06-data/models.md, schema catalog). The code is the business key the API
-- addresses subjects by (INV-SUB-001).
CREATE TABLE catalog.subject (
    id         uuid        NOT NULL DEFAULT gen_random_uuid(),
    code       text        NOT NULL,
    name       text        NOT NULL,
    credits    integer     NOT NULL,
    semester   integer     NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_subject          PRIMARY KEY (id),
    CONSTRAINT chk_subject_code    CHECK (code ~ '^[A-Z0-9-]{3,10}$'),
    CONSTRAINT chk_subject_name    CHECK (length(name) BETWEEN 2 AND 120),
    CONSTRAINT chk_subject_credits CHECK (credits BETWEEN 1 AND 10),
    CONSTRAINT chk_subject_semester CHECK (semester BETWEEN 1 AND 12)
);

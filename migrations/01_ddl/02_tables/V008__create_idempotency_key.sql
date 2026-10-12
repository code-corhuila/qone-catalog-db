-- idempotency_key: the database half of idempotent creation (norm 5.3.8, Annex A).
CREATE TABLE catalog.idempotency_key (
    key           text        NOT NULL,
    resource_type text        NOT NULL,
    resource_id   uuid        NOT NULL,
    created_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_idempotency_key           PRIMARY KEY (key),
    CONSTRAINT chk_idempotency_key_length   CHECK (length(key) BETWEEN 8 AND 128),
    CONSTRAINT chk_idempotency_key_resource CHECK (resource_type IN ('subject', 'section', 'seat_reservation'))
);

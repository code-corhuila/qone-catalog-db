-- seat_reservation: the seat the enrollment saga takes (CA-10), commits (CA-12) or releases
-- (CA-11). RESERVED is the only non-terminal state; qone-worker expires it after expires_at.
CREATE TABLE catalog.seat_reservation (
    id         uuid        NOT NULL DEFAULT gen_random_uuid(),
    section_id uuid        NOT NULL,
    student_id uuid        NOT NULL,
    saga_id    uuid        NOT NULL,
    status     text        NOT NULL DEFAULT 'RESERVED',
    expires_at timestamptz NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_seat_reservation        PRIMARY KEY (id),
    CONSTRAINT chk_seat_reservation_status CHECK (status IN ('RESERVED', 'COMMITTED', 'RELEASED', 'EXPIRED'))
);

COMMENT ON COLUMN catalog.seat_reservation.student_id IS 'Id in identity.app_user; no foreign key across domains.';

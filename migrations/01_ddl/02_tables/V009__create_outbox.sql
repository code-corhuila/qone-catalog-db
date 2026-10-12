-- outbox: the event row is written in the transaction of the change (norm 5.3.11); qone-worker
-- relays it to RabbitMQ and sets published_at. Shared shape of 06-data/models.md.
CREATE TABLE catalog.outbox (
    id             uuid        NOT NULL DEFAULT gen_random_uuid(),
    aggregate_type text        NOT NULL,
    aggregate_id   uuid        NOT NULL,
    event_type     text        NOT NULL,
    payload        jsonb       NOT NULL,
    occurred_at    timestamptz NOT NULL DEFAULT now(),
    published_at   timestamptz NULL,
    CONSTRAINT pk_outbox             PRIMARY KEY (id),
    CONSTRAINT chk_outbox_aggregate  CHECK (aggregate_type IN ('subject', 'section', 'seat_reservation')),
    CONSTRAINT chk_outbox_event_type CHECK (event_type IN ('SubjectCreated', 'SectionCreated', 'SeatReserved', 'SeatReleased', 'SeatCommitted'))
);

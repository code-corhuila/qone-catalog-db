-- section_slot: the weekly blocks of a section. Non-overlap among the slots of one section
-- (INV-SEC-002) is interval logic and lives in the domain.
CREATE TABLE catalog.section_slot (
    id         uuid NOT NULL DEFAULT gen_random_uuid(),
    section_id uuid NOT NULL,
    day        text NOT NULL,
    start_time time NOT NULL,
    end_time   time NOT NULL,
    CONSTRAINT pk_section_slot       PRIMARY KEY (id),
    CONSTRAINT chk_section_slot_day  CHECK (day IN ('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT')),
    CONSTRAINT chk_section_slot_time CHECK (start_time < end_time)
);

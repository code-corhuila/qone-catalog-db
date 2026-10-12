-- Roles carry permissions and have no password (Annex A rule 10): NOLOGIN.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'catalog_reader') THEN
        CREATE ROLE catalog_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'catalog_writer') THEN
        CREATE ROLE catalog_writer NOLOGIN;
    END IF;
END
$$;

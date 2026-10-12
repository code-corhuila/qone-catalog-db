REVOKE ALL ON ALL TABLES IN SCHEMA catalog FROM catalog_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA catalog FROM catalog_reader;
REVOKE USAGE ON SCHEMA catalog FROM catalog_reader, catalog_writer;

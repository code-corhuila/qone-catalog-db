-- The fourteen subjects of the demo pensum (06-data, ADR-009): the same ids and codes the
-- portals' fixtures use. Upsert on the id (Annex A rule 11).
INSERT INTO catalog.subject (id, code, name, credits, semester, created_at)
VALUES
    ('44444444-4444-4444-8444-444444444401', 'ISW-501', 'Bases de Datos I', 3, 5, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444402', 'ISW-502', 'Sistemas Operativos', 3, 5, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444403', 'RED-501', 'Redes de Datos', 3, 5, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444404', 'HUM-501', 'Ética Profesional', 2, 5, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444405', 'MAT-501', 'Estadística II', 3, 5, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444406', 'ISW-601', 'Bases de Datos II', 3, 6, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444407', 'ISW-602', 'Teoría de la Computación', 3, 6, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444408', 'ISW-603', 'Ingeniería de Requisitos', 3, 6, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444409', 'ISW-604', 'Sistemas Distribuidos', 4, 6, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444410', 'ISW-605', 'Arquitectura de Software', 3, 6, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444411', 'ISW-701', 'Seguridad Informática', 3, 7, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444412', 'ISW-702', 'Computación en la Nube', 3, 7, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444413', 'ISW-703', 'Gestión de Proyectos', 3, 7, '2026-08-01T12:00:00Z'),
    ('44444444-4444-4444-8444-444444444414', 'ISW-704', 'Analítica de Datos', 3, 7, '2026-08-01T12:00:00Z')
ON CONFLICT (id) DO UPDATE SET code = EXCLUDED.code, name = EXCLUDED.name, credits = EXCLUDED.credits, semester = EXCLUDED.semester;

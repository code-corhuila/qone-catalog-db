# qone-catalog-db

> catalog bounded context: database (schema, seeds, migrations)

Part of the **Qampus (Quorum One)** distributed system — team `quorum-one`, Grupo 1.
Governance and documentation live in [`qone-docs`](https://github.com/code-corhuila/qone-docs).

## Purpose

The database of the **catalog** domain (course norm 5.2, Annex A): its own PostgreSQL 16
instance, the schema `catalog` and the migrations that build it. `qone-catalog-api` consumes
this structure and never versions it; no other service connects here (ADR-006). The tool is
**Flyway Community** (ADR-007): one SQL file, one version number, a mirror `U` script per version.

Specification: `06-data/models.md` (schema `catalog`), `06-data/modeling-conventions.md`,
`06-data/migration-strategy.md` in `qone-docs`. Stories: `code-corhuila/qone-docs#37`,
`#38`, `#39` (HU-CAT-001..003).

## Schema

| Table | What it keeps | Rules the database enforces |
|---|---|---|
| `subject` | the pensum: code, name, credits, semester | code unique (INV-SUB-001) and shaped `^[A-Z0-9-]{3,10}$`; credits 1..10; semester 1..12 |
| `subject_prerequisite` | the prerequisite graph | no self-reference; acyclicity (INV-SUB-002) is checked by the domain on every write |
| `section` | a group of a subject in a term, its professor (snapshot from identity, no FK), capacity and seats | one group per subject and term; `0 <= seats_available <= capacity` (INV-SEC-001, decremented under a row lock by the API) |
| `section_slot` | the weekly blocks | day in MON..SAT, start before end; non-overlap (INV-SEC-002) is interval logic in the domain |
| `seat_reservation` | the seat the enrollment saga takes, commits or releases | status in RESERVED, COMMITTED, RELEASED, EXPIRED; index for the worker's sweep of expired rows |
| `idempotency_key`, `outbox` | the shared shapes of 06-data | `SubjectCreated`, `SectionCreated`, `SeatReserved`, `SeatReleased`, `SeatCommitted` |

Seeds: the fourteen subjects and eleven sections of the demo with the ids the portals' fixtures
use; `seats_available` reflects the demo enrollments that `qone-enrollment-db` keeps; two
sections are full to demonstrate `NO_SEATS`.

## Layout and how to run it

```
migrations/01_ddl   extensions · schema · tables · 04_alter (foreign keys) · 05_indexes   (V001..V011)
migrations/02_dml   seeds as upserts                                                      (V012..V015)
migrations/03_dcl   roles and grants                                                      (V016, V017)
migrations/undo     U001..U017, one per V, same relative path
```

```bash
cp .env.example .env            # set CATALOG_DB_PASSWORD; .env is ignored by git
docker network create platform  # once; qone-infra creates it in the full platform
docker compose --env-file .env -f deploy/compose.yml up -d catalog-db
docker compose --env-file .env -f deploy/compose.yml --profile tooling run --rm catalog-db-migrate
sh scripts/rebuild-check.sh     # the Annex A check db-ci runs on every pull request
```

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `qone-docs`.

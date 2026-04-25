-- Scientific Revolution and Physical Law Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores historical law models, source notes, model assumptions,
-- parameter sweeps, and simulation-run metadata.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS physical_law_models;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS parameter_sweeps;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    figure_or_topic TEXT NOT NULL,
    source_title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    note TEXT
);

CREATE TABLE physical_law_models (
    model_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    historical_association TEXT NOT NULL,
    modern_relation TEXT NOT NULL,
    primary_variables TEXT NOT NULL
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
);

CREATE TABLE parameter_sweeps (
    sweep_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    parameter_name TEXT NOT NULL,
    parameter_min REAL NOT NULL,
    parameter_max REAL NOT NULL,
    parameter_unit TEXT NOT NULL,
    n_points INTEGER NOT NULL
);

CREATE TABLE simulation_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    numerical_method TEXT,
    parameter_summary TEXT,
    output_summary TEXT,
    created_at TEXT NOT NULL
);

INSERT INTO source_notes (
    source_id,
    figure_or_topic,
    source_title,
    source_url,
    note
) VALUES
(1, 'Galileo', 'Galileo Galilei - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/galileo/', 'Authoritative philosophical and historical overview.'),
(2, 'Kepler', 'Orbits and Kepler''s Laws - NASA', 'https://science.nasa.gov/solar-system/orbits-and-keplers-laws/', 'NASA overview of Kepler''s three laws.'),
(3, 'Newton', 'Newton''s Principia - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/newton-principia/', 'Authoritative philosophical and historical overview of the Principia.'),
(4, 'Scientific Revolution', 'Scientific Revolution: Physics - Encyclopaedia Britannica', 'https://www.britannica.com/science/Scientific-Revolution/Physics', 'Overview of physical science in the Scientific Revolution.');

INSERT INTO physical_law_models (
    model_id,
    article_slug,
    model_name,
    historical_association,
    modern_relation,
    primary_variables
) VALUES
(1, 'scientific-revolution-physical-law', 'galilean_free_fall', 'Galileo and early mathematical science of motion', 's = 0.5 * g * t^2', 's,t,g'),
(2, 'scientific-revolution-physical-law', 'kepler_scaling', 'Kepler and planetary motion', 'T = a^(3/2)', 'T,a'),
(3, 'scientific-revolution-physical-law', 'newton_gravitation', 'Newton and universal gravitation', 'F = G * m1 * m2 / r^2', 'F,G,m1,m2,r');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'galilean_free_fall', 'Motion begins from rest.'),
(2, 'galilean_free_fall', 'Air resistance is ignored.'),
(3, 'galilean_free_fall', 'Gravitational acceleration is treated as constant.'),
(4, 'kepler_scaling', 'Bodies orbit the same central mass.'),
(5, 'kepler_scaling', 'Normalized units are used.'),
(6, 'newton_gravitation', 'Bodies are approximated as point masses or spherical masses.'),
(7, 'newton_gravitation', 'Relativistic corrections are ignored.');

INSERT INTO parameter_sweeps (
    sweep_id,
    model_name,
    parameter_name,
    parameter_min,
    parameter_max,
    parameter_unit,
    n_points
) VALUES
(1, 'kepler_scaling', 'semi_major_axis', 0.25, 10.0, 'normalized', 400),
(2, 'galilean_free_fall', 'time', 0.0, 10.0, 's', 101);

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'scientific-revolution-physical-law', 'kepler_scaling', 'closed_form', 'a from 0.25 to 10.0', 'T = a^(3/2)', '2026-04-24'),
(2, 'scientific-revolution-physical-law', 'galilean_free_fall', 'closed_form', 't from 0 to 10 seconds', 's = 0.5 * g * t^2', '2026-04-24'),
(3, 'scientific-revolution-physical-law', 'two_body_orbit', 'RK4 and velocity-Verlet examples', 'dimensionless orbit', 'trajectory states over time', '2026-04-24');

SELECT
    model_name,
    historical_association,
    modern_relation
FROM physical_law_models
ORDER BY model_id;

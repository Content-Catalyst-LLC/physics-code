-- Galaxies, Black Holes, and the Large-Scale Universe Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores galaxy samples, black-hole samples, cosmic-web environments,
-- physical relations, model assumptions, source notes, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS galaxies;
DROP TABLE IF EXISTS black_holes;
DROP TABLE IF EXISTS cosmic_web_environments;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE galaxies (
    galaxy_id INTEGER PRIMARY KEY,
    object_name TEXT NOT NULL,
    morphology TEXT,
    redshift REAL,
    environment_class TEXT,
    notes TEXT
);

CREATE TABLE black_holes (
    black_hole_id INTEGER PRIMARY KEY,
    object_name TEXT NOT NULL,
    mass_solar REAL NOT NULL,
    host_system TEXT,
    black_hole_type TEXT,
    notes TEXT
);

CREATE TABLE cosmic_web_environments (
    environment_id INTEGER PRIMARY KEY,
    object_id TEXT NOT NULL,
    environment_class TEXT NOT NULL,
    membership_probability REAL,
    notes TEXT
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
);

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    topic TEXT NOT NULL,
    note TEXT
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

INSERT INTO galaxies (
    galaxy_id,
    object_name,
    morphology,
    redshift,
    environment_class,
    notes
) VALUES
(1, 'Milky Way', 'spiral', 0.0, 'Local Group', 'home galaxy example'),
(2, 'M87', 'elliptical', 0.00436, 'cluster', 'host of EHT-imaged supermassive black hole'),
(3, 'Andromeda', 'spiral', 0.0, 'Local Group', 'nearest large spiral galaxy'),
(4, 'schematic DESI galaxy', 'unknown', 0.7, 'filament', 'survey-style example');

INSERT INTO black_holes (
    black_hole_id,
    object_name,
    mass_solar,
    host_system,
    black_hole_type,
    notes
) VALUES
(1, 'Sagittarius A* scale', 4.0e6, 'Milky Way', 'supermassive', 'Milky Way central black-hole scale'),
(2, 'M87* scale', 6.5e9, 'M87', 'supermassive', 'Event Horizon Telescope black-hole scale'),
(3, 'stellar example', 10.0, 'stellar remnant', 'stellar-mass', 'illustrative stellar-mass black hole'),
(4, 'quasar-scale example', 1.0e9, 'active galactic nucleus', 'supermassive', 'illustrative quasar-scale mass');

INSERT INTO cosmic_web_environments (
    environment_id,
    object_id,
    environment_class,
    membership_probability,
    notes
) VALUES
(1, 'G1', 'void', 0.72, 'low-density environment'),
(2, 'G2', 'sheet', 0.68, 'sheet-like environment'),
(3, 'G3', 'filament', 0.81, 'filamentary environment'),
(4, 'G4', 'knot', 0.76, 'cluster-like intersection');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'circular_velocity', 'v(r)^2 = G M(r) / r', 'v,G,M,r', 'connects orbital speed to enclosed mass'),
(2, 'enclosed_mass', 'M(r) = v(r)^2 r / G', 'M,v,r,G', 'infers mass from rotation curve'),
(3, 'schwarzschild_radius', 'r_s = 2 G M / c^2', 'r_s,G,M,c', 'horizon scale for nonrotating black hole'),
(4, 'hubble_relation', 'v = H0 d', 'v,H0,d', 'low-redshift expansion intuition'),
(5, 'redshift_wavelength', '1 + z = lambda_obs / lambda_emit', 'z,lambda_obs,lambda_emit', 'wavelength stretching and redshift');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'rotation_curve_enclosed_mass', 'Circular-orbit approximation is used.'),
(2, 'rotation_curve_enclosed_mass', 'The velocity values are schematic and educational.'),
(3, 'schwarzschild_radius', 'Black holes are modeled using the nonrotating Schwarzschild radius as a baseline scale.'),
(4, 'hubble_relation', 'Low-redshift approximation is used.'),
(5, 'cosmic_web_environment', 'Environment classes are illustrative metadata, not a derived classification.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'NASA Galaxy Basics', 'https://science.nasa.gov/universe/galaxies/', 'galaxies', 'NASA overview of galaxy composition, size, morphology, and central supermassive black holes.'),
(2, 'NASA Large Scale Structures', 'https://science.nasa.gov/universe/galaxies/large-scale-structures/', 'large-scale structure', 'NASA overview of groups, clusters, walls, and cosmic web.'),
(3, 'NASA Black Hole Basics', 'https://science.nasa.gov/universe/black-holes/', 'black holes', 'NASA overview of black holes and accretion.'),
(4, 'Event Horizon Telescope Science', 'https://eventhorizontelescope.org/science', 'black-hole imaging', 'EHT science results and black-hole imaging materials.'),
(5, 'DESI DR1 Fermilab', 'https://news.fnal.gov/2025/03/desi-opens-access-to-the-largest-3d-map-of-the-universe-yet/', 'redshift surveys', 'DESI public data release and large-scale map.'),
(6, 'DESI Cosmic Web Catalog', 'https://arxiv.org/abs/2604.01456', 'cosmic web', 'Probabilistic cosmic-web environment catalog using DESI EDR.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'galaxies-black-holes-and-the-large-scale-universe', 'rotation_curve_enclosed_mass', 'closed_form', 'radii from 2 to 30 kpc, velocity 220 km/s', 'enclosed mass table', '2026-04-24'),
(2, 'galaxies-black-holes-and-the-large-scale-universe', 'schwarzschild_radius', 'closed_form', 'black-hole masses from 10 to 6.5e9 solar masses', 'radius table', '2026-04-24'),
(3, 'galaxies-black-holes-and-the-large-scale-universe', 'redshift_summary', 'closed_form', 'redshift sample from 0.02 to 3.0', 'scale-factor summary', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

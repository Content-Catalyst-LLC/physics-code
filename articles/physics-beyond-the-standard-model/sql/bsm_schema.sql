-- Physics Beyond the Standard Model Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores BSM model classes, motivations, assumptions, parameter scans,
-- toy constraints, source notes, and simulation metadata.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS bsm_motivations;
DROP TABLE IF EXISTS candidate_classes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS parameter_scan_points;
DROP TABLE IF EXISTS toy_constraints;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE bsm_motivations (
    motivation_id INTEGER PRIMARY KEY,
    topic TEXT NOT NULL,
    standard_model_gap TEXT NOT NULL,
    evidence_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE candidate_classes (
    candidate_id INTEGER PRIMARY KEY,
    candidate_class TEXT NOT NULL,
    problem_addressed TEXT NOT NULL,
    typical_signature TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
);

CREATE TABLE parameter_scan_points (
    point_id INTEGER PRIMARY KEY,
    candidate_mass_gev REAL NOT NULL,
    coupling REAL NOT NULL,
    toy_prediction REAL NOT NULL,
    toy_limit REAL NOT NULL,
    excluded_by_toy_limit INTEGER NOT NULL
);

CREATE TABLE toy_constraints (
    constraint_id INTEGER PRIMARY KEY,
    observable_name TEXT NOT NULL,
    observed_limit REAL NOT NULL,
    model_prediction REAL NOT NULL,
    passes_constraint INTEGER NOT NULL
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

INSERT INTO bsm_motivations (
    motivation_id,
    topic,
    standard_model_gap,
    evidence_type,
    notes
) VALUES
(1, 'dark matter', 'No known Standard Model particle explains dominant dark matter', 'cosmology and astrophysics', 'Motivates WIMPs, axions, sterile neutrinos, hidden sectors, and alternatives.'),
(2, 'neutrino mass', 'Minimal Standard Model has massless neutrinos', 'neutrino oscillation', 'Requires extension of fermion sector or mass mechanism.'),
(3, 'baryogenesis', 'Known CP violation is insufficient for observed matter-antimatter asymmetry', 'cosmology and particle physics', 'Motivates new CP violation or leptogenesis mechanisms.'),
(4, 'gravity', 'Gravity is not incorporated into the Standard Model', 'theoretical structure', 'Motivates quantum gravity and unification.'),
(5, 'dark energy', 'Dark energy is not explained by Standard Model particle content', 'cosmology', 'May require cosmological constant, dynamical field, or modified gravity interpretation.');

INSERT INTO candidate_classes (
    candidate_id,
    candidate_class,
    problem_addressed,
    typical_signature,
    notes
) VALUES
(1, 'WIMP', 'dark matter', 'missing energy or nuclear recoil', 'Thermal relic benchmark class.'),
(2, 'Axion', 'dark matter and strong CP', 'photon conversion or oscillatory signal', 'Light pseudoscalar candidate.'),
(3, 'Sterile neutrino', 'neutrino mass and dark matter', 'oscillation or decay signature', 'Gauge-singlet fermion.'),
(4, 'Dark photon', 'hidden sector', 'kinetic mixing and rare decays', 'New vector mediator.'),
(5, 'Supersymmetry', 'hierarchy and dark matter', 'superpartners and missing energy', 'Model-dependent constraints.'),
(6, 'Heavy right-handed neutrino', 'neutrino mass and leptogenesis', 'rare decays or displaced vertices', 'Seesaw-related possibility.');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'relic_density_scaling', 'Relic abundance is modeled as inversely proportional to annihilation strength.'),
(2, 'relic_density_scaling', 'The workflow does not solve the full Boltzmann equation.'),
(3, 'dark_sector_parameter_scan', 'Toy prediction scales as coupling squared divided by square root of mass.'),
(4, 'dark_sector_parameter_scan', 'The exclusion threshold is illustrative and not experimental.'),
(5, 'cosmic_inventory_summary', 'Cosmic fractions use rounded public-summary values.');

INSERT INTO parameter_scan_points (
    point_id,
    candidate_mass_gev,
    coupling,
    toy_prediction,
    toy_limit,
    excluded_by_toy_limit
) VALUES
(1, 1.0, 0.0001, 1.0e-8, 1.0e-5, 0),
(2, 10.0, 0.0010, 3.1623e-7, 1.0e-5, 0),
(3, 100.0, 0.0100, 1.0e-5, 1.0e-5, 0),
(4, 1000.0, 0.0500, 7.9057e-5, 1.0e-5, 1),
(5, 10000.0, 0.1000, 1.0e-4, 1.0e-5, 1);

INSERT INTO toy_constraints (
    constraint_id,
    observable_name,
    observed_limit,
    model_prediction,
    passes_constraint
) VALUES
(1, 'rare_decay_branching_proxy', 0.05, 0.03, 1),
(2, 'missing_energy_proxy', 0.08, 0.10, 0),
(3, 'cosmology_abundance_proxy', 0.12, 0.11, 1);

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'CERN Standard Model', 'https://home.cern/science/physics/standard-model', 'Standard Model', 'CERN overview noting gravity is not part of the Standard Model.'),
(2, 'NASA Dark Matter', 'https://science.nasa.gov/dark-matter/', 'dark matter', 'NASA overview of dark matter and cosmic inventory.'),
(3, 'NASA Dark Energy', 'https://science.nasa.gov/dark-energy/', 'dark energy', 'NASA overview of dark energy.'),
(4, 'PDG Review of Particle Physics', 'https://pdg.lbl.gov/', 'particle physics data', 'Authoritative particle physics review.'),
(5, 'CERN FASER', 'https://home.cern/science/experiments/faser', 'hidden sectors', 'CERN experiment searching for light, weakly interacting particles.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'physics-beyond-the-standard-model', 'relic_density_scaling', 'closed_form', 'sigma_v from 1e-28 to 1e-24 schematic units', 'omega scales inversely with sigma_v', '2026-04-24'),
(2, 'physics-beyond-the-standard-model', 'dark_sector_parameter_scan', 'grid_scan', 'mass and coupling grid', 'toy exclusion flags', '2026-04-24'),
(3, 'physics-beyond-the-standard-model', 'freezeout_toy_dynamics', 'explicit_euler', 'toy abundance depletion', 'abundance over time', '2026-04-24');

SELECT
    topic,
    standard_model_gap,
    evidence_type
FROM bsm_motivations
ORDER BY motivation_id;

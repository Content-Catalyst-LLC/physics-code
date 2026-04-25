-- Gravity, Curvature, and the Structure of Spacetime Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, masses, spacetime models, physical relations,
-- source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS mass_examples;
DROP TABLE IF EXISTS spacetime_models;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE constants (
    constant_id INTEGER PRIMARY KEY,
    constant_name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE mass_examples (
    mass_id INTEGER PRIMARY KEY,
    object_name TEXT NOT NULL,
    mass_kg REAL NOT NULL,
    schwarzschild_radius_m REAL,
    notes TEXT
);

CREATE TABLE spacetime_models (
    model_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    key_quantity TEXT,
    limitation TEXT
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    organization TEXT NOT NULL,
    primary_role TEXT NOT NULL,
    url TEXT NOT NULL
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
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

INSERT INTO constants (
    constant_id,
    constant_name,
    symbol,
    value,
    unit,
    notes
) VALUES
(1, 'Newtonian gravitational constant', 'G', 6.67430e-11, 'm^3 kg^-1 s^-2', 'CODATA recommended value'),
(2, 'speed of light', 'c', 299792458.0, 'm s^-1', 'exact SI value'),
(3, 'solar mass', 'M_sun', 1.98847e30, 'kg', 'solar mass approximation used for examples'),
(4, 'earth mass', 'M_earth', 5.972e24, 'kg', 'Earth mass approximation');

INSERT INTO mass_examples (
    mass_id,
    object_name,
    mass_kg,
    schwarzschild_radius_m,
    notes
) VALUES
(1, 'Earth', 5.972e24, 0.008870, 'weak-field planetary example'),
(2, 'Sun', 1.98847e30, 2953.25, 'solar mass example'),
(3, 'Ten solar masses', 1.98847e31, 29532.5, 'stellar black-hole scale example');

INSERT INTO spacetime_models (
    model_id,
    model_name,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'Schwarzschild metric', 'static spherical non-rotating exterior geometry', 'Schwarzschild radius', 'no rotation or charge'),
(2, 'Kerr metric', 'rotating black-hole geometry', 'spin parameter', 'not included in introductory article examples'),
(3, 'FLRW metric', 'homogeneous isotropic cosmology', 'scale factor', 'not a black-hole exterior metric'),
(4, 'weak-field approximation', 'low-curvature limit', 'Newtonian potential', 'breaks down near compact objects'),
(5, 'linearized gravity', 'small perturbations around flat spacetime', 'metric perturbation', 'not full strong-field numerical relativity');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'metric_interval', 'ds^2 = g_mu_nu dx^mu dx^nu', 'ds,g,dx', 'spacetime interval defined by metric'),
(2, 'einstein_field_equation', 'G_mu_nu + Lambda g_mu_nu = 8 pi G / c^4 T_mu_nu', 'G_mu_nu,Lambda,g,T,G,c', 'curvature linked to stress-energy'),
(3, 'schwarzschild_radius', 'r_s = 2 G M / c^2', 'r_s,G,M,c', 'horizon scale for non-rotating black-hole geometry'),
(4, 'clock_rate_factor', 'd_tau/dt = sqrt(1 - r_s/r)', 'd_tau,dt,r_s,r', 'Schwarzschild gravitational time-dilation factor'),
(5, 'geodesic_equation', 'd2x^mu/dtau2 + Gamma^mu_alpha_beta dx^alpha/dtau dx^beta/dtau = 0', 'x,tau,Gamma', 'free-fall motion in curved spacetime'),
(6, 'toy_strain', 'h(t)=h0 sin(2 pi f t)', 'h,h0,f,t', 'educational gravitational-wave strain scaffold');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'SI Brochure', 'BIPM', 'International System of Units reference', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'Black Holes Imagine the Universe', 'NASA', 'black-hole and event-horizon explanation', 'https://imagine.gsfc.nasa.gov/science/objects/black_holes1.html'),
(3, 'LIGO gravitational waves announcement', 'LIGO', 'first direct gravitational-wave detection announcement', 'https://www.ligo.caltech.edu/news/ligo20160211'),
(4, 'What are gravitational waves', 'LIGO', 'public gravitational-wave explanation', 'https://www.ligo.caltech.edu/page/what-are-gw'),
(5, 'Schwarzschild translation', 'arXiv', 'translation of Schwarzschild 1916 mass-point solution', 'https://arxiv.org/abs/physics/9905030'),
(6, 'Gravitational principles and mathematics', 'NASA APOD', 'Schwarzschild metric reference', 'https://apod.nasa.gov/htmltest/gifcity/nslens_math.html'),
(7, 'CODATA gravitational constant', 'NIST', 'constant value reference', 'https://physics.nist.gov/cgi-bin/cuu/Value?bg='),
(8, 'CODATA speed of light', 'NIST', 'constant value reference', 'https://physics.nist.gov/cgi-bin/cuu/Value?c=');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'schwarzschild_time_dilation', 'Uses Schwarzschild geometry for non-rotating spherical masses.'),
(2, 'schwarzschild_time_dilation', 'All clock-rate calculations are outside the Schwarzschild radius.'),
(3, 'weak_field_comparison', 'Uses a first-order weak-field approximation for clock-rate comparison.'),
(4, 'gravitational_wave_strain_toy_model', 'Uses a simple sinusoidal strain function, not a real waveform template.'),
(5, 'spacetime_gravity_schema', 'Stores educational metadata rather than a full numerical relativity database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'gravity-curvature-and-the-structure-of-spacetime', 'schwarzschild_time_dilation', 'closed_form_grid', 'selected masses and radius from 1.05 to 20 r_s', 'Schwarzschild radii and clock-rate factors', '2026-04-24'),
(2, 'gravity-curvature-and-the-structure-of-spacetime', 'weak_field_comparison', 'closed_form_grid', 'radius from 1.05 to 1000 r_s', 'exact and weak-field clock-rate comparison', '2026-04-24'),
(3, 'gravity-curvature-and-the-structure-of-spacetime', 'gravitational_wave_strain_toy_model', 'toy_time_series', 'amplitude 1e-21 and frequency 150 Hz', 'toy strain time series', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

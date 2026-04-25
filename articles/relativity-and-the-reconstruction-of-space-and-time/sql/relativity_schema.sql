-- Relativity and the Reconstruction of Space and Time Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, events, frames, transformations, physical relations,
-- source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS frames;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS velocity_examples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
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

CREATE TABLE frames (
    frame_id INTEGER PRIMARY KEY,
    frame_name TEXT NOT NULL,
    beta_relative_to_lab REAL NOT NULL,
    gamma REAL,
    notes TEXT
);

CREATE TABLE events (
    event_id INTEGER PRIMARY KEY,
    event_name TEXT NOT NULL,
    ct REAL NOT NULL,
    x REAL NOT NULL,
    y REAL NOT NULL,
    z REAL NOT NULL,
    notes TEXT
);

CREATE TABLE velocity_examples (
    velocity_id INTEGER PRIMARY KEY,
    case_id TEXT NOT NULL,
    beta REAL NOT NULL,
    gamma REAL,
    notes TEXT
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE model_metadata (
    model_id INTEGER PRIMARY KEY,
    model_or_concept TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    key_quantity TEXT,
    limitation TEXT
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
(1, 'speed of light', 'c', 299792458.0, 'm s^-1', 'exact SI value'),
(2, 'meter', 'm', 1.0, 'm', 'SI length unit'),
(3, 'second', 's', 1.0, 's', 'SI time unit'),
(4, 'electron volt', 'eV', 1.602176634e-19, 'J', 'energy conversion'),
(5, 'electron mass', 'm_e', 9.1093837015e-31, 'kg', 'electron mass example');

INSERT INTO frames (
    frame_id,
    frame_name,
    beta_relative_to_lab,
    gamma,
    notes
) VALUES
(1, 'lab', 0.0, 1.0, 'reference inertial frame'),
(2, 'moving_beta_0_5', 0.5, 1.154700538, 'example moving frame'),
(3, 'moving_beta_0_8', 0.8, 1.666666667, 'example moving frame'),
(4, 'moving_beta_0_99', 0.99, 7.08881205, 'near-light-speed example frame');

INSERT INTO events (
    event_id,
    event_name,
    ct,
    x,
    y,
    z,
    notes
) VALUES
(1, 'A', 0.0, 0.0, 0.0, 0.0, 'origin event'),
(2, 'B', 2.0, 1.0, 0.0, 0.0, 'timelike-separated sample'),
(3, 'C', 4.0, 2.5, 0.5, 0.0, 'three-dimensional event sample'),
(4, 'D', 6.0, 3.0, 0.0, 0.25, 'spacetime event sample'),
(5, 'E', 3.0, 3.0, 0.0, 0.0, 'null-like sample in one dimension');

INSERT INTO velocity_examples (
    velocity_id,
    case_id,
    beta,
    gamma,
    notes
) VALUES
(1, 'V00', 0.0, 1.0, 'rest frame'),
(2, 'V01', 0.1, 1.005037815, 'low-speed relativistic correction'),
(3, 'V03', 0.3, 1.048284837, 'moderate relativistic correction'),
(4, 'V05', 0.5, 1.154700538, 'clear relativistic effects'),
(5, 'V08', 0.8, 1.666666667, 'strong relativistic effects'),
(6, 'V09', 0.9, 2.294157339, 'high gamma regime'),
(7, 'V099', 0.99, 7.08881205, 'near-light-speed regime');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'dimensionless_velocity', 'beta = v/c', 'beta,v,c', 'velocity as a fraction of light speed'),
(2, 'lorentz_factor', 'gamma = 1/sqrt(1-beta^2)', 'gamma,beta', 'controls relativistic departure from Newtonian kinematics'),
(3, 'lorentz_transform_x', 'x_prime = gamma (x - beta ct)', 'x_prime,gamma,x,beta,ct', 'spatial coordinate transformation in compatible units'),
(4, 'lorentz_transform_ct', 'ct_prime = gamma (ct - beta x)', 'ct_prime,gamma,ct,beta,x', 'time coordinate transformation in compatible units'),
(5, 'spacetime_interval', 'Delta s^2 = c^2 Delta t^2 - Delta x^2 - Delta y^2 - Delta z^2', 's,c,t,x,y,z', 'Lorentz-invariant event separation'),
(6, 'time_dilation', 'Delta t = gamma Delta tau', 'Delta t,gamma,Delta tau', 'moving clock time dilation'),
(7, 'length_contraction', 'L = L0/gamma', 'L,L0,gamma', 'length contraction along direction of motion'),
(8, 'velocity_composition', 'u_prime = (u-v)/(1-uv/c^2)', 'u_prime,u,v,c', 'relativistic collinear velocity transformation'),
(9, 'energy_momentum', 'E^2 = (pc)^2 + (mc^2)^2', 'E,p,c,m', 'relativistic energy-momentum invariant'),
(10, 'rapidity', 'beta = tanh eta', 'beta,eta', 'boost parameter with additive composition');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'Lorentz transformation', 'coordinate transformation between inertial frames', 'gamma', 'flat spacetime only'),
(2, 'spacetime interval', 'invariant event separation', 'Delta s squared', 'special relativity without curvature'),
(3, 'velocity composition', 'frame-aware velocity transformation', 'beta_prime', 'collinear form in article examples'),
(4, 'rapidity', 'additive boost parameter', 'eta', 'most direct for collinear boosts'),
(5, 'relativistic Doppler shift', 'frequency transformation', 'Doppler factor', 'line-of-sight form in article examples'),
(6, 'energy momentum relation', 'relativistic particle kinematics', 'E^2 - p^2 c^2', 'no quantum field dynamics included');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'Einstein 1905 On the Electrodynamics of Moving Bodies', 'Primary historical source', 'special relativity foundation', 'https://www.fourmilab.ch/etexts/einstein/specrel/specrel.pdf'),
(2, 'Minkowski Space and Time', 'Primary historical source', 'spacetime formulation', 'https://mathweb.ucsd.edu/~b3tran/cgm/Minkowski_SpaceAndTime_1909.pdf'),
(3, 'BIPM SI Brochure', 'BIPM', 'SI reference and speed of light as defining constant', 'https://www.bipm.org/en/si-brochure-9'),
(4, 'BIPM Defining Constants', 'BIPM', 'SI defining constants overview', 'https://www.bipm.org/en/measurement-units/si-defining-constants'),
(5, 'NIST Speed of Light', 'NIST', 'CODATA speed of light value', 'https://physics.nist.gov/cgi-bin/cuu/Value?c='),
(6, 'NIST GPS Relativity', 'Ashby/NIST', 'relativity in navigation and time comparison', 'https://www.nist.gov/publications/global-positioning-system-relativity-and-extraterrestrial-navigation'),
(7, 'NIST SP 330', 'NIST', 'International System of Units reference', 'https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.330-2019.pdf');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'lorentz_transform_intervals', 'Uses flat spacetime and inertial frames.'),
(2, 'lorentz_transform_intervals', 'Uses compatible length units for ct and spatial coordinates.'),
(3, 'velocity_composition_rapidity', 'Uses collinear velocity composition only.'),
(4, 'relativistic_doppler_shift', 'Uses line-of-sight approach and recession forms.'),
(5, 'relativity_schema', 'Stores educational metadata rather than production navigation or accelerator data.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'relativity-and-the-reconstruction-of-space-and-time', 'lorentz_transform_intervals', 'closed_form_transform', 'beta=0.8 and sample events', 'transformed events and interval checks', '2026-04-24'),
(2, 'relativity-and-the-reconstruction-of-space-and-time', 'lorentz_factor_energy_scaling', 'parameter_sweep', 'beta from 0 to 0.995', 'gamma and kinetic-energy comparison', '2026-04-24'),
(3, 'relativity-and-the-reconstruction-of-space-and-time', 'velocity_composition_rapidity', 'closed_form_grid', 'selected beta pairs', 'direct and rapidity-based velocity composition', '2026-04-24'),
(4, 'relativity-and-the-reconstruction-of-space-and-time', 'relativistic_doppler_shift', 'parameter_sweep', 'beta from 0 to 0.99', 'approach and recession Doppler factors', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

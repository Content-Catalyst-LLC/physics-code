-- Energy, Work, and Conservation in Physical Systems Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, spring-mass cases, force-displacement data,
-- experimental measurements, physical relations, source notes, assumptions,
-- and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS spring_mass_cases;
DROP TABLE IF EXISTS force_displacement_measurements;
DROP TABLE IF EXISTS experimental_energy_measurements;
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

CREATE TABLE spring_mass_cases (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    spring_constant_n_per_m REAL NOT NULL,
    amplitude_m REAL NOT NULL,
    damping_kg_per_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE force_displacement_measurements (
    point_id INTEGER PRIMARY KEY,
    displacement_m REAL NOT NULL,
    force_n REAL NOT NULL,
    notes TEXT
);

CREATE TABLE experimental_energy_measurements (
    trial_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    spring_constant_n_per_m REAL NOT NULL,
    compression_m REAL NOT NULL,
    measured_speed_m_per_s REAL NOT NULL,
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
(1, 'standard gravity', 'g', 9.80665, 'm s^-2', 'standard acceleration due to gravity'),
(2, 'joule', 'J', 1.0, 'kg m^2 s^-2', 'SI unit of energy and work'),
(3, 'watt', 'W', 1.0, 'J s^-1', 'SI unit of power'),
(4, 'newton', 'N', 1.0, 'kg m s^-2', 'SI unit of force'),
(5, 'meter', 'm', 1.0, 'm', 'SI unit of length'),
(6, 'kilogram', 'kg', 1.0, 'kg', 'SI unit of mass'),
(7, 'second', 's', 1.0, 's', 'SI unit of time');

INSERT INTO spring_mass_cases (
    case_id,
    mass_kg,
    spring_constant_n_per_m,
    amplitude_m,
    damping_kg_per_s,
    notes
) VALUES
('base_conservative', 0.50, 20.0, 0.10, 0.00, 'article base conservative oscillator'),
('light_mass', 0.25, 20.0, 0.10, 0.00, 'lower mass comparison'),
('stiff_spring', 0.50, 40.0, 0.10, 0.00, 'higher stiffness comparison'),
('small_amplitude', 0.50, 20.0, 0.05, 0.00, 'lower stored energy comparison'),
('damped_base', 0.50, 20.0, 0.10, 0.25, 'damped oscillator comparison'),
('high_damping', 0.50, 20.0, 0.10, 0.75, 'stronger damping comparison');

INSERT INTO force_displacement_measurements (
    point_id,
    displacement_m,
    force_n,
    notes
) VALUES
(1, 0.00, 0.0, 'initial point'),
(2, 0.02, 0.4, 'linear spring-style measurement'),
(3, 0.04, 0.8, 'linear spring-style measurement'),
(4, 0.06, 1.2, 'linear spring-style measurement'),
(5, 0.08, 1.6, 'linear spring-style measurement'),
(6, 0.10, 2.0, 'linear spring-style measurement');

INSERT INTO experimental_energy_measurements (
    trial_id,
    mass_kg,
    spring_constant_n_per_m,
    compression_m,
    measured_speed_m_per_s,
    notes
) VALUES
('T01', 0.50, 20.0, 0.10, 0.63, 'illustrative spring launch trial'),
('T02', 0.50, 20.0, 0.10, 0.64, 'illustrative spring launch trial'),
('T03', 0.50, 20.0, 0.10, 0.62, 'illustrative spring launch trial'),
('T04', 0.50, 20.0, 0.08, 0.50, 'illustrative spring launch trial'),
('T05', 0.50, 20.0, 0.12, 0.75, 'illustrative spring launch trial');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'constant-force work', 'W = F d', 'W,F,d', 'work under constant force parallel to displacement'),
(2, 'general work integral', 'W = integral F dot dr', 'W,F,r', 'line integral of force along path'),
(3, 'work-energy theorem', 'W_net = Delta K', 'W,K', 'net work equals change in kinetic energy'),
(4, 'kinetic energy', 'K = 1/2 m v^2', 'K,m,v', 'energy associated with motion'),
(5, 'spring potential energy', 'U = 1/2 k x^2', 'U,k,x', 'elastic stored energy'),
(6, 'gravitational potential energy', 'U = m g h', 'U,m,g,h', 'near-surface gravitational potential energy'),
(7, 'mechanical energy', 'E = K + U', 'E,K,U', 'mechanical energy in conservative systems'),
(8, 'conservative force', 'F = -dU/dx', 'F,U,x', 'force from one-dimensional potential-energy gradient'),
(9, 'nonconservative work balance', 'Delta K + Delta U = W_nc', 'K,U,W_nc', 'mechanical-energy balance with non-conservative work'),
(10, 'instantaneous power', 'P = F dot v', 'P,F,v', 'rate of work or energy transfer');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'spring-mass oscillator', 'energy exchange between kinetic and elastic potential', 'total mechanical energy', 'ideal linear spring'),
(2, 'damped oscillator', 'mechanical energy decay under damping', 'total mechanical energy', 'simple velocity-proportional damping'),
(3, 'work-energy theorem', 'connect net work to kinetic-energy change', 'Delta K', 'requires careful force accounting'),
(4, 'energy landscape', 'identify turning points and accessible regions', 'E and U(x)', 'conservative one-dimensional form'),
(5, 'force-displacement integration', 'compute work from measured force data', 'W', 'depends on measurement resolution'),
(6, 'power estimate', 'rate of energy transfer', 'P', 'requires time-resolved transfer information'),
(7, 'spring launch residuals', 'compare theoretical and measured final speed', 'residual speed or energy', 'illustrative dataset only');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'BIPM SI Brochure PDF', 'BIPM', 'joule and watt definitions', 'https://www.bipm.org/documents/20126/41483022/SI-Brochure-9-EN.pdf'),
(3, 'NIST SI Guide', 'NIST', 'SI unit guidance', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(4, 'NIST Joule', 'NIST', 'glossary entry for joule', 'https://www.nist.gov/glossary-term/26261'),
(5, 'MIT Classical Mechanics', 'MIT OpenCourseWare', 'classical mechanics course', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/'),
(6, 'MIT Chapter 13 Energy Kinetic Energy and Work', 'MIT OpenCourseWare', 'work-energy theorem and kinetic energy', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/mit8_01scs22_chapter13.pdf'),
(7, 'Joule 1850 Royal Society', 'Royal Society', 'mechanical equivalent of heat source paper', 'https://royalsocietypublishing.org/rstl/article/doi/10.1098/rstl.1850.0004/118347/III-On-the-mechanical-equivalent-of-heat'),
(8, 'Joule 1850 Internet Archive', 'Internet Archive', 'archive copy of mechanical equivalent of heat', 'https://archive.org/details/philtrans00608634'),
(9, 'Helmholtz Conservation of Force', 'Information Philosopher', 'English translation of Helmholtz memoir', 'https://informationphilosopher.com/solutions/scientists/helmholtz/Helmholtz.pdf');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'spring_energy_simulation', 'Uses one-dimensional spring-mass motion with ideal linear spring behavior.'),
(2, 'spring_energy_simulation', 'Compares conservative motion with simple velocity-proportional damping.'),
(3, 'work_energy_theorem_check', 'Uses trapezoidal integration of force-displacement measurements.'),
(4, 'energy_landscape_accessible_motion', 'Uses a one-dimensional conservative potential-energy landscape.'),
(5, 'experimental_energy_residuals', 'Uses illustrative spring-launch measurements rather than calibrated laboratory data.'),
(6, 'energy_work_conservation_schema', 'Stores educational metadata rather than a production mechanics database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'energy-work-and-conservation-in-physical-systems', 'spring_energy_simulation', 'ode_integration', 'm=0.50 kg, k=20 N/m, x0=0.10 m, damping=0 or 0.25 kg/s', 'energy table and conservative/damped summaries', '2026-04-25'),
(2, 'energy-work-and-conservation-in-physical-systems', 'work_energy_theorem_check', 'trapezoidal_integration', 'force-displacement measurements from 0 to 0.10 m', 'numeric work and predicted final speed', '2026-04-25'),
(3, 'energy-work-and-conservation-in-physical-systems', 'energy_landscape_accessible_motion', 'grid_evaluation', 'U(x)=0.5kx^2+a x^4 with E=0.40 J', 'accessible-motion table and turning-region summary', '2026-04-25'),
(4, 'energy-work-and-conservation-in-physical-systems', 'spring_mass_energy_accounting', 'closed_form_time_series', 'ideal oscillator from 0 to 10 s', 'kinetic potential and total energy table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

-- Plasma Physics and the Fourth State of Matter Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores plasma constants, plasma regime cases, magnetic-field cases,
-- particle species, diagnostics, physical relations, model metadata,
-- source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS plasma_constants;
DROP TABLE IF EXISTS plasma_regime_cases;
DROP TABLE IF EXISTS magnetic_field_cases;
DROP TABLE IF EXISTS particle_species;
DROP TABLE IF EXISTS diagnostic_catalog;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE plasma_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE plasma_regime_cases (
    case_id TEXT PRIMARY KEY,
    electron_density_m3 REAL NOT NULL,
    electron_temperature_ev REAL NOT NULL,
    ion_temperature_ev REAL NOT NULL,
    ion_mass_amu REAL NOT NULL,
    charge_state INTEGER NOT NULL,
    magnetic_field_t REAL NOT NULL,
    system_size_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE magnetic_field_cases (
    case_id TEXT PRIMARY KEY,
    magnetic_field_t REAL NOT NULL,
    perpendicular_speed_m_s REAL NOT NULL,
    particle_species TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE particle_species (
    species TEXT PRIMARY KEY,
    charge_c REAL NOT NULL,
    mass_kg REAL NOT NULL,
    charge_state INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE diagnostic_catalog (
    diagnostic TEXT PRIMARY KEY,
    primary_quantity TEXT NOT NULL,
    typical_context TEXT NOT NULL,
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

INSERT INTO plasma_constants VALUES
('elementary_charge', 1.602176634e-19, 'C', 'exact SI value'),
('electron_mass', 9.1093837015e-31, 'kg', 'electron rest mass'),
('proton_mass', 1.67262192369e-27, 'kg', 'proton rest mass'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('vacuum_permittivity', 8.8541878128e-12, 'F m^-1', 'electric constant'),
('vacuum_permeability', 1.25663706212e-6, 'H m^-1', 'magnetic constant approximate'),
('ev_to_joule', 1.602176634e-19, 'J per eV', 'exact conversion'),
('ev_to_kelvin', 11604.51812, 'K per eV', 'temperature equivalent');

INSERT INTO plasma_regime_cases VALUES
('low_temperature_discharge', 1.0e16, 3, 0.03, 40, 1, 0.01, 0.1, 'weakly ionized industrial-style plasma scale'),
('space_plasma', 1.0e6, 10, 10, 1, 1, 1.0e-8, 1.0e7, 'solar-wind-like educational scale'),
('fusion_core', 1.0e20, 10000, 10000, 2.5, 1, 5.0, 2.0, 'magnetic-fusion core educational scale'),
('ionosphere', 1.0e11, 0.2, 0.1, 16, 1, 5.0e-5, 1.0e5, 'ionospheric educational scale'),
('laboratory_plasma', 1.0e18, 10, 1, 1, 1, 0.1, 1.0, 'laboratory plasma example');

INSERT INTO magnetic_field_cases VALUES
('electron_weak_field', 0.01, 1.0e5, 'electron', 'electron gyration in weak laboratory field'),
('electron_strong_field', 1.0, 1.0e5, 'electron', 'electron gyration in stronger field'),
('proton_weak_field', 0.01, 1.0e5, 'proton', 'ion gyration in weak laboratory field'),
('proton_strong_field', 1.0, 1.0e5, 'proton', 'ion gyration in stronger field'),
('fusion_deuteron', 5.0, 1.0e6, 'deuteron', 'magnetized fusion ion educational case');

INSERT INTO particle_species VALUES
('electron', -1.602176634e-19, 9.1093837015e-31, -1, 'electron'),
('proton', 1.602176634e-19, 1.67262192369e-27, 1, 'hydrogen ion'),
('deuteron', 1.602176634e-19, 3.3435837724e-27, 1, 'deuterium ion'),
('alpha', 3.204353268e-19, 6.6446573357e-27, 2, 'helium nucleus'),
('argon_ion', 1.602176634e-19, 6.6335209e-26, 1, 'argon ion approximate');

INSERT INTO diagnostic_catalog VALUES
('Langmuir probe', 'electron temperature and density', 'low-temperature plasma', 'can perturb plasma and depends on sheath model'),
('Thomson scattering', 'electron temperature and density', 'fusion and laboratory plasma', 'nonintrusive but technically demanding'),
('magnetic probe', 'magnetic fluctuations', 'laboratory plasma', 'measures time-varying magnetic fields'),
('interferometry', 'line-integrated density', 'fusion and plasma devices', 'requires inversion for profiles'),
('spectroscopy', 'composition temperature flow', 'laboratory astrophysical and industrial plasma', 'depends on atomic models'),
('reflectometry', 'density profiles and fluctuations', 'fusion plasma', 'uses wave reflection from cutoff layers'),
('bolometry', 'radiated power', 'fusion plasma', 'integrated radiation measurement'),
('charged particle analyzer', 'particle energy distribution', 'space and laboratory plasma', 'requires access to particles');

INSERT INTO physical_relations VALUES
(1, 'Debye length', 'lambda_D = sqrt(epsilon_0 kB Te/(ne e^2))', 'lambda_D,epsilon_0,kB,Te,ne,e', 'electrostatic shielding length'),
(2, 'electron plasma frequency', 'omega_pe = sqrt(ne e^2/(epsilon_0 me))', 'omega_pe,ne,e,epsilon_0,me', 'collective electron oscillation frequency'),
(3, 'cyclotron frequency', 'Omega_c = |q|B/m', 'Omega_c,q,B,m', 'charged-particle gyration frequency'),
(4, 'Larmor radius', 'r_L = m v_perp/(|q|B)', 'r_L,m,v_perp,q,B', 'charged-particle gyro-orbit radius'),
(5, 'thermal speed', 'v_th = sqrt(kB T/m)', 'v_th,kB,T,m', 'characteristic particle speed'),
(6, 'Alfven speed', 'v_A = B/sqrt(mu_0 rho)', 'v_A,B,mu_0,rho', 'magnetized plasma wave speed'),
(7, 'plasma beta', 'beta = 2 mu_0 p/B^2', 'beta,mu_0,p,B', 'ratio of plasma pressure to magnetic pressure'),
(8, 'Lorentz force', 'm dv/dt = q(E + v x B)', 'm,v,t,q,E,B', 'force on charged particle'),
(9, 'E cross B drift', 'v_E = E x B/B^2', 'v_E,E,B', 'charge-independent cross-field drift'),
(10, 'Debye sphere population', 'N_D = (4 pi/3) ne lambda_D^3', 'N_D,ne,lambda_D', 'number of particles in a Debye sphere');

INSERT INTO model_metadata VALUES
(1, 'debye_length', 'electrostatic shielding', 'lambda_D', 'assumes simple electron shielding model'),
(2, 'plasma_frequency', 'collective oscillation', 'omega_pe', 'cold unmagnetized approximation in simplest form'),
(3, 'cyclotron_motion', 'magnetized particle motion', 'Omega_c and r_L', 'uniform field idealization'),
(4, 'plasma_beta', 'pressure comparison', 'beta', 'depends on pressure model and magnetic geometry'),
(5, 'alfven_speed', 'magnetized wave scale', 'v_A', 'MHD scale approximation'),
(6, 'lorentz_orbit', 'single-particle motion', 'trajectory', 'no self-consistent fields or collisions'),
(7, 'fluid_model', 'macroscopic plasma dynamics', 'density velocity pressure', 'can miss kinetic effects'),
(8, 'kinetic_model', 'velocity-space dynamics', 'distribution function', 'high computational cost');

INSERT INTO source_notes VALUES
(1, 'Princeton Plasma Physics Courses', 'Princeton Program in Plasma Physics', 'course descriptions covering Debye shielding frequencies orbit theory MHD waves instabilities kinetic theory', 'https://plasma.princeton.edu/courses'),
(2, 'NRL Plasma Formulary', 'Naval Research Laboratory', 'reference formulas for plasma parameters', 'https://www.nrl.navy.mil/Our-Work/Areas-of-Research/Plasma-Physics/NRL-Plasma-Formulary/'),
(3, 'DOE Fusion Energy Sciences', 'DOE Office of Science', 'official fusion and plasma science program overview', 'https://www.energy.gov/science/fes/fusion-energy-sciences'),
(4, 'DOE Explains Fusion Energy Science', 'DOE Office of Science', 'public explanation of fusion energy science', 'https://www.energy.gov/science/doe-explainsfusion-energy-science'),
(5, 'DOE Explains Plasma Confinement', 'DOE Office of Science', 'public explanation of plasma confinement', 'https://www.energy.gov/science/doe-explainsplasma-confinement'),
(6, 'PPPL About Plasmas and Fusion', 'Princeton Plasma Physics Laboratory', 'public explanation of plasmas and fusion', 'https://www.pppl.gov/about/about-plasmas-and-fusion'),
(7, 'NASA What Is Plasma', 'NASA Goddard Space Flight Center', 'public explanation of plasma in space and universe', 'https://svs.gsfc.nasa.gov/14299/'),
(8, 'ITER Plasma Physics', 'ITER Organization', 'plasma physics and magnetic fusion explanation', 'https://www.iter.org/fusion-energy/making-it-work'),
(9, 'IAEA Magnetic Fusion Confinement', 'IAEA', 'tokamak and stellarator magnetic confinement overview', 'https://www.iaea.org/bulletin/magnetic-fusion-confinement-with-tokamaks-and-stellarators');

INSERT INTO model_assumptions VALUES
(1, 'plasma_parameter_sweep', 'Uses simplified quasi-neutral plasma parameter formulas and fixed regime inputs.'),
(2, 'debye_plasma_frequency', 'Uses electron temperature in eV and density in SI units.'),
(3, 'alfven_beta_diagnostics', 'Uses ion mass density and scalar pressure approximations.'),
(4, 'charged_particle_gyration', 'Uses single-particle Lorentz-force motion in uniform prescribed fields.'),
(5, 'plasma_parameter_sensitivity', 'Uses simplified sensitivity sweeps without collisions or self-consistent field solves.'),
(6, 'plasma_physics_schema', 'Stores educational metadata rather than a production plasma simulation database.');

INSERT INTO simulation_runs VALUES
(1, 'plasma-physics-and-the-fourth-state-of-matter', 'plasma_parameter_sweep', 'closed_form_parameter_diagnostics', 'sample plasma regimes', 'Debye length plasma frequency beta and Alfven speed table', '2026-04-25'),
(2, 'plasma-physics-and-the-fourth-state-of-matter', 'debye_plasma_frequency', 'parameter_grid', 'density and electron temperature grid', 'Debye length frequency and Debye sphere table', '2026-04-25'),
(3, 'plasma-physics-and-the-fourth-state-of-matter', 'alfven_beta_diagnostics', 'closed_form_MHD_scale_diagnostics', 'sample plasma regimes', 'Alfven speed and beta table', '2026-04-25'),
(4, 'plasma-physics-and-the-fourth-state-of-matter', 'charged_particle_gyration', 'Lorentz_force_ODE_integration', 'electron in uniform magnetic field', 'trajectory and gyration diagnostics', '2026-04-25'),
(5, 'plasma-physics-and-the-fourth-state-of-matter', 'plasma_parameter_sensitivity', 'R_parameter_sweep', 'density temperature magnetic field grid', 'sensitivity and summary tables', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

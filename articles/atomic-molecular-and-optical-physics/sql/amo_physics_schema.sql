-- Atomic, Molecular, and Optical Physics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, spectral series, molecular rotor cases, Rabi parameters,
-- model metadata, physical relations, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS amo_constants;
DROP TABLE IF EXISTS hydrogen_series_cases;
DROP TABLE IF EXISTS molecular_rotor_cases;
DROP TABLE IF EXISTS rabi_parameter_cases;
DROP TABLE IF EXISTS spectral_line_samples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE amo_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE hydrogen_series_cases (
    series TEXT PRIMARY KEY,
    n_lower INTEGER NOT NULL,
    n_upper_min INTEGER NOT NULL,
    n_upper_max INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE molecular_rotor_cases (
    case_id TEXT PRIMARY KEY,
    rotational_constant_cm_inv REAL NOT NULL,
    temperature_k REAL NOT NULL,
    j_max INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE rabi_parameter_cases (
    case_id TEXT PRIMARY KEY,
    rabi_frequency_rad_s REAL NOT NULL,
    detuning_rad_s REAL NOT NULL,
    time_end_s REAL NOT NULL,
    n_time_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE spectral_line_samples (
    sample_id INTEGER PRIMARY KEY,
    wavelength_nm REAL NOT NULL,
    intensity REAL NOT NULL,
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

INSERT INTO amo_constants VALUES
('speed_of_light', 299792458, 'm s^-1', 'exact SI value'),
('planck_constant', 6.62607015e-34, 'J s', 'exact SI value'),
('reduced_planck_constant', 1.054571817e-34, 'J s', 'derived approximate value'),
('elementary_charge', 1.602176634e-19, 'C', 'exact SI value'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('rydberg_hydrogen', 1.096775834e7, 'm^-1', 'approximate hydrogen Rydberg value for educational calculations'),
('hc_ev_nm', 1239.841984, 'eV nm', 'useful photon energy conversion'),
('boltzmann_cm_inv_per_k', 0.69503476, 'cm^-1 K^-1', 'useful spectroscopy conversion');

INSERT INTO hydrogen_series_cases VALUES
('Lyman', 1, 2, 10, 'ultraviolet hydrogen series'),
('Balmer', 2, 3, 10, 'visible and near ultraviolet hydrogen series'),
('Paschen', 3, 4, 12, 'infrared hydrogen series'),
('Brackett', 4, 5, 14, 'infrared hydrogen series');

INSERT INTO molecular_rotor_cases VALUES
('co_like_room_temperature', 1.93, 300, 30, 'illustrative CO-like rotor at room temperature'),
('light_rotor', 10.5, 300, 20, 'large rotational constant example'),
('heavy_rotor', 0.25, 300, 60, 'small rotational constant example'),
('cold_rotor', 1.93, 30, 30, 'cold rotational distribution example'),
('hot_rotor', 1.93, 1000, 60, 'hot rotational distribution example');

INSERT INTO rabi_parameter_cases VALUES
('on_resonance', 1000000, 0, 0.00002, 1000, 'ideal resonant two-level drive'),
('moderate_detuning', 1000000, 500000, 0.00002, 1000, 'detuned drive comparison'),
('large_detuning', 1000000, 2000000, 0.00002, 1000, 'off-resonant suppression'),
('slow_drive', 250000, 0, 0.00008, 1000, 'lower Rabi frequency');

INSERT INTO spectral_line_samples VALUES
(1, 654.8, 0.12, 'synthetic left wing'),
(2, 655.2, 0.20, 'synthetic left wing'),
(3, 655.6, 0.41, 'synthetic rising line'),
(4, 656.0, 0.73, 'synthetic near center'),
(5, 656.3, 1.00, 'synthetic line center'),
(6, 656.6, 0.81, 'synthetic near center'),
(7, 657.0, 0.48, 'synthetic falling line'),
(8, 657.4, 0.24, 'synthetic right wing'),
(9, 657.8, 0.13, 'synthetic right wing');

INSERT INTO physical_relations VALUES
(1, 'photon energy', 'E = h nu', 'E,h,nu', 'photon energy from frequency'),
(2, 'wavelength frequency relation', 'c = lambda nu', 'c,lambda,nu', 'relation between light speed wavelength and frequency'),
(3, 'photon energy by wavelength', 'E = h c / lambda', 'E,h,c,lambda', 'photon energy from wavelength'),
(4, 'hydrogen energy level', 'E_n = -13.6 eV/n^2', 'E_n,n', 'leading hydrogenic bound-state energy'),
(5, 'Rydberg formula', '1/lambda = R_H(1/n_lower^2 - 1/n_upper^2)', 'lambda,R_H,n_lower,n_upper', 'hydrogen spectral transition wavelength'),
(6, 'rigid rotor energy', 'E_J = B J(J+1)', 'E_J,B,J', 'molecular rotational energy in spectroscopic units'),
(7, 'harmonic vibration energy', 'E_v = hbar omega(v+1/2)', 'E_v,hbar,omega,v', 'molecular harmonic oscillator energy'),
(8, 'Boltzmann population ratio', 'N_i/N_j = (g_i/g_j) exp[-(E_i-E_j)/(k_B T)]', 'N_i,N_j,g_i,g_j,E_i,E_j,k_B,T', 'thermal population ratio'),
(9, 'Rabi generalized frequency', 'Omega_R = sqrt(Omega^2 + Delta^2)', 'Omega_R,Omega,Delta', 'effective coherent drive frequency with detuning'),
(10, 'Rabi excited probability', 'P_e(t) = [Omega^2/Omega_R^2] sin^2(Omega_R t/2)', 'P_e,Omega,Omega_R,t', 'ideal two-level excited-state probability');

INSERT INTO model_metadata VALUES
(1, 'rydberg_formula', 'hydrogen spectral lines', 'wavelength', 'no fine hyperfine Lamb or isotope corrections'),
(2, 'photon_conversion', 'frequency wavelength energy conversion', 'h nu', 'requires unit consistency'),
(3, 'rigid_rotor', 'molecular rotation', 'J and B', 'ignores centrifugal distortion'),
(4, 'harmonic_vibrator', 'molecular vibration', 'v and omega', 'ignores anharmonicity'),
(5, 'boltzmann_population', 'thermal state populations', 'temperature and energy', 'assumes equilibrium'),
(6, 'two_level_rabi', 'coherent optical driving', 'Omega and Delta', 'ignores decay and decoherence'),
(7, 'gaussian_line_fit', 'simple spectroscopy', 'line center and width', 'not full Voigt or instrumental model');

INSERT INTO source_notes VALUES
(1, 'MIT Atomic and Optical Physics I', 'MIT OpenCourseWare', 'graduate foundations of atomic and optical physics', 'https://ocw.mit.edu/courses/8-421-atomic-and-optical-physics-i-spring-2014/'),
(2, 'MIT Atomic and Optical Physics II', 'MIT OpenCourseWare', 'quantum optics and advanced AMO topics', 'https://ocw.mit.edu/courses/8-422-atomic-and-optical-physics-ii-spring-2013/'),
(3, 'NIST Atomic Spectra Database', 'NIST', 'critically evaluated atomic energy levels wavelengths and transition probabilities', 'https://www.nist.gov/pml/atomic-spectra-database'),
(4, 'NIST Fundamental Constants', 'NIST', 'CODATA physical constants', 'https://physics.nist.gov/cuu/Constants/'),
(5, 'NIST Quantum Many Body Physics Quantum Optics and Quantum Information', 'NIST', 'AMO systems for quantum technology and simulation', 'https://www.nist.gov/programs-projects/quantum-many-body-physics-quantum-optics-and-quantum-information'),
(6, 'NSF Atomic Molecular Optical Physics Experiment', 'NSF', 'AMO experimental physics funding program', 'https://www.nsf.gov/funding/opportunities/atomic-molecular-optical-physics-experiment'),
(7, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/publications/si-brochure');

INSERT INTO model_assumptions VALUES
(1, 'hydrogen_spectral_lines', 'Uses the Rydberg formula without fine structure hyperfine structure Lamb shifts or isotope corrections.'),
(2, 'two_level_rabi_oscillations', 'Uses ideal coherent two-level dynamics without decay or decoherence.'),
(3, 'molecular_rotational_spectrum', 'Uses a rigid-rotor model and ignores centrifugal distortion.'),
(4, 'rotational_boltzmann_populations', 'Assumes thermal equilibrium rotational populations.'),
(5, 'spectral_line_fit_scaffold', 'Uses a Gaussian line model rather than a full Voigt or instrument response model.'),
(6, 'amo_physics_schema', 'Stores educational metadata rather than a production AMO database.');

INSERT INTO simulation_runs VALUES
(1, 'atomic-molecular-and-optical-physics', 'hydrogen_spectral_lines', 'Rydberg_formula_transition_table', 'Lyman Balmer Paschen Brackett series cases', 'hydrogen line wavelengths photon energies and frequencies', '2026-04-25'),
(2, 'atomic-molecular-and-optical-physics', 'two_level_rabi_oscillations', 'closed_form_Rabi_solution', 'sample Rabi frequencies and detunings', 'excited-state probability trajectories and summaries', '2026-04-25'),
(3, 'atomic-molecular-and-optical-physics', 'molecular_rotational_spectrum', 'rigid_rotor_table', 'sample rotational constants and J ranges', 'rotational energies and transition wavenumbers', '2026-04-25'),
(4, 'atomic-molecular-and-optical-physics', 'rotational_boltzmann_populations', 'Boltzmann_population_table', 'sample temperatures and rotational constants', 'thermal rotational population tables', '2026-04-25'),
(5, 'atomic-molecular-and-optical-physics', 'spectral_line_fit_scaffold', 'Gaussian_curve_fit', 'synthetic spectral line samples', 'line center width and residual diagnostics', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

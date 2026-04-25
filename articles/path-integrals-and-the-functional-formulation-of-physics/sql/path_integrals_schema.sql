-- Path Integrals and the Functional Formulation of Physics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, oscillator cases, sample paths, Gaussian diagnostics,
-- generating-functional cases, lattice scalar cases, stochastic path cases,
-- physical relations, model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS path_integral_constants;
DROP TABLE IF EXISTS euclidean_oscillator_cases;
DROP TABLE IF EXISTS sample_path_cases;
DROP TABLE IF EXISTS gaussian_integral_cases;
DROP TABLE IF EXISTS generating_functional_cases;
DROP TABLE IF EXISTS lattice_scalar_cases;
DROP TABLE IF EXISTS stochastic_path_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE path_integral_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE euclidean_oscillator_cases (
    case_id TEXT PRIMARY KEY,
    mass REAL NOT NULL,
    omega REAL NOT NULL,
    hbar REAL NOT NULL,
    beta REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    n_thermalization_sweeps INTEGER NOT NULL,
    n_measurement_sweeps INTEGER NOT NULL,
    proposal_width REAL NOT NULL,
    random_seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE sample_path_cases (
    path_name TEXT PRIMARY KEY,
    path_type TEXT NOT NULL,
    amplitude REAL NOT NULL,
    roughness_multiplier REAL NOT NULL,
    notes TEXT
);

CREATE TABLE gaussian_integral_cases (
    case_id TEXT PRIMARY KEY,
    a11 REAL NOT NULL,
    a12 REAL NOT NULL,
    a22 REAL NOT NULL,
    j1 REAL NOT NULL,
    j2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE generating_functional_cases (
    case_id TEXT PRIMARY KEY,
    propagator_value REAL NOT NULL,
    source_j1 REAL NOT NULL,
    source_j2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE lattice_scalar_cases (
    case_id TEXT PRIMARY KEY,
    n_sites INTEGER NOT NULL,
    lattice_spacing REAL NOT NULL,
    mass_squared REAL NOT NULL,
    lambda_coupling REAL NOT NULL,
    field_amplitude REAL NOT NULL,
    notes TEXT
);

CREATE TABLE stochastic_path_cases (
    case_id TEXT PRIMARY KEY,
    n_steps INTEGER NOT NULL,
    delta_t REAL NOT NULL,
    drift REAL NOT NULL,
    noise_sd REAL NOT NULL,
    random_seed INTEGER NOT NULL,
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

INSERT INTO path_integral_constants VALUES
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('hbar_natural', 1, 'dimensionless', 'hbar equals one convention for examples'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('default_mass', 1, 'dimensionless', 'teaching oscillator mass'),
('default_omega', 1, 'dimensionless', 'teaching oscillator angular frequency'),
('default_beta', 4, 'dimensionless', 'teaching Euclidean time extent');

INSERT INTO euclidean_oscillator_cases VALUES
('article_demo', 1.0, 1.0, 1.0, 4.0, 128, 1000, 3000, 0.8, 42, 'article body Euclidean harmonic oscillator example'),
('short_beta', 1.0, 1.0, 1.0, 2.0, 96, 800, 2000, 0.8, 101, 'shorter imaginary-time extent'),
('stiff_oscillator', 1.0, 2.0, 1.0, 4.0, 128, 1000, 3000, 0.5, 202, 'higher angular frequency oscillator'),
('large_mass', 2.0, 1.0, 1.0, 4.0, 128, 1000, 3000, 0.5, 303, 'larger mass suppresses rough paths');

INSERT INTO sample_path_cases VALUES
('zero_path', 'zero', 0.0, 0.0, 'minimal reference path'),
('sine_path', 'sine', 1.0, 0.0, 'smooth periodic path'),
('rough_path', 'sine_plus_harmonic', 1.0, 0.25, 'smooth path with higher-frequency roughness'),
('large_amplitude_sine', 'sine', 2.0, 0.0, 'larger potential contribution');

INSERT INTO gaussian_integral_cases VALUES
('diagonal_unit', 1.0, 0.0, 1.0, 0.5, -0.25, 'simple diagonal positive definite matrix'),
('coupled_modes', 2.0, 0.3, 1.5, 1.0, 0.5, 'coupled two-dimensional Gaussian'),
('stiff_first_mode', 4.0, 0.2, 1.0, 0.75, -0.5, 'large first eigenvalue'),
('near_decoupled', 1.5, 0.05, 1.2, 0.25, 0.25, 'weakly coupled modes');

INSERT INTO generating_functional_cases VALUES
('unit_propagator', 1.0, 0.5, -0.25, 'two-source Gaussian generating functional scaffold'),
('strong_correlation', 2.0, 0.5, 0.5, 'larger two-point kernel'),
('weak_correlation', 0.25, 1.0, -1.0, 'smaller two-point kernel'),
('zero_source', 1.0, 0.0, 0.0, 'normalization check');

INSERT INTO lattice_scalar_cases VALUES
('free_light', 32, 1.0, 0.5, 0.0, 0.5, 'free scalar field scaffold'),
('free_heavy', 32, 1.0, 2.0, 0.0, 0.5, 'larger mass squared'),
('interacting_weak', 32, 1.0, 0.5, 0.2, 0.5, 'weak phi-four interaction'),
('interacting_stronger', 32, 1.0, 0.5, 1.0, 0.5, 'stronger phi-four scaffold');

INSERT INTO stochastic_path_cases VALUES
('brownian_zero_drift', 1000, 0.01, 0.0, 1.0, 42, 'Brownian scaffold with zero drift'),
('positive_drift', 1000, 0.01, 0.2, 1.0, 101, 'drifted stochastic path'),
('low_noise', 1000, 0.01, 0.0, 0.25, 202, 'lower-noise path'),
('high_noise', 1000, 0.01, 0.0, 2.0, 303, 'higher-noise path');

INSERT INTO physical_relations VALUES
(1, 'classical action', 'S[q] = integral L(q, qdot, t) dt', 'S,L,q,qdot,t', 'action functional for classical dynamics'),
(2, 'stationary action', 'delta S = 0', 'S', 'classical path condition'),
(3, 'quantum propagator', 'K(q_f,t_f;q_i,t_i) = integral Dq exp(i S[q]/hbar)', 'K,q,S,hbar', 'sum over histories expression for transition amplitude'),
(4, 'phase-space path integral', 'K = integral Dp Dq exp((i/hbar) integral (p qdot - H) dt)', 'K,p,q,H,hbar', 'Hamiltonian form of path integral'),
(5, 'Euclidean path integral', 'Z = integral Dq exp(-S_E[q]/hbar)', 'Z,q,S_E,hbar', 'imaginary-time statistical weight'),
(6, 'Euclidean oscillator action', 'S_E = sum_n [m/(2 Delta tau)(x_{n+1}-x_n)^2 + Delta tau/2 m omega^2 x_n^2]', 'S_E,m,Delta tau,x,omega', 'discretized harmonic oscillator Euclidean action'),
(7, 'Gaussian integral', 'Integral dx exp(-1/2 x^T A x + J^T x) = sqrt((2pi)^n/det A) exp(1/2 J^T A^-1 J)', 'A,J,x', 'finite-dimensional Gaussian source integral'),
(8, 'generating functional', 'Z[J] = integral Dphi exp((i/hbar)(S[phi] + integral J phi))', 'Z,J,phi,S,hbar', 'source-dependent functional generating correlations'),
(9, 'two-point function', 'G(x,y) = <T phi(x) phi(y)>', 'G,phi,x,y', 'time-ordered correlation function'),
(10, 'lattice scalar action', 'S_E = sum_x [1/2 grad phi squared + 1/2 m^2 phi^2 + lambda/4! phi^4]', 'S_E,phi,m,lambda', 'Euclidean scalar field lattice scaffold'),
(11, 'stochastic path update', 'x[n+1] = x[n] + drift dt + noise_sd sqrt(dt) eta[n]', 'x,dt,eta', 'drift-diffusion stochastic path scaffold'),
(12, 'path weight', 'w[path] = exp(-S_E[path]/hbar)', 'w,S_E,hbar', 'Euclidean sampling weight');

INSERT INTO model_metadata VALUES
(1, 'discretized_euclidean_action', 'path weighting', 'S_E', 'depends on discretization and boundary conditions'),
(2, 'euclidean_oscillator_monte_carlo', 'path sampling', 'mean x squared', 'teaching sampler with local updates'),
(3, 'gaussian_integral_diagnostics', 'free theory diagnostics', 'determinant and inverse kernel', 'finite-dimensional scaffold'),
(4, 'generating_functional_scaffold', 'correlation generation', 'Z[J]', 'toy two-source expression'),
(5, 'lattice_scalar_field_scaffold', 'field configuration action', 'S_E phi', 'not production lattice field theory'),
(6, 'stochastic_path_scaffold', 'noisy histories', 'path statistics', 'simple Gaussian increments only'),
(7, 'sql_metadata', 'reproducibility', 'actions assumptions and sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Quantum Theory I Lecture 10', 'MIT OpenCourseWare', 'path integral formulation of quantum mechanics and propagator', 'https://ocw.mit.edu/courses/8-321-quantum-theory-i-fall-2017/e7c103b8e7ee71a613da948682f9a123_MIT8_321F17_lec10.pdf'),
(2, 'MIT Quantum Theory I Lecture 11', 'MIT OpenCourseWare', 'path integrals and interpretive use of alternative formulations', 'https://ocw.mit.edu/courses/8-321-quantum-theory-i-fall-2017/ea27e6d1653b49990d3d9d317d570328_MIT8_321F17_lec11.pdf'),
(3, 'MIT QFT I Lecture 8', 'MIT OpenCourseWare', 'path integral formalism for non-relativistic quantum mechanics and Gaussian path integrals', 'https://ocw.mit.edu/courses/8-323-relativistic-quantum-field-theory-i-spring-2023/resources/ocw_8323_lecture08_2023mar03_mp4/'),
(4, 'MIT QFT I Lecture 9', 'MIT OpenCourseWare', 'path integral formalism for QFT correlation functions and generating functional', 'https://ocw.mit.edu/courses/8-323-relativistic-quantum-field-theory-i-spring-2023/resources/ocw_8323_lecture09_2023mar06_mp4/'),
(5, 'MIT QFT I Lecture 19', 'MIT OpenCourseWare', 'path integrals of fermions', 'https://ocw.mit.edu/courses/8-323-relativistic-quantum-field-theory-i-spring-2023/resources/ocw_8323_lecture19_2023apr19_mp4/'),
(6, 'Stanford Quantum Theory and Mathematical Rigor', 'Stanford Encyclopedia of Philosophy', 'mathematical rigor and QFT foundations', 'https://plato.stanford.edu/entries/qt-nvd/'),
(7, 'Feynman and Hibbs Quantum Mechanics and Path Integrals', 'Dover', 'classic path integral textbook', 'https://store.doverpublications.com/products/9780486477220'),
(8, 'Kleinert Path Integrals', 'World Scientific', 'broad path-integral reference across physics and stochastic systems', 'https://www.worldscientific.com/worldscibooks/10.1142/7305');

INSERT INTO model_assumptions VALUES
(1, 'discretized_euclidean_action', 'Uses periodic boundary conditions and hbar equals one in the default examples.'),
(2, 'euclidean_oscillator_monte_carlo', 'Uses local Metropolis updates and teaching-scale sampling.'),
(3, 'gaussian_integral_diagnostics', 'Uses finite-dimensional positive-definite matrices rather than full functional determinants.'),
(4, 'generating_functional_scaffold', 'Uses a toy two-source Gaussian expression.'),
(5, 'lattice_scalar_field_scaffold', 'Uses deterministic sinusoidal field configurations rather than Monte Carlo field sampling.'),
(6, 'stochastic_path_scaffold', 'Uses Gaussian increments and simple drift-diffusion dynamics.'),
(7, 'path_integrals_schema', 'Stores educational metadata rather than a production path-integral database.');

INSERT INTO simulation_runs VALUES
(1, 'path-integrals-and-the-functional-formulation-of-physics', 'discretized_euclidean_action', 'deterministic_path_grid', 'zero sine and rough paths', 'path action and relative weight tables', '2026-04-25'),
(2, 'path-integrals-and-the-functional-formulation-of-physics', 'euclidean_oscillator_monte_carlo', 'metropolis_path_sampling', 'Euclidean oscillator cases', 'sampled action mean x and mean x squared', '2026-04-25'),
(3, 'path-integrals-and-the-functional-formulation-of-physics', 'gaussian_integral_diagnostics', 'analytic_gaussian_evaluation', 'two-dimensional Gaussian matrices and sources', 'determinant source exponent and integral value', '2026-04-25'),
(4, 'path-integrals-and-the-functional-formulation-of-physics', 'generating_functional_scaffold', 'toy_source_functional', 'two-source Gaussian cases', 'Z[J] and kernel values', '2026-04-25'),
(5, 'path-integrals-and-the-functional-formulation-of-physics', 'lattice_scalar_field_scaffold', 'deterministic_lattice_action', 'scalar field lattice cases', 'kinetic mass interaction and total action', '2026-04-25'),
(6, 'path-integrals-and-the-functional-formulation-of-physics', 'stochastic_path_scaffold', 'drift_diffusion_simulation', 'stochastic path cases', 'path summary statistics', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

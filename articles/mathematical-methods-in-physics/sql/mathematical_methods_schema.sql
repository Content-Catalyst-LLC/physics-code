-- Mathematical Methods in Physics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores physical relations, variables, dimensions, methods, uncertainty
-- cases, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS measurement_uncertainty_cases;
DROP TABLE IF EXISTS dimensional_relations;
DROP TABLE IF EXISTS eigenvalue_cases;
DROP TABLE IF EXISTS numerical_methods_catalog;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE measurement_uncertainty_cases (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    mass_uncertainty_kg REAL NOT NULL,
    velocity_m_per_s REAL NOT NULL,
    velocity_uncertainty_m_per_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE dimensional_relations (
    relation_name TEXT PRIMARY KEY,
    equation TEXT NOT NULL,
    expected_dimension TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE eigenvalue_cases (
    case_id TEXT PRIMARY KEY,
    mass1_kg REAL NOT NULL,
    mass2_kg REAL NOT NULL,
    k1_n_per_m REAL NOT NULL,
    k2_n_per_m REAL NOT NULL,
    k_coupling_n_per_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE numerical_methods_catalog (
    method_name TEXT PRIMARY KEY,
    method_family TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    key_risk TEXT NOT NULL
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

INSERT INTO measurement_uncertainty_cases VALUES
('cart_slow', 1.20, 0.01, 0.50, 0.02, 'slow cart kinetic energy example'),
('cart_medium', 1.20, 0.01, 1.50, 0.03, 'medium speed cart kinetic energy example'),
('cart_fast', 1.20, 0.01, 3.00, 0.05, 'fast cart kinetic energy example'),
('projectile', 0.145, 0.002, 38.0, 0.8, 'baseball-like projectile example'),
('lab_mass', 2.50, 0.02, 0.75, 0.01, 'lab cart example');

INSERT INTO dimensional_relations VALUES
('velocity', 'v = dx/dt', 'L T^-1', 'rate of change of position'),
('acceleration', 'a = dv/dt', 'L T^-2', 'rate of change of velocity'),
('force', 'F = m a', 'M L T^-2', 'Newtonian force dimension'),
('kinetic_energy', 'K = 1/2 m v^2', 'M L^2 T^-2', 'mechanical energy'),
('power', 'P = dE/dt', 'M L^2 T^-3', 'energy per unit time'),
('pressure', 'p = F/A', 'M L^-1 T^-2', 'force per unit area'),
('angular_momentum', 'L = r x p', 'M L^2 T^-1', 'rotation-related action dimension'),
('diffusion_coefficient', 'D = L^2/t', 'L^2 T^-1', 'diffusion scaling');

INSERT INTO eigenvalue_cases VALUES
('symmetric_modes', 1.0, 1.0, 10.0, 10.0, 2.0, 'coupled oscillator example'),
('asymmetric_mass', 1.0, 1.5, 10.0, 10.0, 2.0, 'different masses'),
('strong_coupling', 1.0, 1.0, 10.0, 10.0, 8.0, 'strong coupling example'),
('soft_second_spring', 1.0, 1.0, 10.0, 5.0, 2.0, 'asymmetric stiffness');

INSERT INTO numerical_methods_catalog VALUES
('Euler method', 'ODE integration', 'introductory time stepping', 'large error and instability'),
('Runge-Kutta', 'ODE integration', 'general numerical integration', 'step-size sensitivity'),
('finite difference', 'PDE/numerical derivatives', 'grid-based approximation', 'stability and discretization error'),
('finite element', 'PDE/variational methods', 'complex geometries and weak forms', 'mesh quality and formulation error'),
('finite volume', 'conservation laws', 'flux-conservative simulation', 'numerical diffusion and reconstruction errors'),
('spectral method', 'PDE/Fourier/Chebyshev methods', 'smooth high-accuracy problems', 'boundary and discontinuity challenges'),
('Monte Carlo', 'probability/statistical physics', 'high-dimensional averages', 'sampling error and convergence'),
('FFT', 'spectral analysis', 'frequency-domain decomposition', 'aliasing and windowing errors');

INSERT INTO physical_relations VALUES
(1, 'velocity', 'v = dx/dt', 'v,x,t', 'time derivative of position'),
(2, 'acceleration', 'a = d2x/dt2', 'a,x,t', 'second time derivative of position'),
(3, 'work', 'W = integral F dot dr', 'W,F,r', 'line integral of force along path'),
(4, 'flux', 'Phi = integral F dot dA', 'Phi,F,A', 'field passing through a surface'),
(5, 'conservation law', 'partial rho/partial t + div J = 0', 'rho,t,J', 'local conservation equation'),
(6, 'linear system', 'A x = b', 'A,x,b', 'matrix equation for coupled linear relations'),
(7, 'eigenvalue problem', 'A v = lambda v', 'A,v,lambda', 'natural values and modes of a linear operator'),
(8, 'ODE system', 'dx/dt = F(x,t)', 'x,t,F', 'time evolution of finite-dimensional state'),
(9, 'wave equation', 'partial2 u/partial t2 = c^2 laplacian u', 'u,t,c', 'field propagation equation'),
(10, 'diffusion equation', 'partial u/partial t = D laplacian u', 'u,t,D', 'spreading or smoothing field equation'),
(11, 'Fourier transform', 'fhat(omega) = integral f(t) exp(-i omega t) dt', 'f,omega,t', 'frequency-domain representation'),
(12, 'uncertainty propagation', 'sigma_f^2 = sum_i (partial f/partial x_i)^2 sigma_i^2', 'sigma_f,f,x_i,sigma_i', 'first-order uncertainty propagation'),
(13, 'stationary action', 'delta S = 0', 'S', 'variational principle for physical paths');

INSERT INTO model_metadata VALUES
(1, 'dimensional analysis', 'unit and scaling checks', 'dimensions', 'cannot determine dimensionless constants'),
(2, 'ODE integration', 'time evolution', 'state vector', 'numerical stability and error control needed'),
(3, 'eigenvalue analysis', 'modes and natural values', 'eigenvalues', 'linearized approximation may be limited'),
(4, 'Fourier analysis', 'spectral decomposition', 'frequency spectrum', 'finite sampling and aliasing issues'),
(5, 'uncertainty propagation', 'measurement-aware derived quantities', 'sigma_f', 'linear approximation may fail for large uncertainties'),
(6, 'tensor operations', 'coordinate-independent physical structure', 'components and invariants', 'requires correct transformation rules'),
(7, 'finite difference', 'discrete approximation to derivatives', 'grid spacing', 'stability and convergence constraints');

INSERT INTO source_notes VALUES
(1, 'MIT Mathematical Methods for Engineers II', 'MIT OpenCourseWare', 'numerical methods differential equations and optimization', 'https://ocw.mit.edu/courses/18-086-mathematical-methods-for-engineers-ii-spring-2006/'),
(2, 'MIT Computational Science and Engineering I', 'MIT OpenCourseWare', 'computational mathematics differential equations Fourier transforms numerical methods', 'https://ocw.mit.edu/courses/18-085-computational-science-and-engineering-i-summer-2020/'),
(3, 'MIT Physics III Vibrations and Waves', 'MIT OpenCourseWare', 'normal modes waves Fourier and oscillatory systems', 'https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/'),
(4, 'Arfken Mathematical Methods for Physicists', 'Elsevier', 'standard mathematical physics textbook reference', 'https://shop.elsevier.com/books/mathematical-methods-for-physicists/arfken/978-0-12-384654-9'),
(5, 'Fourier Analytical Theory of Heat', 'Internet Archive', 'classic Fourier analysis source', 'https://archive.org/details/analyticaltheory00fourrich'),
(6, 'NIST SI Guide', 'NIST', 'SI units and technical unit conventions', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(7, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9');

INSERT INTO model_assumptions VALUES
(1, 'ode_eigen_fourier_workflow', 'Uses a simple harmonic oscillator for ODE and Fourier demonstrations.'),
(2, 'ode_eigen_fourier_workflow', 'Uses a small two-degree-of-freedom matrix example for eigenvalue analysis.'),
(3, 'dimensional_analysis_scaffold', 'Tracks dimensions using mass length time exponent triples only.'),
(4, 'tensor_operations_scaffold', 'Uses a symmetric second-order tensor as a stress-like example.'),
(5, 'pde_grid_scaffold', 'Uses explicit finite differences for a one-dimensional diffusion equation.'),
(6, 'uncertainty_propagation', 'Uses first-order uncertainty propagation assuming independent inputs.'),
(7, 'mathematical_methods_schema', 'Stores educational metadata rather than a production scientific database.');

INSERT INTO simulation_runs VALUES
(1, 'mathematical-methods-in-physics', 'ode_eigen_fourier_workflow', 'ode_integration_eigen_fft', 'harmonic oscillator and coupled matrix examples', 'trajectory energy modes and spectrum tables', '2026-04-25'),
(2, 'mathematical-methods-in-physics', 'dimensional_analysis_scaffold', 'dimension_exponent_check', 'mass length time exponent vectors', 'dimensional consistency table', '2026-04-25'),
(3, 'mathematical-methods-in-physics', 'tensor_operations_scaffold', 'linear_algebra_tensor_diagnostics', 'symmetric 3 by 3 tensor example', 'principal values trace deviatoric diagnostics', '2026-04-25'),
(4, 'mathematical-methods-in-physics', 'pde_grid_scaffold', 'explicit_finite_difference', 'one-dimensional diffusion pulse', 'field snapshots over time', '2026-04-25'),
(5, 'mathematical-methods-in-physics', 'uncertainty_propagation', 'first_order_error_propagation', 'kinetic energy measurement cases', 'derived uncertainty table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

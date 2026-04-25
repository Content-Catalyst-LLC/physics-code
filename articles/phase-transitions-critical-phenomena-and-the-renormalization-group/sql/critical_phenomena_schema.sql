-- Phase Transitions, Critical Phenomena, and the Renormalization Group Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, Landau cases, Ising simulation cases, critical exponents,
-- universality classes, RG toy flows, physical relations, model metadata,
-- source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS critical_phenomena_constants;
DROP TABLE IF EXISTS landau_cases;
DROP TABLE IF EXISTS ising_simulation_cases;
DROP TABLE IF EXISTS critical_exponent_cases;
DROP TABLE IF EXISTS universality_class_cases;
DROP TABLE IF EXISTS rg_flow_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE critical_phenomena_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE landau_cases (
    case_id TEXT PRIMARY KEY,
    critical_temperature REAL NOT NULL,
    a_coefficient REAL NOT NULL,
    b_coefficient REAL NOT NULL,
    temperature_min REAL NOT NULL,
    temperature_max REAL NOT NULL,
    n_temperatures INTEGER NOT NULL,
    m_min REAL NOT NULL,
    m_max REAL NOT NULL,
    n_m INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE ising_simulation_cases (
    case_id TEXT PRIMARY KEY,
    lattice_size INTEGER NOT NULL,
    coupling_j REAL NOT NULL,
    temperature_min REAL NOT NULL,
    temperature_max REAL NOT NULL,
    n_temperatures INTEGER NOT NULL,
    n_thermalization_sweeps INTEGER NOT NULL,
    n_measurement_sweeps INTEGER NOT NULL,
    random_seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE critical_exponent_cases (
    universality_class TEXT PRIMARY KEY,
    dimension REAL NOT NULL,
    beta_exponent REAL NOT NULL,
    gamma_exponent REAL NOT NULL,
    nu_exponent REAL NOT NULL,
    eta_exponent REAL NOT NULL,
    notes TEXT
);

CREATE TABLE universality_class_cases (
    case_id TEXT PRIMARY KEY,
    order_parameter_symmetry TEXT NOT NULL,
    dimension REAL NOT NULL,
    interaction_range TEXT NOT NULL,
    example_systems TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE rg_flow_cases (
    case_id TEXT PRIMARY KEY,
    u_initial REAL NOT NULL,
    y_exponent REAL NOT NULL,
    scale_factor REAL NOT NULL,
    n_steps INTEGER NOT NULL,
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

INSERT INTO critical_phenomena_constants VALUES
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('ising_2d_critical_temperature_J_over_kB', 2.269185314, 'dimensionless', 'exact square-lattice 2D Ising critical temperature for J/kB units and h=0'),
('mean_field_beta', 0.5, 'dimensionless', 'Landau mean-field order-parameter exponent'),
('mean_field_gamma', 1.0, 'dimensionless', 'Landau mean-field susceptibility exponent'),
('mean_field_nu', 0.5, 'dimensionless', 'mean-field correlation-length exponent'),
('ising_2d_beta', 0.125, 'dimensionless', 'exact 2D Ising order-parameter exponent'),
('ising_2d_gamma', 1.75, 'dimensionless', 'exact 2D Ising susceptibility exponent'),
('ising_2d_nu', 1.0, 'dimensionless', 'exact 2D Ising correlation-length exponent');

INSERT INTO landau_cases VALUES
('symmetric_landau', 1.0, 1.0, 1.0, 0.6, 1.4, 17, -1.5, 1.5, 301, 'Z2 symmetric second-order Landau free energy'),
('strong_quartic', 1.0, 1.0, 2.0, 0.6, 1.4, 17, -1.5, 1.5, 301, 'stronger quartic stabilization'),
('weak_quartic', 1.0, 1.0, 0.5, 0.6, 1.4, 17, -2.0, 2.0, 401, 'weaker quartic stabilization');

INSERT INTO ising_simulation_cases VALUES
('article_demo', 32, 1.0, 1.8, 3.2, 15, 500, 1000, 42, 'article body demonstration'),
('small_fast', 16, 1.0, 1.8, 3.2, 15, 300, 600, 101, 'fast test case'),
('larger_demo', 48, 1.0, 1.9, 2.8, 10, 800, 1200, 202, 'larger finite-size demonstration');

INSERT INTO critical_exponent_cases VALUES
('mean_field', 4, 0.5, 1.0, 0.5, 0.0, 'mean-field values at or above upper critical dimension for Ising-like models'),
('ising_2d', 2, 0.125, 1.75, 1.0, 0.25, 'exact two-dimensional Ising exponents'),
('ising_3d', 3, 0.326, 1.237, 0.630, 0.036, 'representative numerical estimates for three-dimensional Ising universality'),
('xy_3d', 3, 0.349, 1.318, 0.672, 0.038, 'representative estimates for three-dimensional XY universality'),
('heisenberg_3d', 3, 0.366, 1.386, 0.711, 0.037, 'representative estimates for three-dimensional Heisenberg universality');

INSERT INTO universality_class_cases VALUES
('ising_2d', 'Z2', 2, 'short range', 'uniaxial magnets and lattice gases', 'two-dimensional scalar order parameter with spin-flip symmetry'),
('ising_3d', 'Z2', 3, 'short range', 'liquid-gas critical point and uniaxial magnets', 'three-dimensional scalar universality'),
('xy_3d', 'O2', 3, 'short range', 'superfluid helium and planar magnets', 'two-component order parameter'),
('heisenberg_3d', 'O3', 3, 'short range', 'isotropic ferromagnets', 'three-component order parameter'),
('mean_field', 'varies', 4, 'effectively long range', 'high-dimensional or long-range systems', 'fluctuations suppressed'),
('percolation', 'connectivity', 2, 'geometric', 'porous media and network connectivity', 'geometric criticality rather than thermal magnetism');

INSERT INTO rg_flow_cases VALUES
('relevant_temperature', 0.01, 1.0, 2.0, 12, 'relevant perturbation grows under coarse graining'),
('irrelevant_microscopic', 0.5, -1.0, 2.0, 12, 'irrelevant perturbation shrinks under coarse graining'),
('marginal_tree_level', 0.1, 0.0, 2.0, 12, 'marginal perturbation unchanged at linear order'),
('strongly_relevant_field', 0.005, 1.875, 2.0, 12, 'field-like Ising perturbation illustrative growth');

INSERT INTO physical_relations VALUES
(1, 'partition function', 'Z = sum exp(-beta H)', 'Z,beta,H', 'statistical weight sum over microstates'),
(2, 'free energy', 'F = -k_B T ln Z', 'F,k_B,T,Z', 'thermodynamic potential from partition function'),
(3, 'reduced temperature', 't = (T - Tc)/Tc', 't,T,Tc', 'dimensionless distance from criticality'),
(4, 'Ising Hamiltonian', 'H = -J sum_<i,j> s_i s_j - h sum_i s_i', 'H,J,s_i,h', 'nearest-neighbor Ising model'),
(5, 'magnetization', 'm = (1/N) sum_i s_i', 'm,N,s_i', 'order parameter for Ising model'),
(6, 'correlation length scaling', 'xi ~ |t|^-nu', 'xi,t,nu', 'divergence of correlation length near criticality'),
(7, 'order parameter scaling', 'm ~ (-t)^beta', 'm,t,beta', 'onset of order below critical point'),
(8, 'susceptibility scaling', 'chi ~ |t|^-gamma', 'chi,t,gamma', 'divergence of response near criticality'),
(9, 'Landau free energy', 'f(m) = f0 + a(T - Tc)m^2 + b m^4', 'f,m,T,Tc,a,b', 'mean-field symmetry-breaking model'),
(10, 'finite-size magnetization scaling', 'M(t,L) = L^(-beta/nu) Mcal(t L^(1/nu))', 'M,t,L,beta,nu', 'finite-size scaling form for order parameter'),
(11, 'RG eigenvalue scaling', 'u_i_prime = b^y_i u_i', 'u_i,b,y_i', 'linearized renormalization-group perturbation scaling'),
(12, 'RG beta function', 'mu dg/dmu = beta(g)', 'mu,g,beta', 'scale dependence of coupling');

INSERT INTO model_metadata VALUES
(1, 'landau_free_energy', 'mean-field symmetry breaking', 'm', 'neglects fluctuations'),
(2, 'ising_2d_monte_carlo', 'lattice critical behavior', 'm and energy', 'finite size and autocorrelation effects'),
(3, 'binder_cumulant', 'critical temperature estimation', 'U4', 'requires multiple system sizes'),
(4, 'finite_size_scaling', 'critical exponent estimation', 'beta_over_nu and gamma_over_nu', 'requires high-quality data collapse'),
(5, 'correlation_function', 'correlation-length diagnostics', 'G(r)', 'noisy in small simulations'),
(6, 'rg_toy_flow', 'scale-transformation intuition', 'u_i', 'not full field-theoretic RG'),
(7, 'sql_metadata', 'reproducibility', 'models and sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Statistical Mechanics II', 'MIT OpenCourseWare', 'statistical physics of fields course covering phase transitions critical behavior and RG', 'https://ocw.mit.edu/courses/8-334-statistical-mechanics-ii-statistical-physics-of-fields-spring-2014/'),
(2, 'MIT Statistical Mechanics II Lecture Notes', 'MIT OpenCourseWare', 'lecture notes on collective behavior Landau-Ginzburg Ising and RG', 'https://ocw.mit.edu/courses/8-334-statistical-mechanics-ii-statistical-physics-of-fields-spring-2014/pages/lecture-notes/'),
(3, 'MIT Position Space Renormalization Group', 'MIT OpenCourseWare', 'lecture on position-space RG and lattice models', 'https://ocw.mit.edu/courses/8-334-statistical-mechanics-ii-statistical-physics-of-fields-spring-2014/resources/lecture-13-position-space-renormalization-group-part-1/'),
(4, 'Wilson Nobel Lecture', 'Nobel Prize', 'renormalization group and critical phenomena Nobel lecture', 'https://www.nobelprize.org/prizes/physics/1982/wilson/lecture/'),
(5, 'Nobel Prize Physics 1982', 'Nobel Prize', 'official Nobel prize summary for Kenneth Wilson', 'https://www.nobelprize.org/prizes/physics/1982/summary/'),
(6, 'Stanford Intertheory Relations in Physics', 'Stanford Encyclopedia of Philosophy', 'discussion of phase transitions and thermodynamic limit', 'https://plato.stanford.edu/entries/physics-interrelate/'),
(7, 'Tong Statistical Field Theory', 'University of Cambridge', 'graduate lecture notes on statistical field theory', 'https://www.damtp.cam.ac.uk/user/tong/sft.html'),
(8, 'Cardy Scaling and Renormalization', 'Cambridge University Press', 'graduate text on scaling and RG', 'https://www.cambridge.org/highereducation/books/scaling-and-renormalization-in-statistical-physics/2F22E9F803219980423152BD9C463CC4');

INSERT INTO model_assumptions VALUES
(1, 'landau_free_energy', 'Uses a Z2-symmetric quartic Landau free energy and neglects fluctuations.'),
(2, 'ising_2d_monte_carlo', 'Uses Metropolis single-spin updates, periodic boundaries, finite lattice sizes, and finite sampling.'),
(3, 'binder_cumulant', 'Uses synthetic moment scaffolding unless replaced with simulation moments.'),
(4, 'finite_size_scaling', 'Uses critical scaling laws and representative exponents without performing full data collapse.'),
(5, 'correlation_function', 'Uses idealized correlation form rather than measured spin correlations from simulation.'),
(6, 'rg_toy_flow', 'Uses linearized RG scaling and does not implement full coarse-graining transformations.'),
(7, 'critical_phenomena_schema', 'Stores educational metadata rather than a production critical-phenomena database.');

INSERT INTO simulation_runs VALUES
(1, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'landau_free_energy', 'grid_evaluation', 'Landau cases across temperature and order parameter', 'free-energy landscapes and equilibrium order parameter table', '2026-04-25'),
(2, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'ising_2d_monte_carlo', 'metropolis_monte_carlo', '2D square-lattice Ising cases', 'energy magnetization heat capacity susceptibility table', '2026-04-25'),
(3, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'binder_cumulant', 'moment_scaffold', 'sample moments by lattice size and temperature', 'Binder cumulant scaffold table', '2026-04-25'),
(4, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'finite_size_scaling', 'scaling_table', 'critical exponent cases and lattice sizes', 'finite-size scaling table', '2026-04-25'),
(5, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'correlation_function', 'idealized_correlation_grid', 'selected xi values and distances', 'correlation-function table', '2026-04-25'),
(6, 'phase-transitions-critical-phenomena-and-the-renormalization-group', 'rg_toy_flow', 'linear_rg_iteration', 'sample RG eigenvalue cases', 'RG flow table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

-- Lagrangian and Hamiltonian Mechanics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores generalized coordinates, model parameters, Hamiltonian systems,
-- symmetry-conservation mappings, physical relations, source notes,
-- assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS pendulum_parameters;
DROP TABLE IF EXISTS phase_space_initial_conditions;
DROP TABLE IF EXISTS normal_mode_cases;
DROP TABLE IF EXISTS symmetry_conservation_map;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE pendulum_parameters (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    length_m REAL NOT NULL,
    gravity_m_per_s2 REAL NOT NULL,
    theta0_rad REAL NOT NULL,
    p0_kg_m2_per_s REAL NOT NULL,
    time_step_s REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE phase_space_initial_conditions (
    case_id TEXT PRIMARY KEY,
    theta_rad REAL NOT NULL,
    p_theta_kg_m2_per_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE normal_mode_cases (
    case_id TEXT PRIMARY KEY,
    mass1_kg REAL NOT NULL,
    mass2_kg REAL NOT NULL,
    k1_n_per_m REAL NOT NULL,
    k2_n_per_m REAL NOT NULL,
    k_coupling_n_per_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE symmetry_conservation_map (
    symmetry TEXT PRIMARY KEY,
    invariance TEXT NOT NULL,
    conserved_quantity TEXT NOT NULL,
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

INSERT INTO pendulum_parameters VALUES
('small_angle', 1.0, 1.0, 9.80665, 0.2, 0.0, 0.01, 5000, 'small oscillation example'),
('moderate_angle', 1.0, 1.0, 9.80665, 1.0, 0.0, 0.01, 5000, 'article base case'),
('near_separatrix', 1.0, 1.0, 9.80665, 3.0, 0.0, 0.005, 8000, 'near separatrix style initial angle'),
('rotational', 1.0, 1.0, 9.80665, 0.0, 8.0, 0.005, 8000, 'rotational high momentum case'),
('long_pendulum', 1.0, 2.0, 9.80665, 1.0, 0.0, 0.01, 5000, 'length comparison');

INSERT INTO phase_space_initial_conditions VALUES
('low_energy_oscillation', 0.2, 0.0, 'small oscillation'),
('moderate_oscillation', 1.0, 0.0, 'moderate oscillation'),
('near_top', 3.0, 0.0, 'near unstable equilibrium'),
('high_momentum_rotation', 0.0, 8.0, 'rotational trajectory'),
('negative_momentum', -1.0, -2.0, 'opposite direction comparison');

INSERT INTO normal_mode_cases VALUES
('symmetric_coupled_oscillators', 1.0, 1.0, 10.0, 10.0, 2.0, 'two identical masses with coupling'),
('asymmetric_masses', 1.0, 2.0, 10.0, 10.0, 2.0, 'different masses'),
('strong_coupling', 1.0, 1.0, 10.0, 10.0, 8.0, 'strong coupling comparison'),
('soft_second_spring', 1.0, 1.0, 10.0, 5.0, 2.0, 'asymmetric stiffness');

INSERT INTO symmetry_conservation_map VALUES
('time_translation', 'laws unchanged under shift of time origin', 'energy', 'Hamiltonian often conserved when no explicit time dependence'),
('space_translation', 'laws unchanged under shift of spatial origin', 'linear_momentum', 'associated with cyclic position coordinate'),
('rotation', 'laws unchanged under spatial rotation', 'angular_momentum', 'associated with cyclic angular coordinate'),
('phase_space_canonical_transform', 'Hamiltonian form preserved', 'symplectic_structure', 'canonical transformations preserve Hamilton equations');

INSERT INTO physical_relations VALUES
(1, 'Lagrangian', 'L = T - V', 'L,T,V', 'kinetic minus potential energy for many conservative systems'),
(2, 'action', 'S = integral L dt', 'S,L,t', 'time integral of Lagrangian'),
(3, 'stationary action', 'delta S = 0', 'S', 'physical path makes action stationary'),
(4, 'Euler-Lagrange equation', 'd/dt(partial L/partial qdot_i) - partial L/partial q_i = 0', 'L,q_i,qdot_i,t', 'equations of motion from stationary action'),
(5, 'canonical momentum', 'p_i = partial L/partial qdot_i', 'p_i,L,qdot_i', 'momentum conjugate to generalized coordinate'),
(6, 'Hamiltonian', 'H = sum_i p_i qdot_i - L', 'H,p_i,qdot_i,L', 'Legendre transform from Lagrangian form'),
(7, 'Hamilton equation coordinate', 'qdot_i = partial H/partial p_i', 'qdot_i,H,p_i', 'coordinate evolution in phase space'),
(8, 'Hamilton equation momentum', 'pdot_i = -partial H/partial q_i', 'pdot_i,H,q_i', 'momentum evolution in phase space'),
(9, 'Poisson bracket', '{A,B}=sum_i(dA/dq_i dB/dp_i - dA/dp_i dB/dq_i)', 'A,B,q_i,p_i', 'canonical bracket for phase-space functions'),
(10, 'time evolution', 'dA/dt = {A,H} + partial A/partial t', 'A,H,t', 'Hamiltonian time evolution of observable'),
(11, 'pendulum Hamiltonian', 'H = p^2/(2 m l^2) + m g l(1 - cos theta)', 'H,p,m,l,g,theta', 'simple pendulum Hamiltonian'),
(12, 'normal modes', '(K - omega^2 M)a = 0', 'K,omega,M,a', 'generalized eigenproblem for small oscillations');

INSERT INTO model_metadata VALUES
(1, 'Lagrangian mechanics', 'derive motion from action', 'L', 'requires appropriate coordinates and variational assumptions'),
(2, 'Hamiltonian mechanics', 'phase-space evolution', 'H', 'Legendre transform may be singular for constrained systems'),
(3, 'symplectic Euler', 'structure-preserving integration', 'energy behavior', 'first-order method'),
(4, 'Poisson bracket', 'algebraic dynamics', '{A,H}', 'requires canonical coordinates'),
(5, 'normal modes', 'linearized coupled oscillations', 'omega', 'small oscillation approximation'),
(6, 'cyclic coordinate', 'identify conserved momentum', 'p_i', 'requires coordinate absent from L'),
(7, 'Noether theorem', 'connect symmetry and conservation', 'conserved current or charge', 'requires continuous symmetry of action');

INSERT INTO source_notes VALUES
(1, 'MIT Classical Mechanics II', 'MIT OpenCourseWare', 'broad theoretical treatment of classical mechanics', 'https://ocw.mit.edu/courses/8-223-classical-mechanics-ii-january-iap-2017/'),
(2, 'MIT Classical Mechanics II Lecture Notes', 'MIT OpenCourseWare', 'Lagrangian workflow Hamiltonian Poisson brackets canonical transformations', 'https://ocw.mit.edu/courses/8-223-classical-mechanics-ii-january-iap-2017/pages/lecture-notes/'),
(3, 'MIT Introduction to Hamiltonian Mechanics', 'MIT OpenCourseWare', 'Hamiltonian dynamics lecture note', 'https://ocw.mit.edu/courses/8-223-classical-mechanics-ii-january-iap-2017/resources/mit8_223iap17_lec15/'),
(4, 'MIT Introduction to Lagrange', 'MIT OpenCourseWare', 'generalized coordinates and Lagrange examples', 'https://ocw.mit.edu/courses/2-003sc-engineering-dynamics-fall-2011/resources/lecture-15-introduction-to-lagrange-with-examples/'),
(5, 'Noether Invariant Variation Problems', 'arXiv', 'English translation of Noether variational symmetry paper', 'https://arxiv.org/abs/physics/0503066'),
(6, 'Hamilton General Method in Dynamics', 'Royal Society', 'primary Hamilton dynamics source', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1834.0017'),
(7, 'Hamilton Second Essay', 'Royal Society', 'primary Hamilton dynamics source', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1835.0009'),
(8, 'Lagrange Mecanique Analytique', 'Internet Archive', 'primary source for analytical mechanics', 'https://archive.org/details/mcaniqueanalyt01lagr'),
(9, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(10, 'NIST SI Guide', 'NIST', 'SI units and derived units', 'https://physics.nist.gov/cuu/pdf/sp811.pdf');

INSERT INTO model_assumptions VALUES
(1, 'hamiltonian_pendulum_symplectic', 'Uses a conservative simple pendulum with no damping or driving.'),
(2, 'hamiltonian_pendulum_symplectic', 'Uses symplectic Euler as a transparent first-order symplectic method.'),
(3, 'energy_drift_comparison', 'Compares explicit Euler and symplectic Euler for qualitative energy behavior.'),
(4, 'poisson_bracket_scaffold', 'Uses one canonical coordinate-momentum pair and symbolic differentiation.'),
(5, 'normal_modes_scaffold', 'Uses linearized two-oscillator mass and stiffness matrices.'),
(6, 'analytical_mechanics_schema', 'Stores educational metadata rather than a production symbolic mechanics database.');

INSERT INTO simulation_runs VALUES
(1, 'lagrangian-and-hamiltonian-mechanics', 'hamiltonian_pendulum_symplectic', 'symplectic_euler', 'theta0=1 rad p0=0 m=1 kg l=1 m dt=0.01', 'trajectory and energy diagnostics', '2026-04-25'),
(2, 'lagrangian-and-hamiltonian-mechanics', 'energy_drift_comparison', 'explicit_euler_vs_symplectic_euler', 'same pendulum initial condition and time step', 'method comparison energy drift summary', '2026-04-25'),
(3, 'lagrangian-and-hamiltonian-mechanics', 'poisson_bracket_scaffold', 'symbolic_poisson_brackets', 'harmonic oscillator Hamiltonian', 'Poisson brackets with H', '2026-04-25'),
(4, 'lagrangian-and-hamiltonian-mechanics', 'normal_modes_scaffold', 'generalized_eigenproblem', 'two coupled oscillator cases', 'normal mode frequencies and mode shapes', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

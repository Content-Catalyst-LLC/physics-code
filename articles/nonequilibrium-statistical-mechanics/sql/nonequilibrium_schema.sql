-- Nonequilibrium Statistical Mechanics Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS markov_cycle_cases;
DROP TABLE IF EXISTS langevin_cases;
DROP TABLE IF EXISTS fokker_planck_cases;
DROP TABLE IF EXISTS green_kubo_cases;
DROP TABLE IF EXISTS fluctuation_theorem_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE markov_cycle_cases (
    case_id TEXT PRIMARY KEY,
    k_plus REAL NOT NULL,
    k_minus REAL NOT NULL,
    notes TEXT
);

CREATE TABLE langevin_cases (
    case_id TEXT PRIMARY KEY,
    n_steps INTEGER NOT NULL,
    time_step REAL NOT NULL,
    spring_constant REAL NOT NULL,
    mobility REAL NOT NULL,
    thermal_energy REAL NOT NULL,
    initial_position REAL NOT NULL,
    notes TEXT
);

CREATE TABLE fokker_planck_cases (
    case_id TEXT PRIMARY KEY,
    diffusion REAL NOT NULL,
    mobility REAL NOT NULL,
    spring_constant REAL NOT NULL,
    domain_min REAL NOT NULL,
    domain_max REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    time_step REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE green_kubo_cases (
    case_id TEXT PRIMARY KEY,
    correlation_time REAL NOT NULL,
    thermal_velocity_variance REAL NOT NULL,
    n_points INTEGER NOT NULL,
    time_max REAL NOT NULL,
    notes TEXT
);

CREATE TABLE fluctuation_theorem_cases (
    case_id TEXT PRIMARY KEY,
    entropy_mean REAL NOT NULL,
    entropy_sd REAL NOT NULL,
    n_samples INTEGER NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
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

INSERT INTO constants VALUES
('k_B', 1.380649e-23, 'J K^-1', 'Boltzmann constant exact SI'),
('h', 6.62607015e-34, 'J s', 'Planck constant exact SI'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('room_temperature', 298.15, 'K', 'reference room temperature'),
('thermal_energy_room', 4.116404e-21, 'J', 'k_B times 298.15 K');

INSERT INTO markov_cycle_cases VALUES
('equilibrium_cycle', 1.0, 1.0, 'detailed balance with no net cycle current'),
('weak_drive', 1.5, 1.0, 'weak clockwise nonequilibrium drive'),
('moderate_drive', 3.0, 1.0, 'moderate clockwise nonequilibrium drive'),
('strong_drive', 10.0, 1.0, 'strong clockwise nonequilibrium drive'),
('reverse_drive', 1.0, 3.0, 'counterclockwise nonequilibrium drive');

INSERT INTO physical_relations VALUES
(1, 'Liouville equation', 'partial rho/partial t + {rho,H} = 0', 'rho,H', 'fine-grained phase-space probability conservation'),
(2, 'Boltzmann equation', 'partial f/partial t + v dot grad_x f + F/m dot grad_v f = C[f]', 'f,v,F,m,C', 'kinetic equation with streaming and collisions'),
(3, 'master equation', 'dp_i/dt = sum_j (W_ij p_j - W_ji p_i)', 'p,W', 'continuous-time Markov probability evolution'),
(4, 'detailed balance', 'W_ij p_j^eq = W_ji p_i^eq', 'W,p', 'pairwise balance condition for equilibrium Markov dynamics'),
(5, 'overdamped Langevin equation', 'dx = mu F dt + sqrt(2D) dW_t', 'x,mu,F,D,W', 'stochastic trajectory equation'),
(6, 'Fokker-Planck equation', 'partial_t P = -partial_x[mu F P] + D partial_x^2 P', 'P,mu,F,D', 'probability-density evolution for diffusion with drift'),
(7, 'Einstein relation', 'D = mu k_B T', 'D,mu,k_B,T', 'fluctuation-dissipation relation for Brownian motion'),
(8, 'linear response', 'J_i = sum_j L_ij X_j', 'J,L,X', 'near-equilibrium flux-force relation'),
(9, 'Onsager reciprocity', 'L_ij = L_ji', 'L', 'symmetry of reciprocal irreversible transport coefficients'),
(10, 'Green-Kubo relation', 'L = integral_0^infinity <J(t)J(0)> dt', 'L,J,t', 'transport coefficient from equilibrium current correlations'),
(11, 'Markov entropy production', 'Sdot = 1/2 sum_ij (W_ij p_j - W_ji p_i) log((W_ij p_j)/(W_ji p_i))', 'Sdot,W,p', 'entropy production from irreversible probability currents'),
(12, 'Jarzynski equality', '<exp(-beta W)> = exp(-beta Delta F)', 'W,beta,Delta F', 'nonequilibrium work relation');

INSERT INTO source_notes VALUES
(1, 'MIT Non-Equilibrium Statistical Mechanics', 'MIT OpenCourseWare', 'graduate course covering stochastic processes response theory molecular hydrodynamics complex liquids and fluctuation theorems', 'https://ocw.mit.edu/courses/5-72-non-equilibrium-statistical-mechanics-spring-2012/'),
(2, 'MIT Non-Equilibrium Statistical Mechanics Lecture Notes', 'MIT OpenCourseWare', 'lecture notes on stochastic processes Brownian motion master equations detailed balance and related topics', 'https://ocw.mit.edu/courses/5-72-non-equilibrium-statistical-mechanics-spring-2012/pages/lecture-notes/'),
(3, 'MIT Statistical Mechanics II Dissipative Dynamics', 'MIT OpenCourseWare', 'Fokker-Planck probability current and fluctuation-dissipation condition', 'https://ocw.mit.edu/courses/8-334-statistical-mechanics-ii-statistical-physics-of-fields-spring-2014/914d55f20250bfd83c85daee5f563433_MIT8_334S14_Lec24.pdf'),
(4, 'Nobel Chemistry 1968', 'Nobel Prize', 'Lars Onsager reciprocal relations in irreversible thermodynamics', 'https://www.nobelprize.org/prizes/chemistry/1968/summary/'),
(5, 'Nobel Chemistry 1977', 'Nobel Prize', 'Ilya Prigogine nonequilibrium thermodynamics and dissipative structures', 'https://www.nobelprize.org/prizes/chemistry/1977/summary/'),
(6, 'Jarzynski Equality', 'arXiv', 'nonequilibrium equality for free energy differences', 'https://arxiv.org/abs/cond-mat/9610209'),
(7, 'Harada Sasa Equality', 'Physical Review Letters', 'energy dissipation and fluctuation-response violation', 'https://link.aps.org/doi/10.1103/PhysRevLett.95.130602');

INSERT INTO model_assumptions VALUES
(1, 'markov_entropy_production', 'Uses a symmetric three-state cycle with uniform steady probabilities.'),
(2, 'overdamped_langevin', 'Uses Euler-Maruyama integration and a harmonic potential.'),
(3, 'fokker_planck_relaxation', 'Uses an explicit finite-difference scaffold with positivity cleanup.'),
(4, 'green_kubo_diffusion', 'Uses exponential velocity autocorrelation with analytic benchmark.'),
(5, 'fluctuation_theorem_check', 'Uses synthetic entropy-production samples for teaching diagnostics.');

INSERT INTO simulation_runs VALUES
(1, 'nonequilibrium-statistical-mechanics', 'markov_entropy_production', 'closed_form_cycle', 'k_plus and k_minus cases', 'cycle current affinity and entropy production', '2026-04-25'),
(2, 'nonequilibrium-statistical-mechanics', 'overdamped_langevin', 'Euler-Maruyama', 'harmonic potential cases', 'trajectory samples and equilibrium variance summary', '2026-04-25'),
(3, 'nonequilibrium-statistical-mechanics', 'fokker_planck_relaxation', 'explicit_finite_difference', 'Fokker-Planck cases', 'relaxation snapshots and probability normalization', '2026-04-25'),
(4, 'nonequilibrium-statistical-mechanics', 'green_kubo_diffusion', 'trapezoid_integration', 'exponential autocorrelation cases', 'numeric and analytic diffusion estimates', '2026-04-25'),
(5, 'nonequilibrium-statistical-mechanics', 'fluctuation_theorem_check', 'synthetic_sampling', 'entropy sample cases', 'empirical fluctuation ratio table', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

-- Computational Physics and Scientific Simulation Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores simulation parameters, numerical methods, variables, units,
-- VVUQ checklist items, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS simulation_parameters;
DROP TABLE IF EXISTS projectile_uncertainty_cases;
DROP TABLE IF EXISTS diffusion_grid_cases;
DROP TABLE IF EXISTS numerical_methods_catalog;
DROP TABLE IF EXISTS vvuq_checklist;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE simulation_parameters (
    case_id TEXT PRIMARY KEY,
    model_name TEXT NOT NULL,
    length_m REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    diffusivity_m2_per_s REAL NOT NULL,
    time_step_s REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE projectile_uncertainty_cases (
    case_id TEXT PRIMARY KEY,
    mean_speed_m_per_s REAL NOT NULL,
    sd_speed_m_per_s REAL NOT NULL,
    mean_angle_deg REAL NOT NULL,
    sd_angle_deg REAL NOT NULL,
    n_samples INTEGER NOT NULL,
    gravity_m_per_s2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE diffusion_grid_cases (
    case_id TEXT PRIMARY KEY,
    length_m REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    diffusivity_m2_per_s REAL NOT NULL,
    time_step_s REAL NOT NULL,
    expected_stability_limit REAL NOT NULL,
    notes TEXT
);

CREATE TABLE numerical_methods_catalog (
    method_name TEXT PRIMARY KEY,
    method_family TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    key_risk TEXT NOT NULL
);

CREATE TABLE vvuq_checklist (
    item TEXT PRIMARY KEY,
    category TEXT NOT NULL,
    question TEXT NOT NULL
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

INSERT INTO simulation_parameters VALUES
('stable_diffusion_base', 'diffusion_1d', 1.0, 201, 0.001, 0.0002, 1200, 'base stable explicit diffusion case'),
('coarse_grid_diffusion', 'diffusion_1d', 1.0, 101, 0.001, 0.0002, 1200, 'coarser grid comparison'),
('fine_grid_diffusion', 'diffusion_1d', 1.0, 401, 0.001, 0.00005, 2400, 'finer grid comparison with smaller time step'),
('fast_diffusion', 'diffusion_1d', 1.0, 201, 0.002, 0.0001, 1200, 'higher diffusivity stable case');

INSERT INTO projectile_uncertainty_cases VALUES
('baseline_projectile', 30.0, 1.5, 45.0, 2.0, 10000, 9.80665, 'article Monte Carlo baseline'),
('higher_speed_projectile', 45.0, 2.5, 42.0, 3.0, 10000, 9.80665, 'higher speed example'),
('low_angle_projectile', 30.0, 1.5, 30.0, 2.0, 10000, 9.80665, 'lower launch angle comparison'),
('high_uncertainty_projectile', 30.0, 4.0, 45.0, 6.0, 10000, 9.80665, 'large uncertainty comparison');

INSERT INTO diffusion_grid_cases VALUES
('stable_101', 1.0, 101, 0.001, 0.0002, 0.5, 'stable coarse grid'),
('stable_201', 1.0, 201, 0.001, 0.0002, 0.5, 'stable article grid'),
('unstable_example', 1.0, 201, 0.001, 0.02, 0.5, 'intentionally unstable if run directly'),
('fine_401', 1.0, 401, 0.001, 0.00005, 0.5, 'fine stable grid');

INSERT INTO numerical_methods_catalog VALUES
('explicit_euler', 'ODE integration', 'introductory first-order time stepping', 'large time-step error and instability'),
('runge_kutta_4', 'ODE integration', 'general accurate fixed-step integration', 'not structure-preserving by default'),
('adaptive_runge_kutta', 'ODE integration', 'error-controlled time integration', 'tolerance choices affect cost and results'),
('symplectic_euler', 'Hamiltonian integration', 'structure-aware long-time dynamics', 'first-order accuracy'),
('finite_difference', 'PDE approximation', 'grid-based derivative approximations', 'stability and grid-resolution dependence'),
('finite_volume', 'conservation law simulation', 'flux-conservative transport', 'numerical diffusion and reconstruction errors'),
('finite_element', 'PDE and variational problems', 'complex geometry and weak forms', 'mesh and formulation errors'),
('monte_carlo', 'stochastic simulation', 'uncertainty and high-dimensional integration', 'sampling error'),
('molecular_dynamics', 'particle simulation', 'microscopic dynamics', 'time-step and force-field limitations');

INSERT INTO vvuq_checklist VALUES
('code_tests', 'verification', 'Does the code pass tests on known problems?'),
('unit_checks', 'verification', 'Are units documented and checked?'),
('grid_refinement', 'solution_verification', 'Does the solution converge under grid refinement?'),
('time_step_refinement', 'solution_verification', 'Does the result converge under smaller time steps?'),
('analytic_comparison', 'verification', 'Is there an analytic solution or limiting case for comparison?'),
('experimental_comparison', 'validation', 'Has the simulation been compared with relevant measurements?'),
('intended_use', 'validation', 'Is the validation domain aligned with the intended use?'),
('input_uncertainty', 'UQ', 'Are uncertain inputs represented with distributions or intervals?'),
('model_form_uncertainty', 'UQ', 'Are model limitations and missing physics documented?'),
('provenance', 'reproducibility', 'Can the simulation run be traced to code data and parameters?');

INSERT INTO physical_relations VALUES
(1, 'ODE system', 'dx/dt = F(x,t)', 'x,t,F', 'time evolution of finite-dimensional state'),
(2, 'time update', 'x_{n+1} = Phi_dt(x_n)', 'x_n,Phi,dt', 'numerical update over one time step'),
(3, 'diffusion equation', 'partial u/partial t = D partial2 u/partial x2', 'u,t,D,x', 'spreading of a scalar field'),
(4, 'finite difference second derivative', 'd2u/dx2 approx (u_{i+1}-2u_i+u_{i-1})/dx^2', 'u_i,dx', 'grid approximation of curvature'),
(5, 'explicit diffusion update', 'u_i^{n+1}=u_i^n+s(u_{i+1}^n-2u_i^n+u_{i-1}^n)', 'u_i,s,n', 'explicit finite-difference diffusion step'),
(6, 'diffusion stability number', 's = D dt / dx^2', 's,D,dt,dx', 'dimensionless explicit diffusion stability number'),
(7, 'Monte Carlo expectation', 'E[f(X)] approx (1/N) sum_i f(X_i)', 'E,f,X,N', 'sample-based expectation estimate'),
(8, 'convergence scaling', '||u-u_h|| approx C h^p', 'u,u_h,C,h,p', 'asymptotic numerical error scaling'),
(9, 'projectile range', 'R = v^2 sin(2 theta)/g', 'R,v,theta,g', 'ideal projectile range without drag');

INSERT INTO model_metadata VALUES
(1, 'finite_difference_diffusion', 'teaching PDE simulation', 'stability_number', 'limited to simple grids and explicit stepping'),
(2, 'ode_solver_diagnostics', 'time integration and energy monitoring', 'total_energy', 'method choice affects long-time behavior'),
(3, 'monte_carlo_uncertainty', 'output uncertainty propagation', 'distribution of quantity of interest', 'requires input distributions'),
(4, 'convergence_diagnostics', 'grid refinement and error scaling', 'observed_order', 'requires reference or analytic solution'),
(5, 'verification_validation_uq', 'simulation credibility', 'evidence structure', 'can be resource intensive'),
(6, 'scientific_visualization', 'interpretation of simulation outputs', 'field or trajectory', 'can mislead without diagnostics'),
(7, 'simulation_metadata', 'reproducible computation', 'run provenance', 'requires disciplined data management');

INSERT INTO source_notes VALUES
(1, 'MIT Introduction to Numerical Methods', 'MIT OpenCourseWare', 'numerical analysis accuracy efficiency stability conditioning', 'https://ocw.mit.edu/courses/18-335j-introduction-to-numerical-methods-spring-2019/'),
(2, 'MIT Computational Science and Engineering I', 'MIT OpenCourseWare', 'computational science numerical methods differential equations', 'https://ocw.mit.edu/courses/18-085-computational-science-and-engineering-i-summer-2020/'),
(3, 'MIT Essential Numerical Methods', 'MIT OpenCourseWare', 'computational methods for physical problems ODEs PDEs conservation', 'https://ocw.mit.edu/courses/22-15-essential-numerical-methods-fall-2014/'),
(4, 'MIT Computational Methods of Scientific Programming', 'MIT OpenCourseWare', 'scientific programming research code testing and projects', 'https://ocw.mit.edu/courses/12-010-computational-methods-of-scientific-programming-fall-2024/'),
(5, 'ASME VVUQ', 'ASME', 'verification validation and uncertainty quantification definitions', 'https://www.asme.org/codes-standards/publications-information/verification-validation-uncertainty'),
(6, 'NIST VVUQ CFD', 'NIST', 'verification validation and uncertainty quantification procedures', 'https://www.nist.gov/publications/summary-industrial-verification-validation-and-uncertainty-quantification-procedures'),
(7, 'NIST SI Guide', 'NIST', 'SI units and derived units', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(8, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9');

INSERT INTO model_assumptions VALUES
(1, 'diffusion_stability_simulation', 'Uses one-dimensional explicit finite differences with Dirichlet boundaries.'),
(2, 'diffusion_stability_simulation', 'Requires D dt / dx^2 <= 0.5 for the standard explicit method.'),
(3, 'ode_solver_diagnostics', 'Uses a harmonic oscillator with known energy for solver diagnostics.'),
(4, 'monte_carlo_uncertainty', 'Uses ideal projectile motion with no air resistance.'),
(5, 'convergence_diagnostics', 'Uses the finest grid as an approximate reference solution.'),
(6, 'computational_physics_schema', 'Stores educational metadata rather than a production simulation database.');

INSERT INTO simulation_runs VALUES
(1, 'computational-physics-and-scientific-simulation', 'diffusion_stability_simulation', 'explicit_finite_difference', 'length=1 n_grid=201 D=0.001 dt=0.0002 n_steps=1200', 'snapshots and diagnostic tables', '2026-04-25'),
(2, 'computational-physics-and-scientific-simulation', 'ode_solver_diagnostics', 'adaptive_RK_solve_ivp', 'harmonic oscillator m=1 k=25', 'trajectory and energy diagnostics', '2026-04-25'),
(3, 'computational-physics-and-scientific-simulation', 'convergence_diagnostics', 'grid_refinement', 'diffusion grids 51 101 201 401', 'error table against finest grid', '2026-04-25'),
(4, 'computational-physics-and-scientific-simulation', 'monte_carlo_uncertainty', 'Monte_Carlo_sampling', 'projectile range with uncertain speed and angle', 'sample table and uncertainty summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

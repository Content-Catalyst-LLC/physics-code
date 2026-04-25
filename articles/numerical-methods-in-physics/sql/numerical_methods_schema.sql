-- Numerical Methods in Physics Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS derivative_convergence_cases;
DROP TABLE IF EXISTS heat_equation_cases;
DROP TABLE IF EXISTS ode_cases;
DROP TABLE IF EXISTS poisson_cases;
DROP TABLE IF EXISTS monte_carlo_cases;
DROP TABLE IF EXISTS eigenvalue_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS verification_runs;

CREATE TABLE derivative_convergence_cases (
    case_id TEXT PRIMARY KEY,
    target_x REAL NOT NULL,
    dx_power_min INTEGER NOT NULL,
    dx_power_max INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE heat_equation_cases (
    case_id TEXT PRIMARY KEY,
    diffusion_coefficient REAL NOT NULL,
    length REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    time_step REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE ode_cases (
    case_id TEXT PRIMARY KEY,
    lambda_value REAL NOT NULL,
    y0 REAL NOT NULL,
    t_final REAL NOT NULL,
    time_step REAL NOT NULL,
    notes TEXT
);

CREATE TABLE poisson_cases (
    case_id TEXT PRIMARY KEY,
    length REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    source_amplitude REAL NOT NULL,
    notes TEXT
);

CREATE TABLE monte_carlo_cases (
    case_id TEXT PRIMARY KEY,
    n_samples INTEGER NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE eigenvalue_cases (
    case_id TEXT PRIMARY KEY,
    length REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    n_eigenvalues INTEGER NOT NULL,
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

CREATE TABLE verification_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    numerical_method TEXT,
    parameter_summary TEXT,
    output_summary TEXT,
    created_at TEXT NOT NULL
);

INSERT INTO derivative_convergence_cases VALUES
('sin_derivative_standard', 1.0, -2, -20, 'central difference derivative of sin(x)'),
('sin_derivative_near_zero', 0.1, -2, -20, 'central difference derivative near zero'),
('cos_derivative_standard', 1.0, -2, -20, 'central difference derivative of cos(x)');

INSERT INTO heat_equation_cases VALUES
('stable_case', 1.0, 1.0, 101, 0.00004, 2500, 'stable explicit FTCS heat-equation case'),
('borderline_case', 1.0, 1.0, 101, 0.00005, 2500, 'borderline stability case'),
('unstable_case', 1.0, 1.0, 101, 0.00008, 400, 'unstable explicit FTCS heat-equation case'),
('coarse_grid_stable', 1.0, 1.0, 51, 0.00010, 1000, 'stable coarse grid case'),
('low_diffusion', 0.25, 1.0, 101, 0.00008, 2500, 'lower diffusion coefficient case');

INSERT INTO physical_relations VALUES
(1, 'central difference derivative', 'u_prime(x_i) ≈ (u_{i+1} - u_{i-1})/(2 dx)', 'u,dx', 'second-order centered derivative approximation'),
(2, 'second derivative', 'u_double_prime(x_i) ≈ (u_{i+1} - 2u_i + u_{i-1})/dx^2', 'u,dx', 'second-order centered Laplacian stencil in one dimension'),
(3, 'error order', 'E ≈ C dx^p', 'E,C,dx,p', 'power-law convergence model'),
(4, 'condition number', 'kappa(A) = ||A|| ||A^{-1}||', 'A,kappa', 'sensitivity of linear solve to perturbations'),
(5, 'ODE initial value problem', 'dy/dt = f(t,y)', 'y,t,f', 'ordinary differential equation evolution'),
(6, 'forward Euler', 'y_{n+1} = y_n + dt f(t_n,y_n)', 'y,dt,f', 'first-order explicit time stepping'),
(7, 'heat equation', 'partial_t u = D partial_xx u', 'u,D,t,x', 'diffusive smoothing equation'),
(8, 'FTCS heat update', 'u_i^{n+1} = u_i^n + r(u_{i+1}^n - 2u_i^n + u_{i-1}^n)', 'u,r', 'explicit finite difference heat-equation update'),
(9, 'diffusion stability number', 'r = D dt / dx^2', 'r,D,dt,dx', 'dimensionless stability parameter for explicit diffusion'),
(10, 'explicit heat stability', 'r <= 1/2', 'r', 'standard one-dimensional explicit heat-equation stability condition'),
(11, 'Monte Carlo error', 'E_MC ~ sigma_f / sqrt(N)', 'E_MC,sigma_f,N', 'sampling error scaling');

INSERT INTO source_notes VALUES
(1, 'MIT Essential Numerical Methods', 'MIT OpenCourseWare', 'numerical methods lecture notes and textbook-linked course materials', 'https://ocw.mit.edu/courses/22-15-essential-numerical-methods-fall-2014/pages/lecture-notes/'),
(2, 'MIT Numerical Methods for PDEs 2009', 'MIT OpenCourseWare', 'graduate course on physically arising PDE methods', 'https://ocw.mit.edu/courses/18-336-numerical-methods-for-partial-differential-equations-spring-2009/'),
(3, 'MIT Numerical Methods for PDEs 2003', 'MIT OpenCourseWare', 'lecture notes on finite difference finite volume and PDE methods', 'https://ocw.mit.edu/courses/16-920j-numerical-methods-for-partial-differential-equations-sma-5212-spring-2003/pages/lecture-notes/'),
(4, 'Stanford PHYSICS 113', 'Stanford University', 'computational physics course across mechanics astrophysics electromagnetism quantum mechanics and statistical mechanics', 'https://bulletin.stanford.edu/courses/2002611'),
(5, 'SciPy solve_ivp', 'SciPy Developers', 'official ODE initial value problem solver documentation', 'https://docs.scipy.org/doc/scipy/reference/generated/scipy.integrate.solve_ivp.html'),
(6, 'SciPy Sparse Linear Algebra', 'SciPy Developers', 'official sparse linear algebra documentation', 'https://docs.scipy.org/doc/scipy/reference/sparse.linalg.html'),
(7, 'NIST IR 8298', 'NIST', 'verification validation and uncertainty quantification procedures in CFD', 'https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8298.pdf'),
(8, 'NIST Measurement Uncertainty', 'NIST', 'measurement uncertainty resources and uncertainty machine', 'https://physics.nist.gov/cuu/Uncertainty/');

INSERT INTO model_assumptions VALUES
(1, 'finite_difference_convergence', 'Uses smooth analytic functions with known derivatives.'),
(2, 'heat_equation_ftcs', 'Uses explicit forward-time centered-space discretization with fixed boundary values.'),
(3, 'ode_integrator_comparison', 'Uses scalar exponential test equation with analytic solution.'),
(4, 'sparse_poisson_1d', 'Uses one-dimensional Poisson equation with sine source and zero boundary values.'),
(5, 'monte_carlo_pi', 'Uses quarter-circle sampling in unit square with fixed random seed.'),
(6, 'eigenvalue_schrodinger_well', 'Uses dimensionless infinite square well finite difference Hamiltonian.');

INSERT INTO verification_runs VALUES
(1, 'numerical-methods-in-physics', 'finite_difference_convergence', 'central_difference', 'dx refinement cases', 'derivative error and observed order tables', '2026-04-25'),
(2, 'numerical-methods-in-physics', 'heat_equation_ftcs', 'explicit_FTCS', 'diffusion grid and time-step cases', 'stability diagnostics and final profiles', '2026-04-25'),
(3, 'numerical-methods-in-physics', 'ode_integrator_comparison', 'Euler_and_RK4', 'scalar exponential ODE cases', 'exact comparison and absolute errors', '2026-04-25'),
(4, 'numerical-methods-in-physics', 'sparse_poisson_1d', 'sparse_direct_solve', 'one-dimensional Poisson cases', 'profile and error summaries', '2026-04-25'),
(5, 'numerical-methods-in-physics', 'monte_carlo_pi', 'random_sampling', 'sample-size cases', 'pi estimates and standard errors', '2026-04-25'),
(6, 'numerical-methods-in-physics', 'eigenvalue_schrodinger_well', 'sparse_eigenvalue_solve', 'finite difference well cases', 'numeric and exact eigenvalue comparison', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

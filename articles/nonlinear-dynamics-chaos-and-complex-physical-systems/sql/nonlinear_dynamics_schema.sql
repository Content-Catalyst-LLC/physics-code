-- Nonlinear Dynamics, Chaos, and Complex Physical Systems Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores nonlinear systems, parameters, fixed-point cases, attractor notes,
-- physical relations, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS logistic_parameter_cases;
DROP TABLE IF EXISTS lorenz_parameter_cases;
DROP TABLE IF EXISTS fixed_point_cases;
DROP TABLE IF EXISTS nonlinear_system_catalog;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE logistic_parameter_cases (
    case_id TEXT PRIMARY KEY,
    r REAL NOT NULL,
    x0 REAL NOT NULL,
    n_iter INTEGER NOT NULL,
    burn_in INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE lorenz_parameter_cases (
    case_id TEXT PRIMARY KEY,
    sigma REAL NOT NULL,
    rho REAL NOT NULL,
    beta REAL NOT NULL,
    x0 REAL NOT NULL,
    y0 REAL NOT NULL,
    z0 REAL NOT NULL,
    time_end REAL NOT NULL,
    n_time_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE fixed_point_cases (
    case_id TEXT PRIMARY KEY,
    map_or_flow TEXT NOT NULL,
    parameter_value REAL NOT NULL,
    fixed_point REAL NOT NULL,
    derivative_or_eigenvalue REAL NOT NULL,
    stability_rule TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE nonlinear_system_catalog (
    system_name TEXT PRIMARY KEY,
    system_type TEXT NOT NULL,
    core_behavior TEXT NOT NULL,
    canonical_equation_or_note TEXT NOT NULL
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

INSERT INTO logistic_parameter_cases VALUES
('stable_fixed_point', 2.8, 0.2, 1200, 800, 'stable nonzero fixed point'),
('period_doubling', 3.2, 0.2, 1200, 800, 'two-cycle region'),
('higher_period', 3.5, 0.2, 1200, 800, 'higher-period behavior'),
('chaotic', 3.9, 0.2, 1200, 800, 'chaotic region'),
('edge_case', 4.0, 0.200001, 1200, 800, 'fully chaotic idealized edge');

INSERT INTO lorenz_parameter_cases VALUES
('classic_lorenz', 10.0, 28.0, 2.6666666667, 1.0, 1.0, 1.0, 40.0, 8000, 'classic chaotic Lorenz parameters'),
('nearby_lorenz', 10.0, 28.0, 2.6666666667, 1.00000001, 1.0, 1.0, 40.0, 8000, 'nearby initial condition for separation'),
('lower_rho', 10.0, 10.0, 2.6666666667, 1.0, 1.0, 1.0, 30.0, 6000, 'lower rho comparison'),
('higher_rho', 10.0, 35.0, 2.6666666667, 1.0, 1.0, 1.0, 40.0, 8000, 'higher rho comparison');

INSERT INTO fixed_point_cases VALUES
('logistic_zero_r_0_8', 'logistic_map', 0.8, 0.0, 0.8, 'abs(derivative)<1', 'stable zero fixed point'),
('logistic_zero_r_1_2', 'logistic_map', 1.2, 0.0, 1.2, 'abs(derivative)<1', 'unstable zero fixed point'),
('logistic_nonzero_r_2_5', 'logistic_map', 2.5, 0.6, -0.5, 'abs(derivative)<1', 'stable nonzero fixed point'),
('logistic_nonzero_r_3_2', 'logistic_map', 3.2, 0.6875, -1.2, 'abs(derivative)<1', 'unstable after period doubling'),
('saddle_node_normal_r_neg', 'saddle_node_flow', -1.0, 1.0, 2.0, 'derivative sign depends on one-dimensional flow', 'illustrative normal-form point');

INSERT INTO nonlinear_system_catalog VALUES
('logistic_map', 'discrete_map', 'bifurcation and chaos', 'x_{n+1}=r x_n(1-x_n)'),
('lorenz_system', 'continuous_flow', 'strange attractor and sensitive dependence', 'three-dimensional nonlinear ODE'),
('van_der_pol_oscillator', 'continuous_flow', 'stable limit cycle', 'nonlinear damping'),
('duffing_oscillator', 'continuous_flow', 'nonlinear resonance and chaos when driven', 'cubic stiffness oscillator'),
('forced_damped_pendulum', 'continuous_flow', 'periodic and chaotic dynamics', 'driven nonlinear pendulum'),
('henon_map', 'discrete_map', 'strange attractor', 'two-dimensional map'),
('rossler_system', 'continuous_flow', 'chaotic attractor', 'three-dimensional flow'),
('kuramoto_model', 'coupled_oscillator_system', 'synchronization', 'phase oscillator network'),
('reaction_diffusion_system', 'spatial_pde', 'pattern formation', 'local reaction plus diffusion'),
('navier_stokes_flow', 'continuum_pde', 'turbulence and coherent structures', 'nonlinear fluid momentum equations');

INSERT INTO physical_relations VALUES
(1, 'continuous dynamical system', 'dx/dt = F(x, mu)', 'x,t,F,mu', 'state evolution in continuous time'),
(2, 'fixed point', 'F(x*, mu) = 0', 'F,x*,mu', 'equilibrium state of continuous system'),
(3, 'Jacobian', 'J_ij = partial F_i / partial x_j', 'J,F,x', 'linearized local dynamics'),
(4, 'discrete map', 'x_{n+1} = f(x_n)', 'x_n,f', 'state evolution by iteration'),
(5, 'map fixed point', 'x* = f(x*)', 'x*,f', 'equilibrium of iterated map'),
(6, 'one-dimensional map stability', '|f''(x*)| < 1', 'f,x*', 'local stability criterion for maps'),
(7, 'logistic map', 'x_{n+1}=r x_n(1-x_n)', 'x_n,r', 'canonical nonlinear iterated map'),
(8, 'Lorenz x equation', 'dx/dt = sigma(y - x)', 'x,y,t,sigma', 'Lorenz system x evolution'),
(9, 'Lorenz y equation', 'dy/dt = x(rho-z)-y', 'x,y,z,t,rho', 'Lorenz system y evolution'),
(10, 'Lorenz z equation', 'dz/dt = xy - beta z', 'x,y,z,t,beta', 'Lorenz system z evolution'),
(11, 'separation growth', '|delta(t)| approx |delta(0)| exp(lambda t)', 'delta,lambda,t', 'sensitive dependence approximation'),
(12, 'Lyapunov estimate', 'lambda approx (1/t) ln(|delta(t)|/|delta(0)|)', 'lambda,t,delta', 'average exponential separation rate');

INSERT INTO model_metadata VALUES
(1, 'fixed_point_analysis', 'equilibrium and local behavior', 'Jacobian eigenvalues', 'local analysis may miss global structure'),
(2, 'bifurcation_analysis', 'qualitative parameter changes', 'control parameter', 'normal forms are simplified'),
(3, 'logistic_map', 'iteration and chaos demonstration', 'r', 'idealized dimensionless map'),
(4, 'lorenz_system', 'deterministic chaos example', 'sigma rho beta', 'simplified convection-related model'),
(5, 'lyapunov_diagnostic', 'predictability and sensitivity', 'lambda', 'careful algorithms needed for rigorous estimates'),
(6, 'strange_attractor', 'long-run chaotic geometry', 'attractor set', 'visualization alone is insufficient'),
(7, 'phase_portrait', 'geometric dynamics', 'state variables', 'projection may hide higher-dimensional structure');

INSERT INTO source_notes VALUES
(1, 'MIT Nonlinear Dynamics Chaos 2022', 'MIT OpenCourseWare', 'introduction to nonlinear dynamics and chaos in dissipative systems', 'https://ocw.mit.edu/courses/12-006j-nonlinear-dynamics-chaos-fall-2022/'),
(2, 'MIT Nonlinear Dynamics Chaos Lecture Notes 2022', 'MIT OpenCourseWare', 'lecture notes on strange attractors fractal dimension Lyapunov exponents intermittency', 'https://ocw.mit.edu/courses/12-006j-nonlinear-dynamics-chaos-fall-2022/pages/lecture-notes/'),
(3, 'MIT Nonlinear Dynamics and Chaos 2014', 'MIT OpenCourseWare', 'lecture notes supplementing Strogatz nonlinear dynamics text', 'https://ocw.mit.edu/courses/18-385j-nonlinear-dynamics-and-chaos-fall-2014/pages/lecture-notes/'),
(4, 'MIT Classical Mechanics III Chaos', 'MIT OpenCourseWare', 'physics lecture notes on chaos and nonlinear dynamics', 'https://ocw.mit.edu/courses/8-09-classical-mechanics-iii-fall-2014/resources/mit8_09f14_chapter_7/'),
(5, 'Lorenz Deterministic Nonperiodic Flow', 'Journal of the Atmospheric Sciences', 'classic Lorenz chaos paper', 'https://doi.org/10.1175/1520-0469(1963)020%3C0130:DNF%3E2.0.CO;2'),
(6, 'Strogatz Nonlinear Dynamics and Chaos', 'Routledge', 'standard applied nonlinear dynamics textbook', 'https://www.routledge.com/Nonlinear-Dynamics-and-Chaos-With-Applications-to-Physics-Biology-Chemistry-and-Engineering/Strogatz/p/book/9780367026509'),
(7, 'Santa Fe Institute Complex Systems Summer School', 'Santa Fe Institute', 'complex systems education and research context', 'https://santafe.edu/engage/learn/programs/sfi-complex-systems-summer-school/experience');

INSERT INTO model_assumptions VALUES
(1, 'lorenz_trajectory_separation', 'Uses classic Lorenz parameters sigma=10 rho=28 beta=8/3.'),
(2, 'lorenz_trajectory_separation', 'Uses nearby initial conditions to demonstrate sensitivity, not a rigorous Lyapunov spectrum.'),
(3, 'logistic_map_bifurcation', 'Uses post-transient samples from deterministic map iteration.'),
(4, 'fixed_point_stability', 'Uses one-dimensional derivative stability criterion for the logistic map.'),
(5, 'lyapunov_logistic_scaffold', 'Uses average log absolute derivative after burn-in as a simple map Lyapunov estimate.'),
(6, 'nonlinear_dynamics_schema', 'Stores educational metadata rather than a production chaos-analysis database.');

INSERT INTO simulation_runs VALUES
(1, 'nonlinear-dynamics-chaos-and-complex-physical-systems', 'lorenz_trajectory_separation', 'adaptive_ode_integration', 'two initial states separated by 1e-8', 'trajectory and separation diagnostics', '2026-04-25'),
(2, 'nonlinear-dynamics-chaos-and-complex-physical-systems', 'logistic_map_bifurcation', 'map_iteration_parameter_sweep', 'r from 2.5 to 4.0 step 0.005', 'post-transient bifurcation data and summary', '2026-04-25'),
(3, 'nonlinear-dynamics-chaos-and-complex-physical-systems', 'fixed_point_stability', 'closed_form_derivative_check', 'sample logistic map r values', 'fixed-point stability table', '2026-04-25'),
(4, 'nonlinear-dynamics-chaos-and-complex-physical-systems', 'lyapunov_logistic_scaffold', 'average_log_derivative', 'r from 2.5 to 4.0 step 0.01', 'Lyapunov estimate table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

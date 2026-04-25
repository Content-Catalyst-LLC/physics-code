-- Physics-Informed Machine Learning and Scientific Computing Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS heat_residual_cases;
DROP TABLE IF EXISTS decay_pinn_cases;
DROP TABLE IF EXISTS inverse_diffusion_cases;
DROP TABLE IF EXISTS operator_learning_cases;
DROP TABLE IF EXISTS conservation_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS training_runs;

CREATE TABLE heat_residual_cases (
    case_id TEXT PRIMARY KEY,
    diffusion REAL NOT NULL,
    n_x INTEGER NOT NULL,
    n_t INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE decay_pinn_cases (
    case_id TEXT PRIMARY KEY,
    lambda_value REAL NOT NULL,
    u0 REAL NOT NULL,
    t_min REAL NOT NULL,
    t_max REAL NOT NULL,
    n_collocation INTEGER NOT NULL,
    n_epochs INTEGER NOT NULL,
    learning_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE inverse_diffusion_cases (
    case_id TEXT PRIMARY KEY,
    true_diffusion REAL NOT NULL,
    n_x INTEGER NOT NULL,
    n_t INTEGER NOT NULL,
    noise_sd REAL NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE operator_learning_cases (
    case_id TEXT PRIMARY KEY,
    n_functions INTEGER NOT NULL,
    n_x INTEGER NOT NULL,
    n_t INTEGER NOT NULL,
    diffusion REAL NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE conservation_cases (
    case_id TEXT PRIMARY KEY,
    n_grid INTEGER NOT NULL,
    velocity REAL NOT NULL,
    time_step REAL NOT NULL,
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

CREATE TABLE training_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    method TEXT,
    parameter_summary TEXT,
    output_summary TEXT,
    created_at TEXT NOT NULL
);

INSERT INTO heat_residual_cases VALUES
('baseline_heat_residual', 0.1, 101, 101, 'manufactured heat-equation solution residual diagnostics'),
('coarse_grid_heat_residual', 0.1, 51, 51, 'coarser grid residual diagnostics'),
('higher_diffusion_heat_residual', 0.5, 101, 101, 'higher diffusion residual diagnostics');

INSERT INTO decay_pinn_cases VALUES
('baseline_decay', 1.5, 1.0, 0.0, 2.0, 100, 5000, 0.001, 'baseline exponential decay PINN'),
('slow_decay', 0.5, 1.0, 0.0, 4.0, 120, 5000, 0.001, 'slower decay training scaffold'),
('fast_decay', 3.0, 1.0, 0.0, 2.0, 120, 6000, 0.001, 'faster decay training scaffold');

INSERT INTO physical_relations VALUES
(1, 'physical operator equation', 'N[u;lambda] = 0', 'N,u,lambda', 'abstract governing physical law'),
(2, 'neural field approximation', 'u_theta(x,t)', 'u,theta,x,t', 'trainable approximation to physical field'),
(3, 'physics residual', 'r_theta(x,t) = N[u_theta;lambda](x,t)', 'r,N,u,theta,lambda', 'equation violation by learned model'),
(4, 'PDE residual loss', 'L_r = (1/N_r) sum_i |r_theta(x_i,t_i)|^2', 'L_r,N_r,r', 'mean squared physics residual at collocation points'),
(5, 'data loss', 'L_d = (1/N_d) sum_j |u_theta(x_j,t_j)-y_j|^2', 'L_d,N_d,u,y', 'mismatch with observations'),
(6, 'total PINN loss', 'L = lambda_r L_r + lambda_b L_b + lambda_i L_i + lambda_d L_d', 'L,lambda,L_r,L_b,L_i,L_d', 'combined physics and data training objective'),
(7, 'neural ODE', 'dx/dt = f_theta(x,t)', 'x,t,theta', 'differential equation with neural dynamics'),
(8, 'universal differential equation', 'dx/dt = f_known(x,t;alpha) + g_theta(x,t)', 'x,t,alpha,theta', 'known mechanistic dynamics plus learned correction'),
(9, 'operator learning map', 'G_theta: a(x) -> u(x,t)', 'G,a,u,theta', 'learned mapping between function spaces'),
(10, 'Bayesian posterior', 'p(theta,lambda|y) proportional to p(y|theta,lambda)p(theta,lambda)', 'theta,lambda,y', 'uncertainty-aware inverse inference');

INSERT INTO source_notes VALUES
(1, 'Raissi Perdikaris Karniadakis PINN', 'Journal of Computational Physics', 'foundational physics-informed neural networks paper', 'https://www.sciencedirect.com/science/article/pii/S0021999118307125'),
(2, 'Karniadakis et al Physics-informed ML', 'Nature Reviews Physics', 'broad review of physics-informed machine learning capabilities limitations and applications', 'https://www.nature.com/articles/s42254-021-00314-5'),
(3, 'Cuomo et al Scientific ML through PINNs', 'Journal of Scientific Computing', 'review of PINNs and variants', 'https://link.springer.com/article/10.1007/s10915-022-01939-z'),
(4, 'Lu et al DeepONet', 'Nature Machine Intelligence', 'operator learning through DeepONet', 'https://www.osti.gov/biblio/2281727'),
(5, 'MITx Computational Data Science in Physics III', 'MITx Online', 'course including physics-informed machine learning and simulation-based inference', 'https://mitxonline.mit.edu/courses/course-v1%3AMITxT%2B8.S50.3x/'),
(6, 'MIT Scientific Machine Learning Course', 'MIT/SciML', 'course mixing HPC numerical analysis and machine learning', 'https://book.sciml.ai/course/'),
(7, 'SciML Docs', 'SciML', 'open-source scientific machine learning documentation', 'https://docs.sciml.ai/'),
(8, 'SciML Neural ODE Docs', 'SciML', 'neural ordinary differential equation examples', 'https://docs.sciml.ai/DiffEqFlux/stable/examples/neural_ode/');

INSERT INTO model_assumptions VALUES
(1, 'heat_equation_residual_diagnostics', 'Uses manufactured heat-equation solution and finite-difference derivatives for residual diagnostics.'),
(2, 'pinn_decay_equation', 'Uses a small fully connected network and exponential decay equation for teaching-scale PINN training.'),
(3, 'inverse_diffusion_parameter', 'Uses synthetic heat-equation data and grid search for diffusion parameter estimation.'),
(4, 'operator_learning_dataset', 'Generates toy heat-equation operator data from random sine modes.'),
(5, 'conservation_diagnostics', 'Uses periodic upwind advection as a conservation diagnostic scaffold.');

INSERT INTO training_runs VALUES
(1, 'physics-informed-machine-learning-and-scientific-computing', 'heat_equation_residual_diagnostics', 'finite_difference_residual', 'heat residual cases', 'residual tables and summaries', '2026-04-25'),
(2, 'physics-informed-machine-learning-and-scientific-computing', 'pinn_decay_equation', 'PyTorch_PINN_training', 'decay PINN cases', 'training history and validation summaries', '2026-04-25'),
(3, 'physics-informed-machine-learning-and-scientific-computing', 'inverse_diffusion_parameter', 'grid_search_inverse_problem', 'synthetic diffusion cases', 'objective curves and parameter estimates', '2026-04-25'),
(4, 'physics-informed-machine-learning-and-scientific-computing', 'operator_learning_dataset', 'synthetic_operator_data_generation', 'heat operator cases', 'function-to-solution dataset tables', '2026-04-25'),
(5, 'physics-informed-machine-learning-and-scientific-computing', 'conservation_diagnostics', 'finite_difference_conservation_check', 'advection conservation cases', 'mass conservation diagnostics', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

-- Quantum Mechanics and the Limits of Classical Intuition Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, model parameters, eigenstates, operators,
-- measurement samples, source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS box_parameters;
DROP TABLE IF EXISTS eigenstates;
DROP TABLE IF EXISTS operators;
DROP TABLE IF EXISTS measurement_samples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE constants (
    constant_id INTEGER PRIMARY KEY,
    constant_name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE box_parameters (
    parameter_id INTEGER PRIMARY KEY,
    parameter_name TEXT NOT NULL,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE eigenstates (
    eigenstate_id INTEGER PRIMARY KEY,
    state_n INTEGER NOT NULL,
    energy_j REAL NOT NULL,
    energy_ev REAL NOT NULL,
    model_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE operators (
    operator_id INTEGER PRIMARY KEY,
    operator_name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    coordinate_representation TEXT,
    physical_quantity TEXT,
    notes TEXT
);

CREATE TABLE measurement_samples (
    sample_id INTEGER PRIMARY KEY,
    state_n INTEGER NOT NULL,
    position_fraction_of_l REAL NOT NULL,
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

INSERT INTO constants (
    constant_id,
    constant_name,
    symbol,
    value,
    unit,
    notes
) VALUES
(1, 'Planck constant', 'h', 6.62607015e-34, 'J s', 'exact SI value'),
(2, 'reduced Planck constant', 'hbar', 1.054571817e-34, 'J s', 'derived from h divided by 2 pi'),
(3, 'electron mass', 'm_e', 9.1093837015e-31, 'kg', 'electron mass'),
(4, 'elementary charge', 'e', 1.602176634e-19, 'C', 'exact SI value'),
(5, 'joule per electron volt', 'J_per_eV', 1.602176634e-19, 'J', 'energy conversion');

INSERT INTO box_parameters (
    parameter_id,
    parameter_name,
    value,
    unit,
    notes
) VALUES
(1, 'box_length', 1.0e-9, 'm', 'one nanometer infinite square well'),
(2, 'grid_points', 2000, 'count', 'article-level sampling grid'),
(3, 'interior_points_finite_difference', 500, 'count', 'finite-difference Hamiltonian grid');

INSERT INTO eigenstates (
    eigenstate_id,
    state_n,
    energy_j,
    energy_ev,
    model_name,
    notes
) VALUES
(1, 1, 6.024667e-20, 0.376030, 'particle_in_box', 'electron in 1 nm well'),
(2, 2, 2.409867e-19, 1.504120, 'particle_in_box', 'electron in 1 nm well'),
(3, 3, 5.422200e-19, 3.384270, 'particle_in_box', 'electron in 1 nm well');

INSERT INTO operators (
    operator_id,
    operator_name,
    symbol,
    coordinate_representation,
    physical_quantity,
    notes
) VALUES
(1, 'position', 'x_hat', 'x', 'position', 'multiplication by x'),
(2, 'momentum', 'p_hat', '-i hbar d/dx', 'momentum', 'derivative operator'),
(3, 'hamiltonian', 'H_hat', '-hbar^2/(2m) d2/dx2 + V(x)', 'energy', 'governs time evolution'),
(4, 'identity', 'I', 'identity', 'state preservation', 'operator identity'),
(5, 'position_momentum_commutator', '[x_hat,p_hat]', 'i hbar', 'noncommutation', 'source of uncertainty relation');

INSERT INTO measurement_samples (
    sample_id,
    state_n,
    position_fraction_of_l,
    notes
) VALUES
(1, 1, 0.47, 'illustrative simulated measurement'),
(2, 1, 0.52, 'illustrative simulated measurement'),
(3, 1, 0.39, 'illustrative simulated measurement'),
(4, 1, 0.61, 'illustrative simulated measurement'),
(5, 2, 0.22, 'illustrative simulated measurement'),
(6, 2, 0.29, 'illustrative simulated measurement'),
(7, 2, 0.72, 'illustrative simulated measurement'),
(8, 2, 0.78, 'illustrative simulated measurement'),
(9, 3, 0.16, 'illustrative simulated measurement'),
(10, 3, 0.51, 'illustrative simulated measurement'),
(11, 3, 0.84, 'illustrative simulated measurement');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'de_broglie_wavelength', 'lambda = h / p', 'lambda,h,p', 'matter-wave relation'),
(2, 'time_dependent_schrodinger', 'i hbar partial_t psi = H psi', 'i,hbar,psi,H,t', 'state evolution'),
(3, 'stationary_schrodinger', 'H psi = E psi', 'H,psi,E', 'energy eigenvalue problem'),
(4, 'born_rule', 'P(x)=|psi(x)|^2', 'P,psi,x', 'probability density in position space'),
(5, 'uncertainty_relation', 'Delta x Delta p >= hbar/2', 'Delta x,Delta p,hbar', 'position-momentum uncertainty'),
(6, 'particle_box_eigenstate', 'psi_n=sqrt(2/L) sin(n pi x/L)', 'psi,n,L,x', 'infinite square well eigenfunction'),
(7, 'particle_box_energy', 'E_n=n^2 pi^2 hbar^2/(2mL^2)', 'E,n,hbar,m,L', 'infinite square well energy eigenvalue');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'Quantum Physics I', 'MIT OpenCourseWare', 'quantum physics course and lecture notes', 'https://ocw.mit.edu/courses/8-04-quantum-physics-i-spring-2016/'),
(2, 'Quantum Physics I Lecture Notes', 'MIT OpenCourseWare', 'wave mechanics and one-dimensional potentials', 'https://ocw.mit.edu/courses/8-04-quantum-physics-i-spring-2016/pages/lecture-notes/'),
(3, 'Fundamental Physical Constants', 'NIST', 'physical constants', 'https://physics.nist.gov/cuu/Constants/index.html'),
(4, 'Philosophical Issues in Quantum Theory', 'Stanford Encyclopedia of Philosophy', 'interpretation and measurement context', 'https://plato.stanford.edu/entries/qt-issues/'),
(5, 'Planck 1901', 'Annalen der Physik', 'blackbody radiation and quantization', 'https://doi.org/10.1002/andp.19013090310'),
(6, 'Einstein 1905', 'Annalen der Physik', 'light quantum paper', 'https://doi.org/10.1002/andp.19053220607'),
(7, 'Heisenberg 1925', 'Zeitschrift fuer Physik', 'matrix mechanics', 'https://doi.org/10.1007/BF01328377'),
(8, 'Schrodinger 1926', 'Annalen der Physik', 'wave mechanics and eigenvalue problem', 'https://doi.org/10.1002/andp.19263840404'),
(9, 'Born 1926', 'Zeitschrift fuer Physik', 'probabilistic interpretation', 'https://doi.org/10.1007/BF01397477');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'particle_box_eigenstates', 'Uses analytic eigenstates of the one-dimensional infinite square well.'),
(2, 'finite_difference_hamiltonian', 'Uses a second-derivative finite-difference Hamiltonian on a uniform grid.'),
(3, 'gaussian_wavepacket_uncertainty', 'Uses a normalized real Gaussian wavefunction and estimates position uncertainty numerically.'),
(4, 'measurement_histogram_simulation', 'Samples from a discretized probability density rather than modeling a full detector.'),
(5, 'quantum_mechanics_schema', 'Stores educational metadata rather than a complete quantum experiment database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'quantum-mechanics-and-the-limits-of-classical-intuition', 'particle_box_eigenstates', 'analytic_sampling', 'electron, L=1 nm, n=1..5', 'energies, normalization, expectation values, uncertainty', '2026-04-24'),
(2, 'quantum-mechanics-and-the-limits-of-classical-intuition', 'finite_difference_hamiltonian', 'tridiagonal_eigenvalue', 'electron, L=1 nm, 500 interior points', 'numerical and analytic eigenvalue comparison', '2026-04-24'),
(3, 'quantum-mechanics-and-the-limits-of-classical-intuition', 'gaussian_wavepacket_uncertainty', 'grid_integration', 'sigma values from 0.25 nm to 1.0 nm', 'normalization and uncertainty table', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

-- Statistical Physics and the Emergence of Macroscopic Order Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, ensembles, state models, physical relations,
-- source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS two_state_parameters;
DROP TABLE IF EXISTS ensembles;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
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

CREATE TABLE two_state_parameters (
    parameter_id INTEGER PRIMARY KEY,
    case_id TEXT NOT NULL,
    n_particles INTEGER NOT NULL,
    temperature_k REAL NOT NULL,
    excitation_energy_j REAL NOT NULL,
    notes TEXT
);

CREATE TABLE ensembles (
    ensemble_id INTEGER PRIMARY KEY,
    ensemble_name TEXT NOT NULL,
    fixed_quantities TEXT NOT NULL,
    allowed_to_fluctuate TEXT NOT NULL,
    typical_use TEXT NOT NULL
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

INSERT INTO constants (
    constant_id,
    constant_name,
    symbol,
    value,
    unit,
    notes
) VALUES
(1, 'Boltzmann constant', 'k_B', 1.380649e-23, 'J K^-1', 'exact SI value'),
(2, 'Avogadro constant', 'N_A', 6.02214076e23, 'mol^-1', 'exact SI value'),
(3, 'gas constant', 'R', 8.31446261815324, 'J mol^-1 K^-1', 'derived from N_A k_B'),
(4, 'electron volt', 'eV', 1.602176634e-19, 'J', 'energy conversion'),
(5, 'room temperature', 'T_room', 300.0, 'K', 'article example temperature');

INSERT INTO two_state_parameters (
    parameter_id,
    case_id,
    n_particles,
    temperature_k,
    excitation_energy_j,
    notes
) VALUES
(1, 'small_10', 10, 300, 2e-21, 'small finite system'),
(2, 'medium_50', 50, 300, 2e-21, 'moderate finite system'),
(3, 'large_200', 200, 300, 2e-21, 'larger finite system'),
(4, 'large_1000', 1000, 300, 2e-21, 'thermodynamic-style sharp distribution'),
(5, 'hot_100', 100, 600, 2e-21, 'higher-temperature comparison'),
(6, 'cold_100', 100, 150, 2e-21, 'lower-temperature comparison');

INSERT INTO ensembles (
    ensemble_id,
    ensemble_name,
    fixed_quantities,
    allowed_to_fluctuate,
    typical_use
) VALUES
(1, 'microcanonical', 'E,N,V', 'observables within fixed energy shell', 'isolated systems'),
(2, 'canonical', 'T,N,V', 'energy', 'system in thermal contact with reservoir'),
(3, 'grand canonical', 'T,V,mu', 'energy and particle number', 'open systems exchanging particles and heat'),
(4, 'isothermal isobaric', 'T,N,P', 'energy and volume', 'constant pressure thermal systems');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'Boltzmann entropy', 'S = k_B ln W', 'S,k_B,W', 'entropy from multiplicity'),
(2, 'inverse thermal energy', 'beta = 1/(k_B T)', 'beta,k_B,T', 'canonical weighting scale'),
(3, 'canonical probability', 'P_i = exp(-beta E_i) / Z', 'P_i,beta,E_i,Z', 'probability of microstate i'),
(4, 'partition function', 'Z = sum_i exp(-beta E_i)', 'Z,beta,E_i', 'weighted sum over states'),
(5, 'Helmholtz free energy', 'F = -k_B T ln Z', 'F,k_B,T,Z', 'thermodynamic potential from partition function'),
(6, 'mean energy', '<E> = - partial ln Z / partial beta', 'E,Z,beta', 'ensemble-average energy'),
(7, 'energy fluctuations', '<Delta E^2> = k_B T^2 C_V', 'Delta E,k_B,T,C_V', 'fluctuation-response relation'),
(8, 'two-state partition function', 'Z = 1 + exp(-beta epsilon)', 'Z,beta,epsilon', 'single-particle two-state model'),
(9, 'two-state multiplicity', 'W(n)=N!/[n!(N-n)!]', 'W,n,N', 'macrostate count for independent binary constituents');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'two-state system', 'illustrate Boltzmann weighting and finite-size fluctuations', 'excited-state probability', 'no interactions'),
(2, 'macrostate distribution', 'show multiplicity and typicality', 'W(n)', 'simple independent constituents'),
(3, 'canonical ensemble', 'thermal weighting at fixed temperature', 'Z', 'requires equilibrium assumptions'),
(4, 'Monte Carlo sampling', 'approximate distribution through repeated draws', 'sample statistics', 'requires convergence diagnostics'),
(5, 'Ising scaffold', 'illustrate order parameter and collective behavior', 'magnetization', 'toy implementation only'),
(6, 'fluctuation scaling', 'show relative fluctuations shrink with size', 'sd/mean', 'model-dependent scaling');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'MIT Statistical Mechanics I', 'MIT OpenCourseWare', 'graduate statistical mechanics course', 'https://ocw.mit.edu/courses/8-333-statistical-mechanics-i-statistical-mechanics-of-particles-fall-2013/'),
(2, 'MIT Statistical Mechanics I Lecture Notes', 'MIT OpenCourseWare', 'thermodynamics probability kinetic theory classical and quantum statistical mechanics', 'https://ocw.mit.edu/courses/8-333-statistical-mechanics-i-statistical-mechanics-of-particles-fall-2013/pages/lecture-notes/'),
(3, 'NIST Boltzmann Constant', 'NIST', 'exact Boltzmann constant value', 'https://physics.nist.gov/cgi-bin/cuu/Value?k='),
(4, 'NIST Essential Statistical Thermodynamics', 'NIST', 'statistical thermodynamics reference', 'https://cccbdb.nist.gov/thermox.asp'),
(5, 'Boltzmann 1877 Translation', 'Entropy journal', 'entropy probability and thermal equilibrium translation', 'https://www.mdpi.com/1099-4300/17/4/1971'),
(6, 'Gibbs 1902', 'Internet Archive', 'foundational statistical mechanics text', 'https://archive.org/details/elementaryprinci00gibbrich'),
(7, 'Perrin Brownian Movement', 'Internet Archive', 'Brownian motion and molecular reality', 'https://ia601405.us.archive.org/15/items/in.ernet.dli.2015.212491/2015.212491.Brownian-Movement_text.pdf');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'two_state_distribution', 'Uses independent two-state constituents in the canonical ensemble.'),
(2, 'partition_function_summary', 'Uses a single-particle two-state partition function over temperature.'),
(3, 'ising_lattice_scaffold', 'Uses a compact 2D Ising-style toy model with periodic boundaries.'),
(4, 'two_state_fluctuation_scaling', 'Uses exact finite-N macrostate distributions for independent constituents.'),
(5, 'statistical_physics_schema', 'Stores educational metadata rather than a production statistical thermodynamics database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'statistical-physics-and-the-emergence-of-macroscopic-order', 'two_state_distribution', 'exact_distribution_and_monte_carlo', 'N=100, T=300 K, epsilon=2e-21 J', 'macrostate distribution and Monte Carlo summary', '2026-04-25'),
(2, 'statistical-physics-and-the-emergence-of-macroscopic-order', 'partition_function_summary', 'temperature_sweep', 'T=50..1000 K and epsilon=2e-21 J', 'partition function and thermodynamic quantities', '2026-04-25'),
(3, 'statistical-physics-and-the-emergence-of-macroscopic-order', 'ising_lattice_scaffold', 'metropolis_scaffold', '32x32 lattice with beta values 0.2..0.8', 'magnetization and energy summaries', '2026-04-25'),
(4, 'statistical-physics-and-the-emergence-of-macroscopic-order', 'two_state_fluctuation_scaling', 'exact_distribution', 'N=10,50,200,1000', 'relative fluctuation scaling', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

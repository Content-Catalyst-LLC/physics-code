-- Many-Body Physics and Emergent Collective Behavior Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, Hilbert-space cases, occupation cases, spin-chain cases,
-- many-body model cases, phase examples, physical relations, model metadata,
-- source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS many_body_constants;
DROP TABLE IF EXISTS hilbert_space_cases;
DROP TABLE IF EXISTS occupation_cases;
DROP TABLE IF EXISTS spin_chain_cases;
DROP TABLE IF EXISTS many_body_model_cases;
DROP TABLE IF EXISTS phase_examples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE many_body_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE hilbert_space_cases (
    case_id TEXT PRIMARY KEY,
    local_dimension INTEGER NOT NULL,
    n_min INTEGER NOT NULL,
    n_max INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE occupation_cases (
    case_id TEXT PRIMARY KEY,
    temperature_k REAL NOT NULL,
    chemical_potential_ev REAL NOT NULL,
    energy_min_ev REAL NOT NULL,
    energy_max_ev REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE spin_chain_cases (
    case_id TEXT PRIMARY KEY,
    n_sites INTEGER NOT NULL,
    coupling_j REAL NOT NULL,
    transverse_field_h REAL NOT NULL,
    boundary_condition TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE many_body_model_cases (
    model_name TEXT PRIMARY KEY,
    primary_degrees_of_freedom TEXT NOT NULL,
    hamiltonian_terms TEXT NOT NULL,
    typical_phenomena TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE phase_examples (
    phase_name TEXT PRIMARY KEY,
    order_or_structure TEXT NOT NULL,
    key_excitation TEXT,
    example_systems TEXT,
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

INSERT INTO many_body_constants VALUES
('boltzmann_constant_ev_k', 8.617333262e-5, 'eV K^-1', 'Boltzmann constant in electronvolts per kelvin'),
('boltzmann_constant_si', 1.380649e-23, 'J K^-1', 'exact SI value'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('electron_volt', 1.602176634e-19, 'J', 'exact SI conversion'),
('spin_half_dimension', 2, 'dimensionless', 'local Hilbert-space dimension for spin one-half');

INSERT INTO hilbert_space_cases VALUES
('spin_half_chain', 2, 2, 40, 'spin one-half chain dimension d^N'),
('spin_one_chain', 3, 2, 24, 'spin one chain dimension d^N'),
('two_orbital_site', 4, 2, 24, 'local four-state system dimension d^N'),
('qubit_register', 2, 2, 60, 'quantum information register dimension');

INSERT INTO occupation_cases VALUES
('low_temperature', 50, 0.0, -0.5, 1.5, 201, 'low-temperature occupation comparison'),
('room_temperature', 300, 0.0, -0.5, 1.5, 201, 'room-temperature occupation comparison'),
('high_temperature', 1000, 0.0, -0.5, 1.5, 201, 'high-temperature occupation comparison'),
('cold_atoms_like', 10, 0.0, 0.001, 0.2, 200, 'positive-energy Bose occupation scaffold');

INSERT INTO spin_chain_cases VALUES
('ordered_side_6', 6, 1.0, 0.5, 'periodic', 'small chain in ordered-side parameter regime'),
('critical_like_6', 6, 1.0, 1.0, 'periodic', 'small chain near transverse-field Ising critical point'),
('disordered_side_6', 6, 1.0, 1.5, 'periodic', 'small chain in disordered-side parameter regime'),
('critical_like_8', 8, 1.0, 1.0, 'periodic', 'larger teaching-scale exact diagonalization case');

INSERT INTO many_body_model_cases VALUES
('Ising model', 'spins', 'nearest-neighbor spin coupling and field', 'magnetism phase transitions criticality', 'canonical classical and quantum spin model'),
('Heisenberg model', 'quantum spins', 'exchange interaction', 'magnetism magnons frustration spin liquids', 'central quantum magnetism model'),
('Hubbard model', 'electrons on lattice', 'hopping and on-site interaction', 'Mott physics magnetism strong correlation', 'central correlated-electron model'),
('Bose-Hubbard model', 'bosons on lattice', 'hopping and on-site interaction', 'superfluid Mott transition', 'cold atoms and lattice bosons'),
('BCS model', 'paired fermions', 'attractive pairing interaction', 'superconductivity energy gap Cooper pairing', 'conventional superconductivity scaffold'),
('Fermi liquid', 'fermionic quasiparticles', 'renormalized quasiparticle interactions', 'metallic low-energy behavior', 'effective theory of many metals');

INSERT INTO phase_examples VALUES
('ferromagnet', 'broken spin-rotation or spin-flip symmetry', 'magnon', 'magnetic materials', 'ordered spin phase'),
('Fermi liquid', 'Fermi surface with quasiparticles', 'fermionic quasiparticle', 'ordinary metals', 'emergent low-energy quasiparticle theory'),
('superfluid', 'macroscopic phase coherence', 'phonon and vortex', 'helium and ultracold gases', 'flows without ordinary viscosity'),
('superconductor', 'paired electronic condensate', 'Bogoliubov quasiparticle', 'superconducting metals and materials', 'zero resistance and Meissner effect'),
('Mott insulator', 'interaction-driven localization', 'spin and charge excitations', 'correlated oxides', 'Hubbard U blocks metallic behavior'),
('topological order', 'long-range entanglement', 'anyon or edge mode', 'quantum Hall systems and spin liquids', 'beyond local symmetry-breaking classification'),
('spin liquid', 'entangled disordered spin state', 'fractionalized excitation', 'frustrated quantum magnets', 'no conventional magnetic order');

INSERT INTO physical_relations VALUES
(1, 'many-body Hamiltonian', 'H = sum_i h_i + sum_i<j V_ij', 'H,h_i,V_ij', 'generic one-body plus interaction structure'),
(2, 'spin-half Hilbert dimension', 'dim H = 2^N', 'dim H,N', 'exponential state-space growth'),
(3, 'Fermi-Dirac occupation', 'f(E) = 1/(exp((E - mu)/(k_B T)) + 1)', 'f,E,mu,k_B,T', 'fermionic occupation probability'),
(4, 'Bose-Einstein occupation', 'n(E) = 1/(exp((E - mu)/(k_B T)) - 1)', 'n,E,mu,k_B,T', 'bosonic occupation number'),
(5, 'Hubbard model', 'H = -t sum_<i,j>,sigma (c_i_sigma dagger c_j_sigma + h.c.) + U sum_i n_i_up n_i_down', 'H,t,U,c,n', 'minimal correlated electron lattice model'),
(6, 'Heisenberg model', 'H = J sum_<i,j> S_i dot S_j', 'H,J,S_i,S_j', 'quantum spin exchange model'),
(7, 'connected correlation', 'C_ij = <O_i O_j> - <O_i><O_j>', 'C_ij,O_i,O_j', 'connected two-point correlation'),
(8, 'structure factor', 'S(q) = 1/N sum_ij exp(i q(r_i-r_j)) <O_i O_j>', 'S,q,N,O_i,O_j', 'momentum-space correlations'),
(9, 'entanglement entropy', 'S_A = -Tr(rho_A ln rho_A)', 'S_A,rho_A', 'bipartite entanglement measure'),
(10, 'partition function', 'Z = Tr(exp(-beta H))', 'Z,beta,H', 'thermal many-body state normalization'),
(11, 'thermal expectation', '<O> = Tr(O exp(-beta H))/Z', 'O,Z,beta,H', 'equilibrium expectation value'),
(12, 'time evolution', '|psi(t)> = exp(-iHt/hbar)|psi(0)>', 'psi,H,hbar,t', 'closed quantum many-body dynamics');

INSERT INTO model_metadata VALUES
(1, 'hilbert_space_growth', 'complexity scaling', 'dimension d^N', 'does not include symmetry reduction'),
(2, 'occupation_statistics', 'quantum statistics', 'f(E) and n(E)', 'ideal gas expression'),
(3, 'exact_diagonalization_spin_chain', 'finite spectra', 'eigenvalues', 'limited by exponential scaling'),
(4, 'correlation_function_scaffold', 'connected correlations', 'C_ij', 'teaching scaffold not full measured correlation'),
(5, 'entanglement_entropy_scaffold', 'subsystem entanglement', 'S_A', 'small state-vector example only'),
(6, 'structure_factor_scaffold', 'momentum-space correlations', 'S(q)', 'idealized correlation input'),
(7, 'sql_metadata', 'reproducibility', 'models phases and sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Modern Quantum Many-body Physics', 'MIT OpenCourseWare', 'graduate course on quantum effects and interacting many-body systems in solids', 'https://ocw.mit.edu/courses/8-513-modern-quantum-many-body-physics-for-condensed-matter-systems-fall-2021/'),
(2, 'MIT Modern Quantum Many-body Lecture Notes', 'MIT OpenCourseWare', 'lecture notes covering semiclassical approach interacting bosons SPT order and topological order', 'https://ocw.mit.edu/courses/8-513-modern-quantum-many-body-physics-for-condensed-matter-systems-fall-2021/pages/lecture-notes/'),
(3, 'MIT Strongly Correlated Systems', 'MIT OpenCourseWare', 'course on quantum statistics interactions correlations second quantization Green functions and path integrals', 'https://ocw.mit.edu/courses/8-514-strongly-correlated-systems-in-condensed-matter-physics-fall-2003/'),
(4, 'MIT Many-Body Theory', 'MIT OpenCourseWare', 'course on many-body theory for condensed matter systems', 'https://ocw.mit.edu/courses/8-513-many-body-theory-for-condensed-matter-systems-fall-2004/'),
(5, 'Anderson More Is Different', 'Science', 'classic emergence article in physics', 'https://www.science.org/doi/10.1126/science.177.4047.393'),
(6, 'NIST Quantum Many-Body Physics', 'NIST', 'quantum many-body physics quantum optics and quantum information program', 'https://www.nist.gov/programs-projects/quantum-many-body-physics-quantum-optics-and-quantum-information'),
(7, 'Nobel Physics 2003', 'Nobel Prize', 'superconductivity and superfluidity', 'https://www.nobelprize.org/prizes/physics/2003/summary/'),
(8, 'Nobel Physics 2016', 'Nobel Prize', 'topological phase transitions and topological phases of matter', 'https://www.nobelprize.org/prizes/physics/2016/press-release/');

INSERT INTO model_assumptions VALUES
(1, 'hilbert_space_growth', 'Computes raw Hilbert dimensions without symmetry-sector reductions.'),
(2, 'occupation_statistics', 'Uses ideal Bose and Fermi occupation functions.'),
(3, 'exact_diagonalization_spin_chain', 'Uses dense matrices and periodic boundary conditions for small transverse-field Ising chains.'),
(4, 'correlation_function_scaffold', 'Uses toy classical configurations rather than quantum expectation values.'),
(5, 'entanglement_entropy_scaffold', 'Uses small pure-state examples and bipartite singular-value decomposition.'),
(6, 'structure_factor_scaffold', 'Uses toy spin configurations to demonstrate structure-factor logic.'),
(7, 'many_body_physics_schema', 'Stores educational metadata rather than a production many-body database.');

INSERT INTO simulation_runs VALUES
(1, 'many-body-physics-and-emergent-collective-behavior', 'hilbert_space_growth', 'closed_form_scaling', 'local dimensions and site ranges', 'Hilbert-space dimension and memory table', '2026-04-25'),
(2, 'many-body-physics-and-emergent-collective-behavior', 'occupation_statistics', 'distribution_grid', 'temperature energy and chemical potential cases', 'Bose and Fermi occupation tables', '2026-04-25'),
(3, 'many-body-physics-and-emergent-collective-behavior', 'exact_diagonalization_spin_chain', 'dense_matrix_diagonalization', 'small transverse-field Ising cases', 'finite-system spectra', '2026-04-25'),
(4, 'many-body-physics-and-emergent-collective-behavior', 'correlation_function_scaffold', 'toy_configuration_average', 'ferromagnetic antiferromagnetic and domain wall configurations', 'connected correlation table', '2026-04-25'),
(5, 'many-body-physics-and-emergent-collective-behavior', 'entanglement_entropy_scaffold', 'svd_schmidt_decomposition', 'product and GHZ states', 'bipartite entanglement entropy table', '2026-04-25'),
(6, 'many-body-physics-and-emergent-collective-behavior', 'structure_factor_scaffold', 'discrete_fourier_sum', 'toy spin configurations', 'structure factor table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

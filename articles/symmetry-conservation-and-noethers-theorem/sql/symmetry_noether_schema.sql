-- Symmetry, Conservation, and Noether's Theorem Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores symmetries, conserved quantities, mechanics systems,
-- field symmetries, quantum generators, physical relations,
-- model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS symmetry_conservation_cases;
DROP TABLE IF EXISTS mechanics_system_cases;
DROP TABLE IF EXISTS field_symmetry_cases;
DROP TABLE IF EXISTS quantum_generator_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE symmetry_conservation_cases (
    case_id TEXT PRIMARY KEY,
    symmetry TEXT NOT NULL,
    transformation_example TEXT NOT NULL,
    associated_quantity TEXT NOT NULL,
    theorem_context TEXT NOT NULL,
    physical_interpretation TEXT NOT NULL
);

CREATE TABLE mechanics_system_cases (
    case_id TEXT PRIMARY KEY,
    system TEXT NOT NULL,
    lagrangian_description TEXT NOT NULL,
    symmetry TEXT NOT NULL,
    expected_conserved_quantity TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE field_symmetry_cases (
    case_id TEXT PRIMARY KEY,
    field_type TEXT NOT NULL,
    symmetry TEXT NOT NULL,
    current_or_identity TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE quantum_generator_cases (
    case_id TEXT PRIMARY KEY,
    transformation TEXT NOT NULL,
    generator TEXT NOT NULL,
    operator_expression TEXT NOT NULL,
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

INSERT INTO symmetry_conservation_cases VALUES
('time_translation', 'time translation', 't -> t + epsilon', 'energy', 'Noether first theorem', 'laws do not depend on absolute time'),
('space_translation', 'space translation', 'x -> x + epsilon', 'linear momentum', 'Noether first theorem', 'laws do not depend on absolute position'),
('rotation', 'rotation', 'r -> R(theta) r', 'angular momentum', 'Noether first theorem', 'laws do not depend on absolute orientation'),
('lorentz_invariance', 'Lorentz transformation', 'x_mu -> Lambda_mu_nu x_nu', 'energy-momentum tensor and relativistic invariants', 'Noether first theorem', 'spacetime symmetry of special relativity'),
('global_phase_u1', 'global U(1) phase', 'psi -> exp(i alpha) psi', 'charge or particle number', 'Noether first theorem', 'phase invariance gives conserved current'),
('internal_su2', 'internal SU(2)', 'field multiplet transforms under SU(2)', 'isospin-like charges', 'Noether first theorem', 'internal symmetry organizes fields and multiplets'),
('gauge_redundancy', 'local gauge transformation', 'A_mu -> A_mu + partial_mu Lambda', 'constraints and Noether identities', 'Noether second theorem', 'local redundancy gives identities among equations');

INSERT INTO mechanics_system_cases VALUES
('free_particle', 'free particle', 'L = 1/2 m v^2', 'time and space translation', 'energy and momentum', 'homogeneous space and time'),
('harmonic_oscillator', 'one-dimensional harmonic oscillator', 'L = 1/2 m qdot^2 - 1/2 k q^2', 'time translation', 'energy', 'explicitly time-independent Lagrangian'),
('central_force', 'central inverse-square force', 'L = 1/2 m rdot^2 - V(r)', 'rotation', 'angular momentum', 'central potential is rotationally invariant'),
('uniform_gravity', 'particle in constant gravitational field', 'L = 1/2 m v^2 - m g z', 'horizontal translation', 'horizontal momentum', 'vertical translation broken by potential'),
('time_driven_oscillator', 'driven oscillator', 'L has explicit time-dependent force', 'time translation broken', 'energy not conserved', 'external drive supplies or removes energy');

INSERT INTO field_symmetry_cases VALUES
('real_scalar_translation', 'real scalar field', 'spacetime translation', 'stress-energy tensor', 'translation invariance gives energy-momentum current'),
('complex_scalar_u1', 'complex scalar field', 'global U(1)', 'phase current', 'global phase invariance gives conserved charge'),
('dirac_u1', 'Dirac field', 'global U(1)', 'Dirac current', 'charge conservation in relativistic quantum field theory'),
('electromagnetic_gauge', 'electromagnetic field', 'local U(1) gauge', 'Noether identity and constraint', 'gauge redundancy rather than ordinary global charge'),
('yang_mills_gauge', 'non-Abelian gauge field', 'local gauge symmetry', 'Noether identities and constraints', 'structure of Standard Model interactions');

INSERT INTO quantum_generator_cases VALUES
('time_translation', 'time evolution', 'Hamiltonian', 'U(t)=exp(-i H t / hbar)', 'Hamiltonian generates time translation'),
('space_translation', 'spatial shift', 'momentum', 'U(a)=exp(-i a p / hbar)', 'momentum generates spatial translation'),
('rotation', 'rotation', 'angular momentum', 'U(theta)=exp(-i theta J / hbar)', 'angular momentum generates rotations'),
('phase_rotation', 'global phase', 'number or charge', 'U(alpha)=exp(-i alpha N)', 'number or charge generates phase transformation depending on convention'),
('spin_rotation', 'spin rotation', 'spin operator', 'U(theta)=exp(-i theta S / hbar)', 'spin transforms under rotation group representations');

INSERT INTO physical_relations VALUES
(1, 'action', 'S = integral L dt', 'S,L,t', 'action functional for classical mechanics'),
(2, 'Euler-Lagrange equation', 'd/dt(partial L/partial qdot_i) - partial L/partial q_i = 0', 'L,q_i,qdot_i,t', 'equation of motion from stationary action'),
(3, 'canonical momentum', 'p_i = partial L/partial qdot_i', 'p_i,L,qdot_i', 'momentum conjugate to generalized coordinate'),
(4, 'Hamiltonian', 'H = sum_i p_i qdot_i - L', 'H,p_i,qdot_i,L', 'generator of time evolution in Hamiltonian mechanics'),
(5, 'Noether charge', 'Q = sum_i p_i eta_i - H tau - F', 'Q,p_i,eta_i,H,tau,F', 'conserved quantity from variational symmetry'),
(6, 'charge conservation', 'dQ/dt = 0', 'Q,t', 'global conservation law'),
(7, 'field current', 'j^mu = sum_a partial L/partial(partial_mu phi_a) Delta phi_a - K^mu', 'j_mu,L,phi_a,K_mu', 'Noether current in field theory'),
(8, 'current conservation', 'partial_mu j^mu = 0', 'j_mu', 'local conservation law'),
(9, 'angular momentum', 'L = r x p', 'L,r,p', 'conserved quantity associated with rotational symmetry'),
(10, 'quantum generator', 'U(epsilon)=exp(-i epsilon G/hbar)', 'U,epsilon,G,hbar', 'continuous quantum symmetry transformation');

INSERT INTO model_metadata VALUES
(1, 'symmetry_conservation_map', 'conceptual architecture', 'associated quantity', 'not a proof'),
(2, 'central_force_simulation', 'angular momentum diagnostic', 'Lz', 'numerical integration error remains'),
(3, 'harmonic_oscillator_energy', 'energy conservation diagnostic', 'H', 'ideal undamped oscillator only'),
(4, 'symbolic_noether_charge', 'simple symbolic derivation', 'Q', 'limited to simple Lagrangians'),
(5, 'field_theory_current', 'Noether current illustration', 'j_mu', 'not a full field-theory engine'),
(6, 'quantum_generators', 'operator-generator connection', 'commutators', 'finite-dimensional teaching matrices'),
(7, 'sql_metadata', 'reproducibility', 'relations and sources', 'requires disciplined data entry');

INSERT INTO source_notes VALUES
(1, 'Noether Invariant Variation Problems arXiv', 'arXiv', 'English translation of Noether invariant variation problems', 'https://arxiv.org/abs/physics/0503066'),
(2, 'Noether Bibliography', 'Celebratio Mathematica', 'bibliographic record for Noether 1918 paper', 'https://celebratio.org/Noether_E/article/109/'),
(3, 'MIT Classical Mechanics III', 'MIT OpenCourseWare', 'advanced classical mechanics and symmetry', 'https://ocw.mit.edu/courses/8-09-classical-mechanics-iii-fall-2014/'),
(4, 'MIT Classical Mechanics II Lecture 6', 'MIT OpenCourseWare', 'conservation of momentum and Noether theorem', 'https://ocw.mit.edu/courses/8-223-classical-mechanics-ii-january-iap-2017/resources/lecture-6-conservation-of-momentum-and/'),
(5, 'MIT Nuclear and Particle Physics Symmetries', 'MIT OpenCourseWare', 'symmetries and conservation laws in particle physics', 'https://ocw.mit.edu/courses/8-701-introduction-to-nuclear-and-particle-physics-fall-2020/'),
(6, 'MIT Relativistic QFT Symmetries', 'MIT Learn and MIT OpenCourseWare', 'symmetries and conservation laws in QFT', 'https://learn.mit.edu/c/department/physics?resource=6523'),
(7, 'Stanford SEP Symmetry Breaking', 'Stanford Encyclopedia of Philosophy', 'symmetry and symmetry breaking in physics', 'https://plato.stanford.edu/entries/symmetry-breaking/'),
(8, 'Stanford SEP Gauge Theories', 'Stanford Encyclopedia of Philosophy', 'gauge theories in physics', 'https://plato.stanford.edu/entries/gauge-theories/');

INSERT INTO model_assumptions VALUES
(1, 'central_force_angular_momentum', 'Uses an ideal inverse-square central force and velocity-Verlet integration.'),
(2, 'harmonic_oscillator_energy', 'Uses an ideal undamped time-independent harmonic oscillator.'),
(3, 'symbolic_noether_charge', 'Uses simple symbolic Lagrangians and does not implement full variational calculus.'),
(4, 'field_theory_current_example', 'Stores schematic field-current examples rather than deriving them from a symbolic field-theory engine.'),
(5, 'quantum_generators', 'Uses finite-dimensional spin-1/2 Pauli matrices as teaching examples.'),
(6, 'symmetry_noether_schema', 'Stores educational metadata rather than a production formal-physics database.');

INSERT INTO simulation_runs VALUES
(1, 'symmetry-conservation-and-noethers-theorem', 'central_force_angular_momentum', 'velocity_verlet', 'inverse-square central force', 'orbit and conservation diagnostics', '2026-04-25'),
(2, 'symmetry-conservation-and-noethers-theorem', 'harmonic_oscillator_energy', 'velocity_verlet', 'time-independent oscillator', 'energy conservation diagnostics', '2026-04-25'),
(3, 'symmetry-conservation-and-noethers-theorem', 'symbolic_noether_charge', 'symbolic_computation', 'simple oscillator and rotor Lagrangians', 'canonical momentum and Hamiltonian examples', '2026-04-25'),
(4, 'symmetry-conservation-and-noethers-theorem', 'field_theory_current_example', 'structured_metadata', 'global U(1) and spacetime translation examples', 'Noether current table', '2026-04-25'),
(5, 'symmetry-conservation-and-noethers-theorem', 'quantum_generators', 'matrix_diagnostics', 'spin-1/2 Pauli generators', 'generator and commutator diagnostics', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

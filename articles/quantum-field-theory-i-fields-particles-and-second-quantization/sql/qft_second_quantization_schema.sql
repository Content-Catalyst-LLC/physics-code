-- Quantum Field Theory I: Fields, Particles, and Second Quantization Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, Fock-mode cases, scalar-field mode cases,
-- propagator cases, operator algebra cases, field-theory cases,
-- physical relations, model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS qft_constants;
DROP TABLE IF EXISTS fock_mode_cases;
DROP TABLE IF EXISTS scalar_field_mode_cases;
DROP TABLE IF EXISTS propagator_cases;
DROP TABLE IF EXISTS operator_algebra_cases;
DROP TABLE IF EXISTS field_theory_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE qft_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE fock_mode_cases (
    case_id TEXT PRIMARY KEY,
    fock_dimension INTEGER NOT NULL,
    hbar REAL NOT NULL,
    omega REAL NOT NULL,
    notes TEXT
);

CREATE TABLE scalar_field_mode_cases (
    case_id TEXT PRIMARY KEY,
    mass_natural REAL NOT NULL,
    k_min REAL NOT NULL,
    k_max REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE propagator_cases (
    case_id TEXT PRIMARY KEY,
    mass_natural REAL NOT NULL,
    p2_min REAL NOT NULL,
    p2_max REAL NOT NULL,
    n_points INTEGER NOT NULL,
    epsilon REAL NOT NULL,
    notes TEXT
);

CREATE TABLE operator_algebra_cases (
    case_id TEXT PRIMARY KEY,
    operator_type TEXT NOT NULL,
    algebra_relation TEXT NOT NULL,
    statistics TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE field_theory_cases (
    case_id TEXT PRIMARY KEY,
    field_type TEXT NOT NULL,
    lagrangian_density TEXT NOT NULL,
    key_equation TEXT NOT NULL,
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

INSERT INTO qft_constants VALUES
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('speed_of_light', 299792458, 'm s^-1', 'exact SI value'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('electron_volt', 1.602176634e-19, 'J', 'exact SI conversion'),
('electron_mass_energy_ev', 510998.95, 'eV', 'electron rest energy approximate'),
('planck_constant', 6.62607015e-34, 'J s', 'exact SI value');

INSERT INTO fock_mode_cases VALUES
('small_truncation', 4, 1.0, 1.0, 'small Fock truncation for teaching'),
('article_example', 8, 1.0, 2.0, 'article body example'),
('larger_truncation', 16, 1.0, 0.5, 'larger Fock truncation for diagnostics'),
('high_frequency', 10, 1.0, 5.0, 'higher oscillator frequency');

INSERT INTO scalar_field_mode_cases VALUES
('massless_scalar', 0.0, 0.0, 5.0, 101, 'massless dispersion omega equals absolute k'),
('light_scalar', 0.5, 0.0, 5.0, 101, 'massive scalar educational case'),
('unit_mass_scalar', 1.0, 0.0, 5.0, 101, 'unit mass natural units'),
('heavy_scalar', 3.0, 0.0, 5.0, 101, 'heavier scalar mode dispersion');

INSERT INTO propagator_cases VALUES
('unit_mass_propagator', 1.0, -5.0, 5.0, 201, 0.01, 'simple scalar propagator grid'),
('light_mass_propagator', 0.5, -5.0, 5.0, 201, 0.01, 'light scalar propagator grid'),
('heavy_mass_propagator', 2.0, -5.0, 8.0, 261, 0.01, 'heavier scalar propagator grid');

INSERT INTO operator_algebra_cases VALUES
('bosonic_ladder', 'creation_annihilation', '[a a_dagger]=1', 'boson', 'harmonic oscillator ladder algebra'),
('bosonic_field', 'field_commutator', '[phi(x) pi(y)]=i hbar delta(x-y)', 'boson', 'canonical scalar field quantization'),
('fermionic_ladder', 'creation_annihilation', '{c c_dagger}=1', 'fermion', 'fermionic mode algebra'),
('fermionic_field', 'field_anticommutator', '{psi(x) psi_dagger(y)}=delta(x-y)', 'fermion', 'canonical fermionic field algebra'),
('number_operator', 'N=a_dagger a', 'N|n>=n|n>', 'boson', 'occupation-number operator');

INSERT INTO field_theory_cases VALUES
('real_scalar_free', 'real scalar', '1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2', '(Box + m^2) phi = 0', 'simplest free relativistic field'),
('complex_scalar_free', 'complex scalar', 'partial_mu phi_star partial^mu phi - m^2 phi_star phi', '(Box + m^2) phi = 0', 'global U(1) symmetry and charge'),
('phi_four', 'real scalar interacting', '1/2 partial phi partial phi - 1/2 m^2 phi^2 - lambda phi^4/4!', 'interacting Klein-Gordon equation', 'self-interacting scalar toy theory'),
('dirac_free', 'spinor', 'psi_bar(i gamma^mu partial_mu - m)psi', 'Dirac equation', 'relativistic spin one-half field'),
('electromagnetic_free', 'gauge field', '-1/4 F_mu_nu F^mu_nu', 'Maxwell equations', 'free gauge field');

INSERT INTO physical_relations VALUES
(1, 'harmonic oscillator Hamiltonian', 'H = hbar omega (a_dagger a + 1/2)', 'H,hbar,omega,a_dagger,a', 'single quantized oscillator mode'),
(2, 'bosonic commutator', '[a,a_dagger] = 1', 'a,a_dagger', 'canonical bosonic ladder algebra'),
(3, 'number operator', 'N = a_dagger a', 'N,a_dagger,a', 'counts occupation number'),
(4, 'ladder action lower', 'a|n> = sqrt(n)|n-1>', 'a,n', 'annihilation operator lowers occupation'),
(5, 'ladder action raise', 'a_dagger|n> = sqrt(n+1)|n+1>', 'a_dagger,n', 'creation operator raises occupation'),
(6, 'scalar field Lagrangian', 'L = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2', 'L,phi,m', 'free real scalar field dynamics'),
(7, 'Klein-Gordon equation', '(Box + m^2)phi = 0', 'Box,m,phi', 'free scalar field equation'),
(8, 'canonical field commutator', '[phi(x,t),pi(y,t)] = i hbar delta^3(x-y)', 'phi,pi,hbar,x,y', 'canonical quantization of scalar field'),
(9, 'scalar propagator', 'Delta_F(p) = i/(p^2 - m^2 + i epsilon)', 'Delta_F,p,m,epsilon', 'momentum-space Feynman propagator'),
(10, 'Bose occupation', 'n_bar = 1/(exp(beta hbar omega)-1)', 'n_bar,beta,hbar,omega', 'mean thermal occupation of bosonic mode'),
(11, 'fermionic anticommutator', '{c,c_dagger}=1', 'c,c_dagger', 'canonical fermionic mode algebra'),
(12, 'renormalization group equation', 'mu dg/dmu = beta(g)', 'mu,g,beta', 'scale dependence of coupling');

INSERT INTO model_metadata VALUES
(1, 'fock_ladder_operators', 'operator construction', 'a and a_dagger', 'truncation modifies exact commutator'),
(2, 'bose_mode_occupation', 'thermal mode population', 'n_bar', 'free bosonic mode assumption'),
(3, 'scalar_field_modes', 'free-field dispersion', 'omega_k', 'no interactions or curved spacetime'),
(4, 'propagator_grid', 'momentum-space propagator', 'Delta_F', 'pedagogical grid not contour integration'),
(5, 'fermionic_anticommutation', 'finite fermionic algebra', 'c and c_dagger', 'single-mode toy model'),
(6, 'wick_contraction_metadata', 'contraction bookkeeping', 'pairings', 'metadata not full symbolic theorem engine'),
(7, 'sql_metadata', 'reproducibility', 'relations and sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Relativistic Quantum Field Theory I', 'MIT OpenCourseWare', 'self-contained QFT course with particle and condensed matter applications', 'https://ocw.mit.edu/courses/8-323-relativistic-quantum-field-theory-i-spring-2023/'),
(2, 'MIT Why Quantum Field Theory', 'MIT OpenCourseWare', 'lecture on inadequacy of relativistic quantum mechanics and field theory', 'https://ocw.mit.edu/courses/8-323-relativistic-quantum-field-theory-i-spring-2023/resources/ocw_8323_lecture03_2023feb13_mp4/'),
(3, 'MIT Relativistic Quantum Field Theory II', 'MIT OpenCourseWare', 'second course in QFT sequence', 'https://ocw.mit.edu/courses/8-324-relativistic-quantum-field-theory-ii-fall-2010/'),
(4, 'Stanford Encyclopedia Quantum Field Theory', 'Stanford Encyclopedia of Philosophy', 'conceptual overview of QFT', 'https://plato.stanford.edu/entries/quantum-field-theory/'),
(5, 'David Tong QFT Lectures', 'University of Cambridge', 'graduate-level QFT lecture notes', 'https://www.damtp.cam.ac.uk/user/tong/qft.html'),
(6, 'Srednicki QFT', 'UCSB Physics', 'author page for graduate QFT textbook', 'https://web.physics.ucsb.edu/~mark/qft.html'),
(7, 'Peskin Schroeder CERN Record', 'CERN Document Server', 'bibliographic record for An Introduction to Quantum Field Theory', 'https://cds.cern.ch/record/257493'),
(8, 'Weinberg Quantum Theory of Fields', 'Open Library', 'bibliographic record for foundations volume', 'https://openlibrary.org/books/OL3398947W');

INSERT INTO model_assumptions VALUES
(1, 'fock_ladder_operators', 'Uses finite Fock-space truncation, which modifies exact infinite-dimensional commutators at the cutoff.'),
(2, 'scalar_field_modes', 'Uses free scalar dispersion in natural units.'),
(3, 'propagator_grid', 'Evaluates a simplified scalar propagator grid without performing contour integration.'),
(4, 'fermionic_anticommutation', 'Uses a single fermionic mode as a two-dimensional toy model.'),
(5, 'wick_contraction_metadata', 'Stores contraction-count metadata rather than implementing a symbolic Wick theorem engine.'),
(6, 'qft_second_quantization_schema', 'Stores educational metadata rather than a production QFT database.');

INSERT INTO simulation_runs VALUES
(1, 'quantum-field-theory-i-fields-particles-and-second-quantization', 'fock_ladder_operators', 'finite_matrix_operator_construction', 'sample Fock truncations', 'ladder diagnostics and truncation summary', '2026-04-25'),
(2, 'quantum-field-theory-i-fields-particles-and-second-quantization', 'scalar_field_modes', 'dispersion_grid', 'sample scalar field masses and k grid', 'omega_k and group velocity tables', '2026-04-25'),
(3, 'quantum-field-theory-i-fields-particles-and-second-quantization', 'propagator_grid', 'complex_grid_evaluation', 'sample p2 and mass grids', 'real imaginary and magnitude propagator values', '2026-04-25'),
(4, 'quantum-field-theory-i-fields-particles-and-second-quantization', 'fermionic_anticommutation', 'finite_matrix_algebra', 'single fermionic mode', 'anticommutation diagnostics', '2026-04-25'),
(5, 'quantum-field-theory-i-fields-particles-and-second-quantization', 'wick_contraction_metadata', 'combinatorial_metadata', 'even field counts 2 through 10', 'pairing-count table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

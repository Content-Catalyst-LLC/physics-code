-- Topological Matter and Quantum Phases Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS topology_constants;
DROP TABLE IF EXISTS ssh_parameter_cases;
DROP TABLE IF EXISTS chern_model_cases;
DROP TABLE IF EXISTS kitaev_chain_cases;
DROP TABLE IF EXISTS topological_phase_examples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE topology_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE ssh_parameter_cases (
    case_id TEXT PRIMARY KEY,
    t1 REAL NOT NULL,
    t2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE chern_model_cases (
    case_id TEXT PRIMARY KEY,
    mass REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE kitaev_chain_cases (
    case_id TEXT PRIMARY KEY,
    chemical_potential REAL NOT NULL,
    hopping REAL NOT NULL,
    pairing REAL NOT NULL,
    notes TEXT
);

CREATE TABLE topological_phase_examples (
    phase_or_model TEXT PRIMARY KEY,
    dimension TEXT NOT NULL,
    key_invariant TEXT NOT NULL,
    protecting_condition TEXT,
    signature TEXT
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

INSERT INTO topology_constants VALUES
('h', 6.62607015e-34, 'J s', 'Planck constant exact SI'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('electron_charge', 1.602176634e-19, 'C', 'elementary charge exact SI'),
('conductance_quantum_e2_over_h', 3.874045865e-5, 'S', 'e squared divided by h'),
('flux_quantum_h_over_e', 4.135667696e-15, 'Wb', 'h divided by e'),
('superconducting_flux_quantum_h_over_2e', 2.067833848e-15, 'Wb', 'h divided by 2e');

INSERT INTO physical_relations VALUES
(1, 'Berry connection', 'A_n(k) = i <u_n(k)|grad_k u_n(k)>', 'A,u,k', 'geometric gauge potential in momentum space'),
(2, 'Berry curvature', 'Omega_n(k) = partial_kx A_y - partial_ky A_x', 'Omega,A,k', 'curvature associated with Berry connection'),
(3, 'Chern number', 'C = (1/2pi) integral_BZ Omega(k) d^2k', 'C,Omega,k', 'integer topological invariant'),
(4, 'Hall conductance', 'sigma_xy = C e^2/h', 'sigma_xy,C,e,h', 'quantized Hall response'),
(5, 'two-band Hamiltonian', 'H(k) = d(k) dot sigma', 'H,d,sigma', 'minimal two-band topology scaffold'),
(6, 'two-band Chern number', 'C = (1/4pi) integral d_hat dot (partial_kx d_hat cross partial_ky d_hat) d^2k', 'C,d_hat,k', 'mapping degree from Brillouin zone to Bloch sphere'),
(7, 'SSH q function', 'q(k) = t1 + t2 exp(-ik)', 'q,t1,t2,k', 'off-diagonal SSH model function'),
(8, 'SSH winding number', 'nu = (1/2pi i) integral dk d/dk log q(k)', 'nu,q,k', 'one-dimensional winding invariant'),
(9, 'Majorana condition', 'gamma dagger = gamma', 'gamma', 'self-adjoint Majorana quasiparticle operator'),
(10, 'Kitaev chain topological condition', '|mu| < 2|t|', 'mu,t', 'idealized topological regime for simple Kitaev chain');

INSERT INTO source_notes VALUES
(1, 'MIT Quantum Physics III Berry Phase', 'MIT OpenCourseWare', 'Berry phase and Berry connection teaching material', 'https://ocw.mit.edu/courses/8-06-quantum-physics-iii-spring-2018/resources/l17-2/'),
(2, 'MIT Modern Quantum Many-Body Physics', 'MIT OpenCourseWare', 'graduate course covering topological phases of matter', 'https://ocw.mit.edu/courses/8-513-modern-quantum-many-body-physics-for-condensed-matter-systems-fall-2021/'),
(3, 'Nobel Physics 1985', 'Nobel Prize', 'integer quantum Hall effect', 'https://www.nobelprize.org/prizes/physics/1985/summary/'),
(4, 'Nobel Physics 1998', 'Nobel Prize', 'fractional quantum Hall effect and fractional excitations', 'https://www.nobelprize.org/prizes/physics/1998/summary/'),
(5, 'Nobel Physics 2016', 'Nobel Prize', 'topological phase transitions and topological phases of matter', 'https://www.nobelprize.org/prizes/physics/2016/press-release/'),
(6, 'Hasan Kane RMP', 'American Physical Society', 'review of topological insulators', 'https://link.aps.org/doi/10.1103/RevModPhys.82.3045'),
(7, 'Qi Zhang RMP', 'American Physical Society', 'review of topological insulators and superconductors', 'https://link.aps.org/doi/10.1103/RevModPhys.83.1057'),
(8, 'Kane Mele PRL', 'American Physical Society', 'Z2 topological order and quantum spin Hall effect', 'https://link.aps.org/doi/10.1103/PhysRevLett.95.146802');

INSERT INTO model_assumptions VALUES
(1, 'ssh_winding_number', 'Uses a clean noninteracting SSH chain with chiral symmetry.'),
(2, 'two_band_chern_model', 'Uses finite differences on a periodic Brillouin-zone grid.'),
(3, 'berry_curvature_grid', 'Uses d-hat vector curvature scaffold rather than eigenvector gauge smoothing.'),
(4, 'wilson_loop_scaffold', 'Uses SSH phase winding as a Wilson-loop-like teaching proxy.'),
(5, 'kitaev_chain_diagnostics', 'Uses idealized |mu| < 2|t| topological criterion.'),
(6, 'edge_state_toy_model', 'Stores expected boundary signatures without full diagonalization.');

INSERT INTO simulation_runs VALUES
(1, 'topological-matter-and-quantum-phases', 'ssh_winding_number', 'phase_unwrapping', 'SSH t1 and t2 cases', 'winding number table', '2026-04-25'),
(2, 'topological-matter-and-quantum-phases', 'two_band_chern_model', 'finite_difference_grid', 'two-band mass cases', 'Chern number estimates', '2026-04-25'),
(3, 'topological-matter-and-quantum-phases', 'berry_curvature_grid', 'finite_difference_grid', 'representative mass values', 'Berry-density table', '2026-04-25'),
(4, 'topological-matter-and-quantum-phases', 'wilson_loop_scaffold', 'phase_winding_proxy', 'SSH cases', 'Berry phase proxy table', '2026-04-25'),
(5, 'topological-matter-and-quantum-phases', 'kitaev_chain_diagnostics', 'closed_form_classification', 'Kitaev chain cases', 'phase-label table', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

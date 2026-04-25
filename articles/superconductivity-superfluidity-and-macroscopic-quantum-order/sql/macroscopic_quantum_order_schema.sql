-- Superconductivity, Superfluidity, and Macroscopic Quantum Order Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS gl_parameter_cases;
DROP TABLE IF EXISTS josephson_cases;
DROP TABLE IF EXISTS flux_loop_cases;
DROP TABLE IF EXISTS vortex_cases;
DROP TABLE IF EXISTS bcs_gap_cases;
DROP TABLE IF EXISTS material_examples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE gl_parameter_cases (
    case_id TEXT PRIMARY KEY,
    critical_temperature_k REAL NOT NULL,
    alpha_0 REAL NOT NULL,
    beta REAL NOT NULL,
    temperature_min_k REAL NOT NULL,
    temperature_max_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE josephson_cases (
    case_id TEXT PRIMARY KEY,
    i_bias REAL NOT NULL,
    time_step REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    initial_phase REAL NOT NULL,
    notes TEXT
);

CREATE TABLE flux_loop_cases (
    case_id TEXT PRIMARY KEY,
    n_min INTEGER NOT NULL,
    n_max INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE vortex_cases (
    case_id TEXT PRIMARY KEY,
    winding_number INTEGER NOT NULL,
    grid_size INTEGER NOT NULL,
    domain_min REAL NOT NULL,
    domain_max REAL NOT NULL,
    notes TEXT
);

CREATE TABLE bcs_gap_cases (
    case_id TEXT PRIMARY KEY,
    critical_temperature_k REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE material_examples (
    system TEXT PRIMARY KEY,
    order_type TEXT NOT NULL,
    key_feature TEXT NOT NULL,
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

INSERT INTO constants VALUES
('h', 6.62607015e-34, 'J s', 'Planck constant exact SI'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('electron_charge', 1.602176634e-19, 'C', 'elementary charge exact SI'),
('cooper_pair_charge', 3.204353268e-19, 'C', '2e Cooper pair charge magnitude'),
('mu0', 1.25663706212e-6, 'N A^-2', 'magnetic permeability of vacuum approximate'),
('flux_quantum', 2.067833848e-15, 'Wb', 'h divided by 2e'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI');

INSERT INTO physical_relations VALUES
(1, 'order parameter', 'Psi = |Psi| exp(i theta)', 'Psi,theta', 'complex macroscopic condensate wavefunction'),
(2, 'GL free energy density', 'f = alpha |Psi|^2 + beta/2 |Psi|^4', 'f,alpha,beta,Psi', 'uniform order-parameter free energy'),
(3, 'equilibrium amplitude', '|Psi0|^2 = -alpha/beta', 'Psi0,alpha,beta', 'ordered-state amplitude below Tc'),
(4, 'London penetration depth', 'lambda_L = sqrt(m*/(mu0 n_s q^2))', 'lambda_L,m,n_s,q', 'magnetic-field screening length'),
(5, 'coherence length', 'xi = sqrt(hbar^2/(2m*|alpha|))', 'xi,hbar,m,alpha', 'order-parameter variation length'),
(6, 'GL parameter', 'kappa = lambda/xi', 'kappa,lambda,xi', 'type-I versus type-II classification'),
(7, 'flux quantum', 'Phi0 = h/(2e)', 'Phi0,h,e', 'superconducting magnetic flux quantum'),
(8, 'Josephson current', 'I = I_c sin(phi)', 'I,I_c,phi', 'phase-dependent tunneling current'),
(9, 'Josephson phase voltage', 'dphi/dt = 2eV/hbar', 'phi,e,V,hbar', 'phase evolution under voltage'),
(10, 'superfluid velocity', 'v_s = (hbar/m) grad theta', 'v_s,hbar,m,theta', 'phase-gradient flow relation'),
(11, 'quantized circulation', 'Integral v_s dot dl = n h/m', 'v_s,n,h,m', 'circulation quantization'),
(12, 'Landau critical velocity', 'v_c = min E(p)/p', 'v_c,E,p', 'excitation stability threshold');

INSERT INTO source_notes VALUES
(1, 'MIT Applied Superconductivity', 'MIT OpenCourseWare', 'superconductivity lecture sequence', 'https://ocw.mit.edu/courses/6-763-applied-superconductivity-fall-2005/'),
(2, 'MIT Theory of Solids II Superconductor Diamagnetism', 'MIT OpenCourseWare', 'BCS superconductor diamagnetism lecture', 'https://ocw.mit.edu/courses/8-512-theory-of-solids-ii-spring-2009/resources/mit8_512s09_lec09/'),
(3, 'Nobel Physics 1972', 'Nobel Prize', 'BCS theory of superconductivity', 'https://www.nobelprize.org/prizes/physics/1972/summary/'),
(4, 'Nobel Physics 1996', 'Nobel Prize', 'superfluidity in helium-3', 'https://www.nobelprize.org/prizes/physics/1996/advanced-information/'),
(5, 'Nobel Physics 2001', 'Nobel Prize', 'Bose-Einstein condensation in dilute gases', 'https://www.nobelprize.org/prizes/physics/2001/summary/'),
(6, 'Nobel Physics 2003', 'Nobel Prize', 'superfluids superconductors and broken symmetry', 'https://www.nobelprize.org/uploads/2018/06/advanced-physicsprize2003-1.pdf');

INSERT INTO model_assumptions VALUES
(1, 'ginzburg_landau_free_energy', 'Uses simplified uniform Ginzburg-Landau free-energy density.'),
(2, 'josephson_dynamics', 'Uses overdamped dimensionless Josephson phase dynamics.'),
(3, 'flux_quantization', 'Uses ideal Cooper-pair flux quantum h divided by 2e.'),
(4, 'superfluid_vortex_phase', 'Models phase winding without solving full amplitude dynamics.'),
(5, 'bcs_gap_scaffold', 'Uses approximate weak-coupling gap-temperature formula.');

INSERT INTO simulation_runs VALUES
(1, 'superconductivity-superfluidity-and-macroscopic-quantum-order', 'ginzburg_landau_free_energy', 'parameter_sweep', 'GL cases and temperature grid', 'equilibrium amplitude tables', '2026-04-25'),
(2, 'superconductivity-superfluidity-and-macroscopic-quantum-order', 'josephson_dynamics', 'explicit_euler', 'dimensionless current bias cases', 'phase velocity and current summaries', '2026-04-25'),
(3, 'superconductivity-superfluidity-and-macroscopic-quantum-order', 'flux_quantization', 'closed_form', 'integer loop states', 'flux quantum table', '2026-04-25'),
(4, 'superconductivity-superfluidity-and-macroscopic-quantum-order', 'superfluid_vortex_phase', 'grid_generation', 'vortex winding cases', 'phase-field table', '2026-04-25'),
(5, 'superconductivity-superfluidity-and-macroscopic-quantum-order', 'bcs_gap_scaffold', 'closed_form_approximation', 'Tc cases', 'gap-temperature table', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

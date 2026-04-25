-- Quantum Information, Decoherence, and Measurement Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores qubit state cases, decoherence parameters, measurement bases,
-- quantum channel metadata, error-correction cases, physical relations,
-- source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS qubit_state_cases;
DROP TABLE IF EXISTS decoherence_parameter_cases;
DROP TABLE IF EXISTS measurement_basis_cases;
DROP TABLE IF EXISTS channel_catalog;
DROP TABLE IF EXISTS error_correction_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE qubit_state_cases (
    case_id TEXT PRIMARY KEY,
    alpha_real REAL NOT NULL,
    alpha_imag REAL NOT NULL,
    beta_real REAL NOT NULL,
    beta_imag REAL NOT NULL,
    notes TEXT
);

CREATE TABLE decoherence_parameter_cases (
    case_id TEXT PRIMARY KEY,
    t2_seconds REAL NOT NULL,
    t1_seconds REAL NOT NULL,
    time_end_seconds REAL NOT NULL,
    n_time_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE measurement_basis_cases (
    case_id TEXT PRIMARY KEY,
    basis_name TEXT NOT NULL,
    projector_label TEXT NOT NULL,
    projector_matrix_flat TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE channel_catalog (
    channel_name TEXT PRIMARY KEY,
    primary_effect TEXT NOT NULL,
    key_parameter TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE error_correction_cases (
    case_id TEXT PRIMARY KEY,
    error_pattern TEXT NOT NULL,
    physical_state TEXT NOT NULL,
    expected_syndrome TEXT NOT NULL,
    correction TEXT NOT NULL,
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

INSERT INTO qubit_state_cases VALUES
('zero_state', 1.0, 0.0, 0.0, 0.0, 'computational basis zero'),
('one_state', 0.0, 0.0, 1.0, 0.0, 'computational basis one'),
('plus_state', 0.7071067812, 0.0, 0.7071067812, 0.0, 'equal real superposition'),
('minus_state', 0.7071067812, 0.0, -0.7071067812, 0.0, 'equal superposition with relative phase pi'),
('plus_i_state', 0.7071067812, 0.0, 0.0, 0.7071067812, 'equal superposition with relative phase pi over 2'),
('biased_state', 0.8660254038, 0.0, 0.5, 0.0, 'biased real superposition');

INSERT INTO decoherence_parameter_cases VALUES
('fast_dephasing', 2.0e-6, 20.0e-6, 20.0e-6, 101, 'short coherence time'),
('baseline_dephasing', 5.0e-6, 50.0e-6, 25.0e-6, 101, 'article dephasing baseline'),
('slow_dephasing', 20.0e-6, 100.0e-6, 50.0e-6, 101, 'longer coherence time'),
('fast_relaxation', 5.0e-6, 10.0e-6, 40.0e-6, 101, 'short relaxation time');

INSERT INTO measurement_basis_cases VALUES
('z_basis_zero', 'Z', '0', '1,0,0,0', 'projector onto |0>'),
('z_basis_one', 'Z', '1', '0,0,0,1', 'projector onto |1>'),
('x_basis_plus', 'X', '+', '0.5,0.5,0.5,0.5', 'projector onto |+>'),
('x_basis_minus', 'X', '-', '0.5,-0.5,-0.5,0.5', 'projector onto |->');

INSERT INTO channel_catalog VALUES
('pure_dephasing', 'decays off-diagonal coherence', 'T2', 'populations fixed in selected basis'),
('amplitude_damping', 'relaxation from excited to ground state', 'T1', 'models energy loss'),
('depolarizing', 'mixes state with maximally mixed state', 'p', 'symmetric qubit noise'),
('phase_flip', 'random Pauli Z error', 'p', 'discrete dephasing-like error'),
('bit_flip', 'random Pauli X error', 'p', 'classical-like qubit flip'),
('measurement', 'projects or partially measures state', 'basis', 'information extraction and disturbance');

INSERT INTO error_correction_cases VALUES
('no_error', '000', '000', '00', 'none', 'encoded zero with no error'),
('flip_qubit_1', '100', '100', '11', 'X1', 'first qubit bit flip'),
('flip_qubit_2', '010', '010', '10', 'X2', 'second qubit bit flip'),
('flip_qubit_3', '001', '001', '01', 'X3', 'third qubit bit flip'),
('logical_error', '111', '111', '00', 'none', 'three flips look like logical change in toy model');

INSERT INTO physical_relations VALUES
(1, 'qubit state', '|psi> = alpha|0> + beta|1>', 'psi,alpha,beta', 'pure single-qubit state'),
(2, 'normalization', '|alpha|^2 + |beta|^2 = 1', 'alpha,beta', 'state normalization condition'),
(3, 'density matrix pure state', 'rho = |psi><psi|', 'rho,psi', 'density matrix for pure state'),
(4, 'mixed state density matrix', 'rho = sum_i p_i |psi_i><psi_i|', 'rho,p_i,psi_i', 'statistical quantum mixture'),
(5, 'unitary evolution', 'rho_prime = U rho U_dagger', 'rho,U', 'closed-system quantum evolution'),
(6, 'Born rule', 'p_i = Tr(P_i rho)', 'p_i,P_i,rho', 'measurement outcome probability'),
(7, 'quantum channel', 'E(rho) = sum_i K_i rho K_i_dagger', 'E,rho,K_i', 'Kraus representation of open-system map'),
(8, 'trace preservation', 'sum_i K_i_dagger K_i = I', 'K_i,I', 'condition for trace-preserving channel'),
(9, 'pure dephasing', 'rho_01(t) = rho_01(0) exp(-t/T2)', 'rho_01,t,T2', 'coherence decay'),
(10, 'relaxation', 'P_e(t) = P_e(0) exp(-t/T1)', 'P_e,t,T1', 'excited-state population decay'),
(11, 'von Neumann entropy', 'S(rho) = -Tr(rho log2 rho)', 'S,rho', 'quantum entropy in bits'),
(12, 'reduced density matrix', 'rho_A = Tr_B(rho_AB)', 'rho_A,rho_AB', 'subsystem state after tracing environment or partner system');

INSERT INTO model_metadata VALUES
(1, 'state_vector', 'pure qubit representation', 'amplitudes', 'does not represent mixed states'),
(2, 'density_matrix', 'mixed states and open systems', 'rho', 'scales exponentially with qubit number'),
(3, 'projective_measurement', 'ideal measurement probabilities', 'projectors', 'idealization of real apparatus'),
(4, 'pure_dephasing', 'coherence loss', 'T2', 'simplified environment model'),
(5, 'amplitude_damping', 'energy relaxation', 'T1', 'simplified zero-temperature relaxation'),
(6, 'bell_state_entanglement', 'entanglement demonstration', 'subsystem entropy', 'small two-qubit example'),
(7, 'bit_flip_code', 'error-correction concept', 'syndrome', 'protects only bit flips in toy form');

INSERT INTO source_notes VALUES
(1, 'MIT Quantum Information Science', 'MIT OpenCourseWare', 'advanced quantum computation and information', 'https://ocw.mit.edu/courses/mas-865j-quantum-information-science-spring-2006/'),
(2, 'MIT Quantum Information Science I', 'MIT OpenCourseWare', 'introduction to theory and practice of quantum computation', 'https://ocw.mit.edu/courses/8-370x-quantum-information-science-i-spring-2018/'),
(3, 'MIT Quantum Physics III Decoherence', 'MIT OpenCourseWare', 'entanglement density matrices and decoherence', 'https://ocw.mit.edu/courses/8-06-quantum-physics-iii-spring-2016/resources/mit8_06s16_chap3/'),
(4, 'NIST Quantum Computing Explained', 'NIST', 'public explanation of quantum computing and error-prone devices', 'https://www.nist.gov/quantum-information-science/quantum-computing-explained'),
(5, 'NIST Quantum Information Science', 'NIST', 'standards and measurement role in quantum information science', 'https://www.nist.gov/quantum-information-science'),
(6, 'Stanford Decoherence Entry', 'Stanford Encyclopedia of Philosophy', 'decoherence and measurement problem', 'https://plato.stanford.edu/entries/qm-decoherence/'),
(7, 'Stanford Entanglement Entry', 'Stanford Encyclopedia of Philosophy', 'entanglement and information', 'https://plato.stanford.edu/entries/qt-entangle/'),
(8, 'Preskill Quantum Information Notes', 'Caltech', 'quantum computation and information lecture notes', 'https://www.preskill.caltech.edu/ph229/');

INSERT INTO model_assumptions VALUES
(1, 'density_matrix_dephasing', 'Uses an ideal pure dephasing model for an initial plus state.'),
(2, 'bloch_vector_diagnostics', 'Uses single-qubit pure states and Pauli expectation values.'),
(3, 'measurement_born_rule', 'Uses ideal projective measurements in Z and X bases.'),
(4, 'bell_state_entanglement_entropy', 'Uses the Bell state Phi plus and traces out one qubit.'),
(5, 'amplitude_damping_channel', 'Uses zero-temperature amplitude damping with a single gamma parameter.'),
(6, 'three_qubit_bit_flip_code', 'Uses classical syndrome logic for a toy bit-flip code and does not protect against arbitrary quantum errors.');

INSERT INTO simulation_runs VALUES
(1, 'quantum-information-decoherence-and-measurement', 'density_matrix_dephasing', 'closed_form_dephasing', 'plus state T2 baseline', 'coherence purity and entropy diagnostics', '2026-04-25'),
(2, 'quantum-information-decoherence-and-measurement', 'bloch_vector_diagnostics', 'state_vector_to_density_matrix', 'sample qubit states', 'Bloch vector and purity diagnostics', '2026-04-25'),
(3, 'quantum-information-decoherence-and-measurement', 'measurement_born_rule', 'projective_measurement_probabilities', 'sample states and Z X basis projectors', 'Born-rule probability table', '2026-04-25'),
(4, 'quantum-information-decoherence-and-measurement', 'bell_state_entanglement_entropy', 'partial_trace', 'Phi plus Bell state', 'reduced state and entropy table', '2026-04-25'),
(5, 'quantum-information-decoherence-and-measurement', 'amplitude_damping_channel', 'Kraus_channel_sweep', 'excited state gamma sweep', 'population purity and coherence diagnostics', '2026-04-25'),
(6, 'quantum-information-decoherence-and-measurement', 'three_qubit_bit_flip_code', 'syndrome_logic', 'toy three-qubit bit-flip cases', 'syndrome and correction table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

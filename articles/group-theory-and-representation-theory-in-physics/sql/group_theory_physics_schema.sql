-- Group Theory and Representation Theory in Physics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, finite groups, character tables, reducible characters,
-- angular-momentum cases, Lie-algebra cases, point-group examples,
-- physical relations, model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS group_theory_constants;
DROP TABLE IF EXISTS finite_group_cases;
DROP TABLE IF EXISTS c3_character_table;
DROP TABLE IF EXISTS reducible_character_cases;
DROP TABLE IF EXISTS angular_momentum_cases;
DROP TABLE IF EXISTS lie_algebra_cases;
DROP TABLE IF EXISTS point_group_examples;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE group_theory_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE finite_group_cases (
    group_id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL,
    order_value INTEGER NOT NULL,
    abelian INTEGER NOT NULL,
    generators TEXT NOT NULL,
    relations TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE c3_character_table (
    irrep TEXT PRIMARY KEY,
    e TEXT NOT NULL,
    r TEXT NOT NULL,
    r2 TEXT NOT NULL,
    dimension INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE reducible_character_cases (
    case_id TEXT PRIMARY KEY,
    group_id TEXT NOT NULL,
    chi_e REAL NOT NULL,
    chi_r REAL NOT NULL,
    chi_r2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE angular_momentum_cases (
    case_id TEXT PRIMARY KEY,
    j REAL NOT NULL,
    hbar_convention REAL NOT NULL,
    notes TEXT
);

CREATE TABLE lie_algebra_cases (
    algebra_id TEXT NOT NULL,
    generator_a TEXT NOT NULL,
    generator_b TEXT NOT NULL,
    commutator_result TEXT NOT NULL,
    structure_constant_notes TEXT,
    PRIMARY KEY (algebra_id, generator_a, generator_b)
);

CREATE TABLE point_group_examples (
    point_group TEXT PRIMARY KEY,
    order_value INTEGER NOT NULL,
    example_systems TEXT,
    common_physics_uses TEXT,
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

INSERT INTO group_theory_constants VALUES
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('hbar_natural', 1, 'dimensionless', 'hbar equals one convention for representation examples'),
('imaginary_unit', 1, 'imaginary', 'used symbolically as i'),
('c3_order', 3, 'dimensionless', 'order of cyclic group C3'),
('su2_spin_half_dimension', 2, 'dimensionless', 'dimension of spin one-half representation'),
('so3_vector_dimension', 3, 'dimensionless', 'dimension of ordinary vector representation');

INSERT INTO finite_group_cases VALUES
('C3', 'cyclic group C3', 3, 1, 'r', 'r^3=e', 'simplest nontrivial cyclic rotation group'),
('C4', 'cyclic group C4', 4, 1, 'r', 'r^4=e', 'fourfold rotational symmetry scaffold'),
('S3', 'symmetric group S3', 6, 0, 's t', 's^2=e; t^3=e; sts=t^-1', 'permutation group of three objects'),
('D4', 'dihedral group D4', 8, 0, 'r s', 'r^4=e; s^2=e; srs=r^-1', 'symmetry group of square');

INSERT INTO c3_character_table VALUES
('Gamma_0', '1', '1', '1', 1, 'trivial representation'),
('Gamma_1', '1', 'omega', 'omega2', 1, 'first complex representation'),
('Gamma_2', '1', 'omega2', 'omega', 1, 'complex conjugate representation');

INSERT INTO reducible_character_cases VALUES
('regular_C3', 'C3', 3, 0, 0, 'regular representation of C3'),
('two_plus_one', 'C3', 2, 1, 1, 'trivial plus repeated structure example'),
('single_trivial', 'C3', 1, 1, 1, 'trivial representation only'),
('complex_pair', 'C3', 2, -1, -1, 'sum of nontrivial complex conjugate irreps');

INSERT INTO angular_momentum_cases VALUES
('spin_half', 0.5, 1.0, 'spin one-half SU2 representation'),
('spin_one', 1.0, 1.0, 'spin one representation'),
('spin_three_half', 1.5, 1.0, 'spin three-halves representation'),
('spin_two', 2.0, 1.0, 'spin two representation'),
('spin_three', 3.0, 1.0, 'spin three representation');

INSERT INTO lie_algebra_cases VALUES
('su2', 'Jx', 'Jy', 'i Jz', 'epsilon_xyz equals 1'),
('su2', 'Jy', 'Jz', 'i Jx', 'cyclic angular momentum commutator'),
('su2', 'Jz', 'Jx', 'i Jy', 'cyclic angular momentum commutator'),
('lorentz', 'Jx', 'Jy', 'i Jz', 'rotation subalgebra'),
('lorentz', 'Jx', 'Ky', 'i Kz', 'rotation boost commutator'),
('lorentz', 'Kx', 'Ky', '-i Jz', 'boost boost commutator');

INSERT INTO point_group_examples VALUES
('C3', 3, 'threefold rotational systems', 'orbital and vibrational classification', 'cyclic point symmetry'),
('C2v', 4, 'bent molecules and anisotropic systems', 'infrared and Raman selection rules', 'common molecular point group'),
('D3h', 12, 'planar trigonal molecules', 'vibrational modes and electronic states', 'includes horizontal reflection'),
('Oh', 48, 'cubic crystals and octahedral molecules', 'crystal field splitting and cubic band degeneracy', 'high-symmetry cubic group'),
('Td', 24, 'tetrahedral semiconductors and molecules', 'band structure and vibrational classification', 'zinc blende scaffold'),
('D4h', 16, 'tetragonal crystals', 'crystal field and superconducting order parameters', 'layered-material symmetry');

INSERT INTO physical_relations VALUES
(1, 'representation homomorphism', 'D(gh) = D(g)D(h)', 'D,g,h', 'representation preserves group multiplication'),
(2, 'character', 'chi(g) = Tr D(g)', 'chi,D,g', 'trace of representation matrix'),
(3, 'character inner product', '<chi_a, chi_b> = (1/|G|) sum_g conjugate(chi_a(g)) chi_b(g)', 'chi_a,chi_b,G', 'finite-group orthogonality relation'),
(4, 'irreducible multiplicity', 'n_a = (1/|G|) sum_g conjugate(chi_a(g)) chi_Gamma(g)', 'n_a,chi_a,chi_Gamma,G', 'multiplicity of irrep in reducible representation'),
(5, 'Lie algebra commutator', '[T_a,T_b] = i f_ab^c T_c', 'T_a,T_b,f', 'infinitesimal symmetry algebra'),
(6, 'angular momentum algebra', '[J_i,J_j] = i hbar epsilon_ijk J_k', 'J_i,J_j,hbar,epsilon', 'quantum rotation generator algebra'),
(7, 'angular momentum Casimir', 'J^2 |j,m> = hbar^2 j(j+1)|j,m>', 'J,j,m,hbar', 'Casimir eigenvalue for spin-j representation'),
(8, 'Jz eigenvalue', 'J_z |j,m> = hbar m |j,m>', 'J_z,j,m,hbar', 'magnetic quantum number relation'),
(9, 'spin representation dimension', 'dim(j) = 2j + 1', 'j', 'dimension of SU2 spin-j representation'),
(10, 'angular momentum tensor product', 'j1 tensor j2 = direct sum from |j1-j2| to j1+j2', 'j1,j2,j', 'Clebsch-Gordan decomposition structure'),
(11, 'gauge covariant derivative', 'D_mu = partial_mu + i g A_mu^a T_a', 'D_mu,g,A,T', 'gauge generator structure in field coupling'),
(12, 'Standard Model gauge group', 'SU(3)_C x SU(2)_L x U(1)_Y', 'SU3,SU2,U1', 'internal gauge symmetry structure');

INSERT INTO model_metadata VALUES
(1, 'c3_character_orthogonality', 'finite group representation theory', 'character inner products', 'complex one-dimensional irreps only'),
(2, 'finite_group_decomposition', 'irreducible decomposition', 'multiplicity n_alpha', 'requires known character table'),
(3, 'angular_momentum_su2', 'Lie algebra representation', 'J matrices', 'dense matrices for small j'),
(4, 'representation_check', 'verify homomorphism', 'D(gh)-D(g)D(h)', 'depends on correct multiplication table'),
(5, 'lie_algebra_commutators', 'commutator metadata', 'structure constants', 'metadata not full symbolic Lie package'),
(6, 'tensor_product_scaffold', 'composite representations', 'decomposition labels', 'limited to angular momentum examples'),
(7, 'point_group_metadata', 'symmetry classification', 'point group properties', 'not a full crystallographic database'),
(8, 'sql_metadata', 'reproducibility', 'groups irreps generators sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Group Theory with Applications to Physics', 'MIT Mathematics', 'course selecting group theory useful for physics', 'https://math.mit.edu/classes/18.395/index.php'),
(2, 'MIT Representations of Lie Groups', 'MIT OpenCourseWare', 'compact and noncompact Lie group representation theory', 'https://ocw.mit.edu/courses/18-757-representations-of-lie-groups-fall-2023/'),
(3, 'MIT Lie Groups and Lie Algebras I', 'MIT OpenCourseWare', 'Lie group and Lie algebra foundations', 'https://ocw.mit.edu/courses/18-745-lie-groups-and-lie-algebras-i-fall-2020/'),
(4, 'MIT Particle Physics II', 'MIT OpenCourseWare', 'Standard Model gauge structure and particle physics', 'https://ocw.mit.edu/courses/8-811-particle-physics-ii-fall-2005/'),
(5, 'MIT Applications of Group Theory to Solids', 'MIT', 'group theory in quantum mechanics solids tensors space groups and selection rules', 'https://web.mit.edu/course/6/6.734j/www/group-full02.pdf'),
(6, 'Woit Quantum Theory Groups and Representations', 'Columbia University', 'open textbook on quantum theory and representations', 'https://www.math.columbia.edu/~woit/QM/qmbook.pdf'),
(7, 'Zee Group Theory in a Nutshell', 'Princeton University Press', 'physics-oriented group theory textbook', 'https://press.princeton.edu/books/hardcover/9780691162690/group-theory-in-a-nutshell-for-physicists'),
(8, 'Tinkham Group Theory and Quantum Mechanics', 'Dover', 'classic group theory and quantum mechanics text', 'https://store.doverpublications.com/products/9780486432472');

INSERT INTO model_assumptions VALUES
(1, 'c3_character_orthogonality', 'Uses complex irreducible characters of C3.'),
(2, 'finite_group_decomposition', 'Requires known irreducible character table and finite-group character orthogonality.'),
(3, 'angular_momentum_su2', 'Uses hbar equals one unless specified otherwise.'),
(4, 'representation_check', 'Uses two-dimensional real rotation matrices for C3.'),
(5, 'lie_algebra_commutators', 'Uses Pauli matrices to verify SU2 commutators.'),
(6, 'tensor_product_scaffold', 'Uses angular momentum addition labels without computing Clebsch-Gordan coefficients.'),
(7, 'point_group_metadata', 'Stores illustrative metadata rather than complete crystallographic group data.'),
(8, 'group_theory_physics_schema', 'Stores educational metadata rather than a production symmetry database.');

INSERT INTO simulation_runs VALUES
(1, 'group-theory-and-representation-theory-in-physics', 'c3_character_orthogonality', 'character_inner_product', 'C3 irreducible characters', 'orthogonality and regular representation decomposition', '2026-04-25'),
(2, 'group-theory-and-representation-theory-in-physics', 'finite_group_decomposition', 'character_projection', 'C3 reducible character cases', 'irrep multiplicity table', '2026-04-25'),
(3, 'group-theory-and-representation-theory-in-physics', 'angular_momentum_su2', 'matrix_generator_construction', 'spin-j cases', 'commutator and Casimir diagnostics', '2026-04-25'),
(4, 'group-theory-and-representation-theory-in-physics', 'representation_check', 'matrix_homomorphism_test', 'C3 2D rotation representation', 'multiplication error norms', '2026-04-25'),
(5, 'group-theory-and-representation-theory-in-physics', 'lie_algebra_commutators', 'matrix_commutator', 'Pauli matrices', 'SU2 commutator diagnostics', '2026-04-25'),
(6, 'group-theory-and-representation-theory-in-physics', 'tensor_product_scaffold', 'angular_momentum_label_decomposition', 'selected j1 and j2 pairs', 'dimension-preserving decomposition table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

-- Continuum Physics and Material Behavior Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores material properties, stress-strain tests, stress tensor cases,
-- beam cases, viscoelastic cases, physical relations, source notes,
-- model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS material_properties;
DROP TABLE IF EXISTS stress_strain_test;
DROP TABLE IF EXISTS stress_tensor_cases;
DROP TABLE IF EXISTS beam_cases;
DROP TABLE IF EXISTS viscoelastic_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE material_properties (
    material TEXT PRIMARY KEY,
    density_kg_per_m3 REAL NOT NULL,
    youngs_modulus_gpa REAL NOT NULL,
    poissons_ratio REAL NOT NULL,
    yield_strength_mpa REAL,
    notes TEXT
);

CREATE TABLE stress_strain_test (
    point_id INTEGER PRIMARY KEY,
    strain REAL NOT NULL,
    stress_mpa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE stress_tensor_cases (
    case_id TEXT PRIMARY KEY,
    s11_mpa REAL NOT NULL,
    s22_mpa REAL NOT NULL,
    s33_mpa REAL NOT NULL,
    s12_mpa REAL NOT NULL,
    s13_mpa REAL NOT NULL,
    s23_mpa REAL NOT NULL,
    yield_strength_mpa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE beam_cases (
    case_id TEXT PRIMARY KEY,
    youngs_modulus_gpa REAL NOT NULL,
    second_moment_area_m4 REAL NOT NULL,
    length_m REAL NOT NULL,
    point_load_n REAL NOT NULL,
    notes TEXT
);

CREATE TABLE viscoelastic_cases (
    case_id TEXT PRIMARY KEY,
    instantaneous_modulus_mpa REAL NOT NULL,
    relaxed_modulus_mpa REAL NOT NULL,
    relaxation_time_s REAL NOT NULL,
    applied_strain REAL NOT NULL,
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

INSERT INTO material_properties VALUES
('structural_steel', 7850, 200, 0.30, 250, 'illustrative steel values'),
('aluminum_6061_t6', 2700, 69, 0.33, 276, 'illustrative aluminum alloy values'),
('titanium_ti64', 4430, 114, 0.34, 880, 'illustrative titanium alloy values'),
('glass_soda_lime', 2500, 70, 0.22, NULL, 'brittle material illustrative value'),
('rubber_like', 1100, 0.01, 0.49, NULL, 'nearly incompressible soft material example'),
('bone_cortical', 1900, 17, 0.30, 130, 'simplified biological material value'),
('epoxy', 1200, 3.0, 0.35, 70, 'polymer matrix illustrative value');

INSERT INTO stress_strain_test VALUES
(1, 0.0000, 0, 'illustrative uniaxial test'),
(2, 0.0005, 100, 'elastic region'),
(3, 0.0010, 201, 'elastic region'),
(4, 0.0015, 302, 'elastic region'),
(5, 0.0020, 401, 'elastic region'),
(6, 0.0025, 495, 'near yielding'),
(7, 0.0030, 560, 'post-yield'),
(8, 0.0040, 625, 'plastic hardening'),
(9, 0.0060, 690, 'plastic hardening'),
(10, 0.0080, 735, 'plastic hardening'),
(11, 0.0100, 760, 'plastic hardening'),
(12, 0.0120, 775, 'plastic hardening');

INSERT INTO stress_tensor_cases VALUES
('triaxial_shear_case', 120, 80, 50, 35, 10, 15, 250, 'article tensor example'),
('hydrostatic_compression', -100, -100, -100, 0, 0, 0, 250, 'pure hydrostatic stress no deviatoric part'),
('plane_stress_plate', 180, 60, 0, 45, 0, 0, 250, 'plane stress style example'),
('torsion_like', 0, 0, 0, 90, 0, 0, 250, 'pure shear illustrative state'),
('high_yield_case', 260, 40, 30, 80, 20, 10, 250, 'likely yielding example');

INSERT INTO beam_cases VALUES
('steel_small_beam', 200, 8.0e-8, 2.0, 500, 'simply supported central point load scaffold'),
('aluminum_small_beam', 69, 8.0e-8, 2.0, 500, 'lower stiffness comparison'),
('steel_long_beam', 200, 8.0e-8, 3.0, 500, 'length sensitivity comparison'),
('steel_larger_section', 200, 3.0e-7, 2.0, 500, 'section stiffness comparison');

INSERT INTO viscoelastic_cases VALUES
('fast_relaxation_polymer', 100, 20, 5, 0.02, 'stress relaxation scaffold'),
('slow_relaxation_polymer', 100, 20, 60, 0.02, 'slower relaxation scaffold'),
('soft_tissue_like', 2.0, 0.4, 20, 0.10, 'simplified tissue-like scaffold'),
('rubber_like', 10, 5, 30, 0.20, 'simplified rubber-like scaffold');

INSERT INTO physical_relations VALUES
(1, 'engineering strain', 'epsilon = Delta L / L0', 'epsilon,Delta L,L0', 'one-dimensional engineering strain'),
(2, 'engineering stress', 'sigma = F/A0', 'sigma,F,A0', 'force per original area'),
(3, 'Hooke law', 'sigma = E epsilon', 'sigma,E,epsilon', 'one-dimensional linear elasticity'),
(4, 'small strain tensor', 'epsilon_ij = 1/2(partial u_i/partial x_j + partial u_j/partial x_i)', 'epsilon,u,x', 'small-deformation strain'),
(5, 'deformation gradient', 'F = partial x/partial X', 'F,x,X', 'finite-deformation mapping'),
(6, 'Cauchy traction', 't(n) = sigma n', 't,sigma,n', 'stress maps surface normal to traction'),
(7, 'static equilibrium', 'div sigma + b = 0', 'sigma,b', 'force balance in static continuum'),
(8, 'momentum balance', 'div sigma + b = rho a', 'sigma,b,rho,a', 'continuum form of Newton second law'),
(9, 'linear elastic constitutive law', 'sigma_ij = C_ijkl epsilon_kl', 'sigma,C,epsilon', 'general linear elasticity'),
(10, 'isotropic linear elasticity', 'sigma_ij = lambda epsilon_kk delta_ij + 2 mu epsilon_ij', 'sigma,lambda,mu,epsilon', 'isotropic elastic relation'),
(11, 'shear modulus conversion', 'G = E/[2(1+nu)]', 'G,E,nu', 'isotropic elastic constant conversion'),
(12, 'bulk modulus conversion', 'K = E/[3(1-2nu)]', 'K,E,nu', 'isotropic elastic constant conversion'),
(13, 'elastic energy density', 'w = 1/2 sigma_ij epsilon_ij', 'w,sigma,epsilon', 'elastic strain energy per unit volume'),
(14, 'von Mises stress', 'sigma_vM = sqrt(3/2 s_ij s_ij)', 'sigma_vM,s', 'distortional equivalent stress');

INSERT INTO model_metadata VALUES
(1, 'linear elasticity', 'small reversible deformation', 'E', 'limited to elastic small-strain regimes'),
(2, 'stress tensor diagnostics', 'stress-state decomposition', 'principal stresses', 'requires reliable stress tensor'),
(3, 'von Mises yield', 'ductile metal yield estimate', 'sigma_vM', 'not universal for brittle or anisotropic materials'),
(4, 'beam deflection', 'slender beam response', 'delta', 'requires Euler-Bernoulli assumptions'),
(5, 'viscoelastic relaxation', 'time-dependent stress response', 'E(t)', 'simple spring-dashpot approximation'),
(6, 'fracture criterion', 'crack growth/failure estimate', 'K', 'geometry and crack assumptions matter'),
(7, 'continuum approximation', 'field representation', 'u sigma epsilon', 'breaks near microstructural scales');

INSERT INTO source_notes VALUES
(1, 'MIT Mechanics Materials II', 'MIT OpenCourseWare', 'elasticity solid mechanics stress strain and material behavior', 'https://ocw.mit.edu/courses/2-002-mechanics-and-materials-ii-spring-2004/pages/lecture-notes/'),
(2, 'MIT Mechanical Behavior of Materials', 'MIT OpenCourseWare', 'mechanical testing stress distributions elasticity plasticity fracture fatigue', 'https://ocw.mit.edu/courses/3-032-mechanical-behavior-of-materials-fall-2007/pages/lecture-notes/'),
(3, 'MIT Continuum Mechanics Applications', 'MIT OpenCourseWare', 'stress tensor strain tensors and constitutive relations', 'https://ocw.mit.edu/courses/12-005-applications-of-continuum-mechanics-to-earth-atmospheric-and-planetary-sciences-spring-2006/pages/lecture-notes/'),
(4, 'MIT Mechanics of Material Systems', 'MIT OpenCourseWare', 'energy approach deformation strain momentum balance elasticity plasticity', 'https://ocw.mit.edu/courses/1-033-mechanics-of-material-systems-an-energy-approach-fall-2003/pages/lecture-notes/'),
(5, 'MIT Structural Mechanics Strain', 'MIT OpenCourseWare', 'strain concept and measurement', 'https://ocw.mit.edu/courses/2-080j-structural-mechanics-fall-2013/71034688fba0ff26d25653a4bd236a4a_MIT2_080JF13_Lecture2.pdf'),
(6, 'MIT Structural Plasticity', 'MIT OpenCourseWare', 'plasticity yield and constitutive concepts', 'https://ocw.mit.edu/courses/2-080j-structural-mechanics-fall-2013/30dc1a0f74debf21fb92a1df56616929_MIT2_080JF13_Lecture12.pdf'),
(7, 'NIST SI Guide', 'NIST', 'SI units for stress pressure pascal and derived quantities', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(8, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9');

INSERT INTO model_assumptions VALUES
(1, 'stress_tensor_diagnostics', 'Uses symmetric Cauchy stress tensors in MPa.'),
(2, 'stress_tensor_diagnostics', 'Uses von Mises stress as a ductile yield diagnostic.'),
(3, 'beam_deflection_scaffold', 'Uses simply supported beam with central point load and Euler-Bernoulli assumptions.'),
(4, 'viscoelastic_response_scaffold', 'Uses simple exponential relaxation as a teaching scaffold.'),
(5, 'stress_strain_modulus_estimation', 'Estimates modulus from the selected linear elastic region.'),
(6, 'continuum_materials_schema', 'Stores educational metadata rather than a production material-test database.');

INSERT INTO simulation_runs VALUES
(1, 'continuum-physics-and-material-behavior', 'stress_tensor_diagnostics', 'eigenvalue_tensor_diagnostics', 'sample 3D stress tensor cases', 'principal stress hydrostatic stress von Mises yield diagnostics', '2026-04-25'),
(2, 'continuum-physics-and-material-behavior', 'beam_deflection_scaffold', 'closed_form_beam_table', 'simply supported central load cases', 'deflection estimates', '2026-04-25'),
(3, 'continuum-physics-and-material-behavior', 'viscoelastic_response_scaffold', 'exponential_relaxation_model', 'four sample relaxation cases', 'time-dependent modulus and stress table', '2026-04-25'),
(4, 'continuum-physics-and-material-behavior', 'stress_strain_modulus_estimation', 'linear_regression_and_trapezoid_energy', 'illustrative uniaxial stress-strain test', 'Young modulus and strain energy summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

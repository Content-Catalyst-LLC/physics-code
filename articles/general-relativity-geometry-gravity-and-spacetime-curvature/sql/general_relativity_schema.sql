-- General Relativity Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, compact-object cases, weak-field orbit cases,
-- cosmology cases, metric catalog entries, observational tests,
-- physical relations, model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS relativity_constants;
DROP TABLE IF EXISTS compact_object_cases;
DROP TABLE IF EXISTS weak_field_orbit_cases;
DROP TABLE IF EXISTS cosmology_cases;
DROP TABLE IF EXISTS metric_catalog;
DROP TABLE IF EXISTS observational_tests;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE relativity_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE compact_object_cases (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    radius_m REAL,
    object_class TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE weak_field_orbit_cases (
    case_id TEXT PRIMARY KEY,
    central_mass_kg REAL NOT NULL,
    semi_major_axis_m REAL NOT NULL,
    eccentricity REAL NOT NULL,
    time_step_s REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE cosmology_cases (
    case_id TEXT PRIMARY KEY,
    hubble_km_s_mpc REAL NOT NULL,
    omega_m REAL NOT NULL,
    omega_lambda REAL NOT NULL,
    omega_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE metric_catalog (
    metric_name TEXT PRIMARY KEY,
    primary_context TEXT NOT NULL,
    key_parameters TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE observational_tests (
    test_name TEXT PRIMARY KEY,
    primary_quantity TEXT NOT NULL,
    regime TEXT NOT NULL,
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

INSERT INTO relativity_constants VALUES
('speed_of_light', 299792458, 'm s^-1', 'exact SI value'),
('gravitational_constant', 6.67430e-11, 'm^3 kg^-1 s^-2', 'CODATA value'),
('solar_mass', 1.98847e30, 'kg', 'nominal solar mass used for educational calculations'),
('earth_mass', 5.9722e24, 'kg', 'Earth mass approximate'),
('earth_radius', 6.371e6, 'm', 'mean Earth radius approximate'),
('sun_radius', 6.957e8, 'm', 'solar radius approximate'),
('astronomical_unit', 1.495978707e11, 'm', 'IAU-defined astronomical unit'),
('parsec', 3.085677581491367e16, 'm', 'parsec in meters'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant');

INSERT INTO compact_object_cases VALUES
('earth', 5.9722e24, 6.371e6, 'planet', 'weak-field terrestrial case'),
('sun', 1.98847e30, 6.957e8, 'star', 'solar weak-field case'),
('white_dwarf_like', 1.98847e30, 7.0e6, 'white dwarf', 'compact stellar remnant educational case'),
('neutron_star_like', 2.783858e30, 1.2e4, 'neutron star', 'compact strong-field educational case'),
('stellar_black_hole_10sm', 1.98847e31, NULL, 'black hole', 'ten solar mass Schwarzschild scale'),
('supermassive_black_hole_4e6sm', 7.95388e36, NULL, 'black hole', 'Milky Way center scale educational case');

INSERT INTO weak_field_orbit_cases VALUES
('mercury_like', 1.98847e30, 5.7909e10, 0.2056, 2000, 120000, 'Mercury-like educational weak-field orbit'),
('earth_like', 1.98847e30, 1.495978707e11, 0.0167, 4000, 120000, 'Earth-like weak-field orbit'),
('compact_test', 1.98847e30, 1.0e10, 0.2, 500, 120000, 'stronger precession educational toy case');

INSERT INTO cosmology_cases VALUES
('flat_lcdm_like', 67.4, 0.315, 0.685, 0.0, 'illustrative flat Lambda CDM-like case'),
('matter_dominated', 70.0, 1.0, 0.0, 0.0, 'Einstein-de Sitter educational case'),
('open_low_density', 70.0, 0.3, 0.0, 0.7, 'open universe educational case'),
('lambda_dominated', 70.0, 0.1, 0.9, 0.0, 'dark-energy dominated educational case');

INSERT INTO metric_catalog VALUES
('Minkowski', 'flat spacetime', 'c', 'baseline special-relativistic metric'),
('Schwarzschild', 'non-rotating spherical mass', 'M', 'black hole exterior and weak-field solar-system tests'),
('Kerr', 'rotating black hole', 'M and angular momentum', 'frame dragging ergosphere and rotating horizons'),
('FLRW', 'homogeneous isotropic cosmology', 'a(t) and k', 'expanding universe model'),
('de_Sitter', 'positive cosmological constant', 'Lambda', 'vacuum accelerated expansion model'),
('anti_de_Sitter', 'negative cosmological constant', 'Lambda', 'important in mathematical relativity and holography');

INSERT INTO observational_tests VALUES
('Mercury perihelion precession', 'orbital precession', 'solar system weak field', 'classic early test of GR'),
('light bending', 'deflection angle', 'solar system and lensing', 'null geodesic curvature'),
('gravitational redshift', 'frequency shift', 'weak field to compact objects', 'clock and photon energy effect'),
('Shapiro delay', 'time delay', 'solar system weak field', 'signal delay near massive bodies'),
('binary pulsar decay', 'orbital period derivative', 'stronger-field binary system', 'indirect gravitational radiation evidence'),
('gravitational waves', 'strain', 'strong-field dynamical mergers', 'direct spacetime radiation detection'),
('frame dragging', 'gyroscope precession', 'near rotating Earth or compact objects', 'rotation-induced spacetime dragging'),
('black hole imaging', 'shadow and photon ring', 'strong-field gravity', 'tests near event-horizon-scale geometry');

INSERT INTO physical_relations VALUES
(1, 'metric interval', 'ds^2 = g_mu_nu dx^mu dx^nu', 'ds,g_mu_nu,dx_mu', 'spacetime interval determined by metric'),
(2, 'Christoffel symbols', 'Gamma^mu_alpha_beta = 1/2 g^mu_nu(partial_alpha g_nu_beta + partial_beta g_nu_alpha - partial_nu g_alpha_beta)', 'Gamma,g,partial', 'connection coefficients from metric'),
(3, 'geodesic equation', 'd2x^mu/dlambda2 + Gamma^mu_alpha_beta dx^alpha/dlambda dx^beta/dlambda = 0', 'x,lambda,Gamma', 'free-fall motion in curved spacetime'),
(4, 'Riemann tensor', 'R^rho_sigma_mu_nu = partial_mu Gamma^rho_nu_sigma - partial_nu Gamma^rho_mu_sigma + Gamma Gamma - Gamma Gamma', 'R,Gamma', 'curvature tensor'),
(5, 'Einstein tensor', 'G_mu_nu = R_mu_nu - 1/2 R g_mu_nu', 'G,R_mu_nu,R,g', 'divergence-free curvature tensor'),
(6, 'Einstein field equation', 'G_mu_nu + Lambda g_mu_nu = (8 pi G/c^4) T_mu_nu', 'G_mu_nu,Lambda,g,T', 'geometry sourced by stress-energy'),
(7, 'Schwarzschild radius', 'r_s = 2GM/c^2', 'r_s,G,M,c', 'horizon radius for non-rotating black hole'),
(8, 'gravitational redshift factor', '1 + z = 1/sqrt(1 - r_s/r)', 'z,r_s,r', 'frequency shift from Schwarzschild radius to infinity'),
(9, 'light deflection weak field', 'Delta phi approx 4GM/(b c^2)', 'Delta_phi,G,M,b,c', 'weak-field light bending'),
(10, 'Friedmann equation', 'H^2 = 8piG rho/3 - k c^2/a^2 + Lambda c^2/3', 'H,G,rho,k,a,Lambda,c', 'cosmological expansion equation');

INSERT INTO model_metadata VALUES
(1, 'schwarzschild_radius', 'compactness scale', 'r_s', 'non-rotating spherical mass assumption'),
(2, 'gravitational_redshift', 'clock and photon frequency shift', 'z', 'Schwarzschild exterior idealization'),
(3, 'weak_field_precession', 'orbital precession diagnostic', 'perihelion angle', 'pedagogical correction not full geodesic solver'),
(4, 'curvature_symbolic_sphere', 'symbolic curvature example', 'scalar curvature', 'two-sphere example not spacetime GR'),
(5, 'friedmann_scales', 'cosmological expansion scale', 'H(z)', 'homogeneous isotropic model'),
(6, 'metric_catalog', 'reproducibility', 'metric metadata', 'metadata not symbolic tensor engine'),
(7, 'sql_metadata', 'source and assumption tracking', 'relations and runs', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT General Relativity', 'MIT OpenCourseWare', 'graduate course in general relativity differential geometry tests black holes cosmology', 'https://ocw.mit.edu/courses/8-962-general-relativity-spring-2020/'),
(2, 'MIT Spacetime Curvature', 'MIT OpenCourseWare', 'lecture on spacetime curvature and Riemann tensor', 'https://ocw.mit.edu/courses/8-962-general-relativity-spring-2020/resources/lecture-10-spacetime-curvature/'),
(3, 'MIT Einstein Field Equation', 'MIT OpenCourseWare', 'lecture motivating Einstein field equation', 'https://ocw.mit.edu/courses/8-962-general-relativity-spring-2020/resources/lecture-12-the-einstein-field-equation/'),
(4, 'Stanford Gravity Probe B Spacetime', 'Stanford University', 'public explanation of spacetime curvature and frame dragging', 'https://einstein.stanford.edu/SPACETIME/spacetime2.html'),
(5, 'Einstein Foundation of General Relativity', 'Wikisource', 'English translation of Einstein 1916 paper', 'https://en.wikisource.org/wiki/The_Foundation_of_the_Generalised_Theory_of_Relativity'),
(6, 'LIGO What Are Gravitational Waves', 'LIGO Laboratory', 'public gravitational wave explanation', 'https://www.ligo.caltech.edu/page/what-are-gw'),
(7, 'Nobel Prize Physics 2017', 'Nobel Prize', 'official Nobel summary for gravitational wave detection', 'https://www.nobelprize.org/prizes/physics/2017/summary/'),
(8, 'Wald General Relativity', 'University of Chicago Press', 'advanced graduate textbook reference', 'https://press.uchicago.edu/ucp/books/book/chicago/G/bo5952261.html');

INSERT INTO model_assumptions VALUES
(1, 'schwarzschild_scales', 'Uses non-rotating spherical Schwarzschild geometry and supplied object radii.'),
(2, 'gravitational_redshift', 'Uses Schwarzschild redshift formula for stationary emitter outside horizon.'),
(3, 'weak_field_precession', 'Uses a pedagogical weak-field correction and does not solve exact geodesic equations.'),
(4, 'curvature_symbolic_sphere', 'Uses a two-sphere as a symbolic curvature demonstration, not a spacetime solution.'),
(5, 'cosmology_friedmann_scales', 'Uses matter, curvature, and Lambda terms while omitting radiation in the introductory scaffold.'),
(6, 'general_relativity_schema', 'Stores educational metadata rather than a production relativity database.');

INSERT INTO simulation_runs VALUES
(1, 'general-relativity-geometry-gravity-and-spacetime-curvature', 'schwarzschild_scales', 'closed_form_scale_calculation', 'compact object cases', 'Schwarzschild radius compactness and redshift table', '2026-04-25'),
(2, 'general-relativity-geometry-gravity-and-spacetime-curvature', 'gravitational_redshift', 'compactness_grid', 'selected compactness values', 'redshift factor table', '2026-04-25'),
(3, 'general-relativity-geometry-gravity-and-spacetime-curvature', 'weak_field_precession', 'velocity_verlet_toy_model', 'weak-field orbital cases', 'trajectory and perihelion diagnostics', '2026-04-25'),
(4, 'general-relativity-geometry-gravity-and-spacetime-curvature', 'curvature_symbolic_sphere', 'symbolic_metadata', 'two-sphere geometry', 'curvature summary table', '2026-04-25'),
(5, 'general-relativity-geometry-gravity-and-spacetime-curvature', 'cosmology_friedmann_scales', 'closed_form_Hz_grid', 'sample cosmological parameter cases', 'Hubble expansion scale table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

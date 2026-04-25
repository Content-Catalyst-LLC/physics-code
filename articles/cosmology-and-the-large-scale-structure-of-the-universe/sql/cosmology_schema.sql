-- Cosmology and Large-Scale Structure Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores cosmological parameters, redshift grid, surveys, simulations,
-- BAO reference scales, physical relations, model metadata, source notes,
-- assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS cosmology_parameters;
DROP TABLE IF EXISTS redshift_grid;
DROP TABLE IF EXISTS survey_metadata;
DROP TABLE IF EXISTS simulation_metadata;
DROP TABLE IF EXISTS bao_reference_scales;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE cosmology_parameters (
    parameter TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE redshift_grid (
    redshift REAL PRIMARY KEY,
    notes TEXT
);

CREATE TABLE survey_metadata (
    survey TEXT PRIMARY KEY,
    primary_observables TEXT NOT NULL,
    main_tracers TEXT NOT NULL,
    cosmological_role TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE simulation_metadata (
    simulation_or_suite TEXT PRIMARY KEY,
    method TEXT NOT NULL,
    primary_outputs TEXT NOT NULL,
    cosmological_use TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE bao_reference_scales (
    quantity TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
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

INSERT INTO cosmology_parameters VALUES
('H0', 67.4, 'km s^-1 Mpc^-1', 'example Planck-like Hubble constant'),
('h', 0.674, 'dimensionless', 'H0 divided by 100 km s^-1 Mpc^-1'),
('Omega_m', 0.315, 'dimensionless', 'total matter density parameter'),
('Omega_b', 0.049, 'dimensionless', 'baryon density parameter'),
('Omega_cdm', 0.266, 'dimensionless', 'cold dark matter density parameter'),
('Omega_lambda', 0.685, 'dimensionless', 'dark energy density parameter for flat model'),
('Omega_r', 0.0, 'dimensionless', 'radiation neglected in late-time teaching examples'),
('sigma8', 0.811, 'dimensionless', 'fluctuation amplitude scaffold'),
('n_s', 0.965, 'dimensionless', 'scalar spectral index scaffold'),
('c', 299792.458, 'km s^-1', 'speed of light');

INSERT INTO redshift_grid VALUES
(0.0, 'today'),
(0.1, 'nearby low-redshift universe'),
(0.5, 'intermediate redshift'),
(1.0, 'lookback into major galaxy evolution epoch'),
(2.0, 'high-redshift galaxy and quasar era'),
(3.0, 'early structure-growth epoch'),
(6.0, 'reionization-adjacent high redshift'),
(10.0, 'very high-redshift scaffold');

INSERT INTO survey_metadata VALUES
('WMAP', 'CMB temperature and polarization', 'microwave sky', 'early-universe parameters and CMB anisotropies', 'NASA mission'),
('Planck', 'CMB temperature polarization and lensing', 'microwave sky', 'precision Lambda-CDM constraints', 'ESA mission'),
('SDSS', 'galaxy clustering spectra imaging', 'galaxies quasars BAO', 'large-scale structure and BAO', 'long-running ground survey'),
('DES', 'weak lensing supernovae clustering', 'galaxies supernovae', 'dark energy and structure growth', 'Dark Energy Survey'),
('DESI', 'spectroscopic redshifts BAO RSD', 'galaxies quasars Lyman-alpha forest', 'expansion history and dark energy', 'Dark Energy Spectroscopic Instrument'),
('Euclid', 'weak lensing clustering spectra', 'galaxies', 'dark energy dark matter structure growth', 'ESA space mission'),
('Rubin LSST', 'deep time-domain imaging', 'galaxies supernovae lenses', 'weak lensing supernovae transients', 'wide-field optical survey'),
('Roman', 'wide-field imaging spectroscopy supernovae', 'galaxies supernovae lenses', 'dark energy and large-scale structure', 'NASA space mission');

INSERT INTO simulation_metadata VALUES
('Millennium Simulation', 'N-body dark matter', 'halo catalogs merger trees large-scale structure', 'structure formation benchmark', 'classic large-volume simulation'),
('IllustrisTNG', 'magnetohydrodynamic cosmological simulation', 'galaxies gas halos black holes', 'galaxy formation and baryonic effects', 'hydrodynamic simulation suite'),
('EAGLE', 'hydrodynamic cosmological simulation', 'galaxy populations halos gas', 'galaxy formation and feedback', 'calibrated galaxy formation simulations'),
('AbacusSummit', 'N-body simulations', 'mock catalogs matter clustering covariance', 'precision survey cosmology', 'large suite for DESI-era analyses'),
('Quijote', 'N-body simulation suite', 'parameter variations derivatives covariance', 'cosmological inference and machine learning', 'large ensemble'),
('Bolshoi-Planck', 'N-body simulation', 'halo catalogs subhalos structure growth', 'halo modeling and galaxy-halo connection', 'Planck-like cosmology');

INSERT INTO bao_reference_scales VALUES
('sound_horizon_rd', 147.0, 'Mpc', 'representative standard-ruler scale for teaching scaffold'),
('bao_wiggle_scale', 105.0, 'Mpc h^-1', 'approximate h-scaled scale used in toy spectrum'),
('low_redshift_bao_z', 0.5, 'dimensionless', 'example transverse BAO redshift'),
('high_redshift_bao_z', 2.0, 'dimensionless', 'example Lyman-alpha and quasar redshift range scaffold');

INSERT INTO physical_relations VALUES
(1, 'scale factor redshift relation', 'a = 1/(1+z)', 'a,z', 'redshift as inverse scale factor'),
(2, 'Hubble parameter', 'H = adot/a', 'H,a,adot', 'fractional expansion rate'),
(3, 'flat LCDM expansion', 'E(z) = sqrt(Omega_m(1+z)^3 + Omega_Lambda)', 'E,z,Omega_m,Omega_Lambda', 'late-time flat Lambda-CDM expansion function'),
(4, 'critical density', 'rho_c = 3 H0^2/(8 pi G)', 'rho_c,H0,G', 'density required for flatness at given H0'),
(5, 'density parameter', 'Omega_i = rho_i/rho_c', 'Omega_i,rho_i,rho_c', 'density as fraction of critical density'),
(6, 'comoving distance', 'chi(z) = c integral_0^z dz/H(z)', 'chi,c,z,H', 'radial comoving distance'),
(7, 'luminosity distance', 'D_L = (1+z) chi', 'D_L,z,chi', 'distance relevant to flux-luminosity relation'),
(8, 'angular diameter distance', 'D_A = chi/(1+z)', 'D_A,z,chi', 'distance relevant to observed angular size'),
(9, 'density contrast', 'delta = (rho-rho_bar)/rho_bar', 'delta,rho,rho_bar', 'fractional density perturbation'),
(10, 'linear growth equation', 'delta_ddot + 2H delta_dot - 4piG rho_m delta = 0', 'delta,H,G,rho_m', 'linear matter perturbation growth'),
(11, 'power spectrum definition', '<delta(k) delta*(kprime)> = (2pi)^3 delta_D(k-kprime) P(k)', 'delta,k,P', 'Fourier-space clustering statistic'),
(12, 'galaxy bias', 'delta_g = b delta_m', 'delta_g,b,delta_m', 'simple linear tracer bias relation');

INSERT INTO model_metadata VALUES
(1, 'flat_lcdm_background', 'background expansion', 'E(z)', 'neglects radiation in low-redshift example'),
(2, 'distance_redshift', 'observational geometry', 'chi DA DL', 'requires cosmological model assumptions'),
(3, 'growth_index_approximation', 'linear growth scaffold', 'D(z)', 'approximate and not a full growth ODE solution'),
(4, 'toy_power_spectrum', 'large-scale-structure illustration', 'P(k)', 'not a physical Boltzmann spectrum'),
(5, 'bao_scale_scaffold', 'standard-ruler intuition', 'theta_BAO and delta_z_BAO', 'uses representative sound horizon'),
(6, 'survey_metadata', 'observational context', 'tracers and observables', 'not a full survey data model'),
(7, 'simulation_summary', 'computational context', 'method and outputs', 'not a simulation pipeline'),
(8, 'sql_metadata', 'reproducibility', 'parameters assumptions sources', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Cosmology', 'MIT OpenCourseWare', 'course on CMB high-redshift galaxies inflation nucleosynthesis and structure formation', 'https://ocw.mit.edu/courses/8-942-cosmology-fall-2001/'),
(2, 'MIT Early Universe', 'MIT OpenCourseWare', 'course on inflation standard Big Bang CMB and early universe', 'https://ocw.mit.edu/courses/8-286-the-early-universe-fall-2013/'),
(3, 'ESA Planck 2018 Overview', 'European Space Agency', 'Planck cosmological legacy and Lambda-CDM overview', 'https://sci.esa.int/web/planck/-/60507-planck-collaboration-2018'),
(4, 'Planck 2018 Cosmological Parameters', 'Planck Collaboration', 'precision cosmological parameter constraints', 'https://arxiv.org/abs/1807.06209'),
(5, 'NASA Cosmic History', 'NASA', 'overview of cosmic history and inflation', 'https://science.nasa.gov/universe/overview/'),
(6, 'NASA WMAP Overview', 'NASA', 'WMAP CMB and universe composition overview', 'https://science.nasa.gov/mission/wmap/wmap-overview/'),
(7, 'DESI DR2 Results Guide', 'DESI Collaboration', '2025 BAO measurements and interpretation guide', 'https://www.desi.lbl.gov/2025/03/19/desi-dr2-results-march-19-guide/'),
(8, 'DESI DR2 Publications', 'DESI Data', 'DR2 cosmology publications and data-product documentation', 'https://data.desi.lbl.gov/doc/papers/dr2/'),
(9, 'SDSS', 'Sloan Digital Sky Survey', 'galaxy survey and large-scale structure data', 'https://www.sdss.org/');

INSERT INTO model_assumptions VALUES
(1, 'flat_lcdm_background', 'Uses a spatially flat late-time Lambda-CDM example.'),
(2, 'distance_redshift', 'Uses trapezoid integration and neglects radiation for low-redshift teaching distances.'),
(3, 'growth_index_approximation', 'Uses f approximately equal to Omega_m(z)^0.55 rather than solving the exact growth ODE.'),
(4, 'toy_power_spectrum', 'Uses illustrative transfer suppression and BAO-like wiggles rather than a Boltzmann solver.'),
(5, 'bao_scale_scaffold', 'Uses a representative sound horizon scale for teaching calculations.'),
(6, 'survey_metadata', 'Summarizes survey roles without storing full data releases or likelihoods.'),
(7, 'simulation_summary', 'Summarizes simulation types without running simulation code.'),
(8, 'cosmology_schema', 'Stores educational metadata rather than a production cosmological database.');

INSERT INTO simulation_runs VALUES
(1, 'cosmology-and-the-large-scale-structure-of-the-universe', 'flrw_distances', 'trapezoid_integration', 'flat LCDM parameters and redshift grid', 'E(z), H(z), comoving distance, angular diameter distance, luminosity distance', '2026-04-25'),
(2, 'cosmology-and-the-large-scale-structure-of-the-universe', 'growth_and_power_spectrum', 'growth_index_and_toy_spectrum', 'Omega_m Omega_lambda n_s sigma8 scaffold', 'growth table and toy power spectrum', '2026-04-25'),
(3, 'cosmology-and-the-large-scale-structure-of-the-universe', 'bao_scale_scaffold', 'standard_ruler_scaling', 'representative sound horizon and redshift grid', 'angular and radial BAO scale table', '2026-04-25'),
(4, 'cosmology-and-the-large-scale-structure-of-the-universe', 'survey_metadata_summary', 'metadata_classification', 'survey metadata table', 'survey observables and cosmological roles', '2026-04-25'),
(5, 'cosmology-and-the-large-scale-structure-of-the-universe', 'simulation_summary', 'metadata_classification', 'simulation metadata table', 'simulation methods and cosmological uses', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

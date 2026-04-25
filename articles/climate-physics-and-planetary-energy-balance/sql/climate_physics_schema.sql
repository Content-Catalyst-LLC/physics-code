-- Climate Physics and Planetary Energy Balance Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores climate constants, albedo-feedback cases, CO2 scenarios,
-- energy-balance parameters, two-layer model parameters, physical relations,
-- source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS climate_constants;
DROP TABLE IF EXISTS albedo_feedback_cases;
DROP TABLE IF EXISTS co2_scenarios;
DROP TABLE IF EXISTS energy_balance_parameters;
DROP TABLE IF EXISTS two_layer_parameters;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE climate_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE albedo_feedback_cases (
    case_id TEXT PRIMARY KEY,
    planetary_albedo REAL NOT NULL,
    feedback_parameter_w_m2_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE co2_scenarios (
    scenario TEXT NOT NULL,
    year REAL NOT NULL,
    co2_ppm REAL NOT NULL,
    notes TEXT,
    PRIMARY KEY (scenario, year)
);

CREATE TABLE energy_balance_parameters (
    case_id TEXT PRIMARY KEY,
    heat_capacity_j_m2_k REAL NOT NULL,
    feedback_parameter_w_m2_k REAL NOT NULL,
    co2_initial_ppm REAL NOT NULL,
    co2_final_ppm REAL NOT NULL,
    years_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE two_layer_parameters (
    case_id TEXT PRIMARY KEY,
    upper_heat_capacity_j_m2_k REAL NOT NULL,
    deep_heat_capacity_j_m2_k REAL NOT NULL,
    feedback_parameter_w_m2_k REAL NOT NULL,
    ocean_exchange_w_m2_k REAL NOT NULL,
    co2_initial_ppm REAL NOT NULL,
    co2_final_ppm REAL NOT NULL,
    years_end REAL NOT NULL,
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

INSERT INTO climate_constants VALUES
('solar_constant', 1361, 'W m^-2', 'approximate total solar irradiance near Earth orbit'),
('earth_like_albedo', 0.30, 'dimensionless', 'illustrative planetary albedo'),
('stefan_boltzmann', 5.670374419e-8, 'W m^-2 K^-4', 'Stefan-Boltzmann constant'),
('co2_reference', 280, 'ppm', 'preindustrial-style reference value for examples'),
('co2_doubling', 560, 'ppm', 'CO2 doubling relative to 280 ppm'),
('seconds_per_year', 31557600, 's', '365.25 days');

INSERT INTO albedo_feedback_cases VALUES
('low_albedo_weak_feedback', 0.25, 0.8, 'high absorption and weak damping'),
('earth_like_medium_feedback', 0.30, 1.2, 'baseline reduced model case'),
('high_albedo_strong_feedback', 0.35, 1.6, 'high reflection and stronger damping'),
('low_albedo_strong_feedback', 0.25, 1.6, 'separates albedo from feedback strength'),
('high_albedo_weak_feedback', 0.35, 0.8, 'separates albedo from feedback strength');

INSERT INTO co2_scenarios VALUES
('reference', 0, 280, 'reference concentration'),
('linear_doubling', 50, 373.333333, 'linear path to doubling'),
('linear_doubling', 100, 466.666667, 'linear path to doubling'),
('linear_doubling', 150, 560, 'CO2 doubling'),
('high_scenario', 150, 700, 'higher concentration example'),
('stabilized_420', 150, 420, 'stabilized concentration example');

INSERT INTO energy_balance_parameters VALUES
('upper_ocean_baseline', 8.0e8, 1.2, 280, 560, 150, 'article one-layer baseline'),
('lower_heat_capacity', 4.0e8, 1.2, 280, 560, 150, 'faster response case'),
('higher_heat_capacity', 1.6e9, 1.2, 280, 560, 150, 'slower response case'),
('weak_feedback', 8.0e8, 0.8, 280, 560, 150, 'higher equilibrium response'),
('strong_feedback', 8.0e8, 1.6, 280, 560, 150, 'lower equilibrium response'),
('high_forcing', 8.0e8, 1.2, 280, 700, 150, 'higher concentration scenario');

INSERT INTO two_layer_parameters VALUES
('baseline_two_layer', 8.0e8, 1.0e10, 1.2, 0.7, 280, 560, 200, 'baseline two-layer model'),
('strong_ocean_exchange', 8.0e8, 1.0e10, 1.2, 1.2, 280, 560, 200, 'stronger deep-ocean coupling'),
('weak_ocean_exchange', 8.0e8, 1.0e10, 1.2, 0.3, 280, 560, 200, 'weaker deep-ocean coupling'),
('large_deep_ocean', 8.0e8, 2.0e10, 1.2, 0.7, 280, 560, 200, 'larger deep heat reservoir');

INSERT INTO physical_relations VALUES
(1, 'absorbed shortwave radiation', 'ASR = S0(1-alpha)/4', 'ASR,S0,alpha', 'globally averaged absorbed solar radiation'),
(2, 'blackbody radiation', 'OLR = sigma T^4', 'OLR,sigma,T', 'Stefan-Boltzmann emission'),
(3, 'energy imbalance', 'N = ASR - OLR', 'N,ASR,OLR', 'net planetary energy gain or loss'),
(4, 'effective emission temperature', 'Te = [S0(1-alpha)/(4 sigma)]^(1/4)', 'Te,S0,alpha,sigma', 'blackbody temperature needed to emit absorbed solar energy'),
(5, 'CO2 forcing approximation', 'DeltaF = 5.35 ln(C/C0)', 'DeltaF,C,C0', 'approximate logarithmic CO2 forcing'),
(6, 'linearized energy balance', 'N = F - lambda DeltaT', 'N,F,lambda,DeltaT', 'forcing minus radiative response'),
(7, 'equilibrium response', 'DeltaT_eq = F/lambda', 'DeltaT_eq,F,lambda', 'equilibrium warming in reduced model'),
(8, 'one-layer EBM', 'C dT/dt = F(t) - lambda T', 'C,T,t,F,lambda', 'transient response with heat capacity'),
(9, 'two-layer upper equation', 'Cu dTu/dt = F(t) - lambda Tu - kappa(Tu-Td)', 'Cu,Tu,Td,F,lambda,kappa', 'upper-layer response with ocean heat exchange'),
(10, 'two-layer deep equation', 'Cd dTd/dt = kappa(Tu-Td)', 'Cd,Td,Tu,kappa', 'deep-ocean heat uptake');

INSERT INTO model_metadata VALUES
(1, 'zero_dimensional_energy_balance', 'global radiation balance', 'Te and ASR', 'no spatial or vertical structure'),
(2, 'co2_forcing_approximation', 'scenario forcing', 'DeltaF', 'approximation not full radiative transfer'),
(3, 'linear_feedback_model', 'equilibrium response', 'lambda', 'feedbacks may be state dependent'),
(4, 'one_layer_ebm', 'transient response', 'T anomaly', 'simplified heat capacity'),
(5, 'two_layer_ebm', 'ocean heat uptake', 'Tu and Td', 'limited ocean structure'),
(6, 'albedo_sensitivity', 'shortwave reflection', 'alpha', 'no cloud microphysics'),
(7, 'monte_carlo_uncertainty', 'parameter uncertainty', 'output distributions', 'requires assumed input distributions');

INSERT INTO source_notes VALUES
(1, 'IPCC AR6 WGI', 'IPCC', 'physical science assessment', 'https://www.ipcc.ch/report/ar6/wg1/'),
(2, 'IPCC AR6 Chapter 7', 'IPCC', 'Earth energy budget climate feedbacks and climate sensitivity', 'https://www.ipcc.ch/report/ar6/wg1/chapter/chapter-7/'),
(3, 'NASA Earth Radiation Budget', 'NASA', 'public explanation of Earth radiation budget', 'https://science.nasa.gov/ems/13_radiationbudget/'),
(4, 'NASA Climate and Earth Energy Budget', 'NASA Earth Observatory', 'energy budget explanation', 'https://science.nasa.gov/earth/earth-observatory/climate-and-earths-energy-budget/'),
(5, 'NOAA Earth Atmosphere Energy Balance', 'NOAA', 'energy balance educational reference', 'https://www.noaa.gov/jetstream/atmosphere/energy'),
(6, 'NOAA AGGI', 'NOAA GML', 'greenhouse gas radiative forcing index', 'https://gml.noaa.gov/aggi/aggi.html'),
(7, 'MIT Climate Physics Radiative Transfer', 'MIT OpenCourseWare', 'radiative transfer lecture materials', 'https://ocw.mit.edu/courses/12-842-climate-physics-and-chemistry-fall-2008/resources/part6_2/'),
(8, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/publications/si-brochure');

INSERT INTO model_assumptions VALUES
(1, 'one_layer_energy_balance_model', 'Uses a globally averaged one-layer energy-balance model.'),
(2, 'one_layer_energy_balance_model', 'Uses approximate logarithmic CO2 forcing.'),
(3, 'two_layer_ocean_heat_uptake', 'Represents the climate system as upper and deep heat reservoirs.'),
(4, 'albedo_sensitivity', 'Uses fixed albedo values without cloud microphysics.'),
(5, 'climate_uncertainty_monte_carlo', 'Uses illustrative distributions for albedo feedback and CO2 concentration.'),
(6, 'climate_physics_schema', 'Stores educational metadata rather than a production climate database.');

INSERT INTO simulation_runs VALUES
(1, 'climate-physics-and-planetary-energy-balance', 'one_layer_energy_balance_model', 'adaptive_ode_integration', 'CO2 pathways and heat capacity scenarios', 'temperature and energy imbalance trajectories', '2026-04-25'),
(2, 'climate-physics-and-planetary-energy-balance', 'two_layer_ocean_heat_uptake', 'adaptive_ode_integration', 'upper and deep ocean heat reservoirs', 'upper and deep temperature trajectories', '2026-04-25'),
(3, 'climate-physics-and-planetary-energy-balance', 'albedo_sensitivity', 'parameter_sweep', 'albedo from 0.10 to 0.70', 'ASR and effective emission temperature table', '2026-04-25'),
(4, 'climate-physics-and-planetary-energy-balance', 'climate_uncertainty_monte_carlo', 'Monte_Carlo_sampling', 'sampled albedo feedback and CO2 concentration', 'uncertainty samples and summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

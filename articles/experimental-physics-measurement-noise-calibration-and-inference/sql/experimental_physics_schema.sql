-- Experimental Physics: Measurement, Noise, Calibration, and Inference Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, instruments, calibration points, measurement runs,
-- uncertainty budgets, physical relations, model metadata, source notes,
-- assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS experimental_constants;
DROP TABLE IF EXISTS instrument_metadata;
DROP TABLE IF EXISTS calibration_points;
DROP TABLE IF EXISTS measurement_run_metadata;
DROP TABLE IF EXISTS uncertainty_budget_cases;
DROP TABLE IF EXISTS noise_signal_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE experimental_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE instrument_metadata (
    instrument_id TEXT PRIMARY KEY,
    instrument_type TEXT NOT NULL,
    manufacturer_placeholder TEXT,
    model_placeholder TEXT,
    serial_placeholder TEXT,
    last_calibration_date TEXT,
    calibration_due_date TEXT,
    notes TEXT
);

CREATE TABLE calibration_points (
    point_id INTEGER PRIMARY KEY,
    instrument_reading_v REAL NOT NULL,
    reference_value_v REAL NOT NULL,
    reference_uncertainty_v REAL NOT NULL,
    temperature_c REAL,
    notes TEXT
);

CREATE TABLE measurement_run_metadata (
    run_id TEXT PRIMARY KEY,
    experiment_name TEXT NOT NULL,
    instrument_id TEXT NOT NULL,
    operator_placeholder TEXT,
    date TEXT NOT NULL,
    temperature_c REAL,
    humidity_percent REAL,
    analysis_version TEXT,
    notes TEXT
);

CREATE TABLE uncertainty_budget_cases (
    case_id TEXT PRIMARY KEY,
    quantity TEXT NOT NULL,
    estimate REAL NOT NULL,
    standard_uncertainty REAL NOT NULL,
    unit TEXT NOT NULL,
    uncertainty_type TEXT NOT NULL,
    distribution TEXT,
    notes TEXT
);

CREATE TABLE noise_signal_cases (
    case_id TEXT PRIMARY KEY,
    n_samples INTEGER NOT NULL,
    sampling_rate_hz REAL NOT NULL,
    signal_frequency_hz REAL NOT NULL,
    signal_amplitude_v REAL NOT NULL,
    noise_standard_deviation_v REAL NOT NULL,
    random_seed INTEGER NOT NULL,
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

INSERT INTO experimental_constants VALUES
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('elementary_charge', 1.602176634e-19, 'C', 'exact SI value'),
('speed_of_light', 299792458, 'm s^-1', 'exact SI value'),
('planck_constant', 6.62607015e-34, 'J s', 'exact SI value'),
('standard_gravity', 9.80665, 'm s^-2', 'conventional standard gravity'),
('reference_temperature', 293.15, 'K', 'common room-temperature reference 20 C');

INSERT INTO instrument_metadata VALUES
('DMM_001', 'digital_multimeter', 'example_vendor', 'example_model', 'example_serial', '2026-01-15', '2027-01-15', 'voltage and resistance measurements'),
('DAQ_001', 'data_acquisition_device', 'example_vendor', 'example_model', 'example_serial', '2026-02-01', '2027-02-01', 'time-series voltage acquisition'),
('THERM_001', 'temperature_sensor', 'example_vendor', 'example_model', 'example_serial', '2026-01-20', '2027-01-20', 'environmental monitoring'),
('SCOPE_001', 'oscilloscope', 'example_vendor', 'example_model', 'example_serial', '2026-03-01', '2027-03-01', 'signal diagnostics');

INSERT INTO calibration_points VALUES
(1, 0.02, 0.00, 0.005, 20.1, 'zero point'),
(2, 0.98, 1.00, 0.005, 20.1, 'low reference'),
(3, 2.01, 2.00, 0.005, 20.1, 'calibration point'),
(4, 3.03, 3.00, 0.005, 20.2, 'calibration point'),
(5, 3.98, 4.00, 0.005, 20.2, 'calibration point'),
(6, 5.02, 5.00, 0.005, 20.2, 'calibration point'),
(7, 6.01, 6.00, 0.005, 20.3, 'calibration point'),
(8, 7.03, 7.00, 0.005, 20.3, 'calibration point'),
(9, 8.00, 8.00, 0.005, 20.3, 'calibration point'),
(10, 9.01, 9.00, 0.005, 20.4, 'high reference');

INSERT INTO measurement_run_metadata VALUES
('RUN_001', 'calibration_curve', 'DMM_001', 'operator_a', '2026-04-25', 20.2, 42, 'v1.0', 'linear calibration demonstration'),
('RUN_002', 'noise_signal_demo', 'DAQ_001', 'operator_a', '2026-04-25', 20.3, 43, 'v1.0', 'synthetic signal acquisition'),
('RUN_003', 'resistance_uncertainty', 'DMM_001', 'operator_a', '2026-04-25', 20.1, 41, 'v1.0', 'uncertainty propagation example'),
('RUN_004', 'bayesian_update', 'DMM_001', 'operator_a', '2026-04-25', 20.2, 42, 'v1.0', 'normal-normal measurement update');

INSERT INTO uncertainty_budget_cases VALUES
('resistance_voltage', 'voltage', 10.00, 0.02, 'V', 'Type B', 'normal', 'voltmeter calibration uncertainty'),
('resistance_current', 'current', 2.000, 0.005, 'A', 'Type B', 'normal', 'ammeter calibration uncertainty'),
('length_repeatability', 'length_repeatability', 1.000, 0.002, 'm', 'Type A', 'normal', 'repeated measurement standard uncertainty'),
('length_resolution', 'length_resolution', 1.000, 0.00029, 'm', 'Type B', 'rectangular', 'resolution converted to standard uncertainty'),
('temperature_drift', 'temperature_correction', 0.000, 0.010, 'K', 'Type B', 'normal', 'environmental drift bound');

INSERT INTO noise_signal_cases VALUES
('article_demo', 2000, 1000, 25, 2.0, 0.25, 42, 'article body signal example'),
('low_snr', 2000, 1000, 25, 0.5, 0.5, 101, 'low signal-to-noise example'),
('high_snr', 2000, 1000, 25, 2.0, 0.05, 202, 'high signal-to-noise example'),
('slow_signal', 4000, 1000, 5, 1.0, 0.2, 303, 'low-frequency signal example');

INSERT INTO physical_relations VALUES
(1, 'measurement model', 'y = f(x_1, x_2, ..., x_n)', 'y,x_i', 'measurement result as function of input quantities'),
(2, 'sample mean', 'x_bar = (1/n) sum_i x_i', 'x_bar,n,x_i', 'mean of repeated observations'),
(3, 'sample variance', 's^2 = (1/(n-1)) sum_i (x_i - x_bar)^2', 's,x_i,x_bar,n', 'sample estimate of variance'),
(4, 'standard uncertainty of mean', 'u_xbar = s/sqrt(n)', 'u_xbar,s,n', 'standard uncertainty from repeated observations'),
(5, 'combined uncertainty', 'u_c = sqrt(sum_i u_i^2)', 'u_c,u_i', 'root-sum-square independent uncertainty components'),
(6, 'expanded uncertainty', 'U = k u_c', 'U,k,u_c', 'coverage-factor-scaled uncertainty'),
(7, 'uncertainty propagation', 'u_y^2 = J Sigma J^T', 'u_y,J,Sigma', 'covariance-based propagation of uncertainty'),
(8, 'linear calibration', 'y = alpha + beta x', 'y,alpha,beta,x', 'offset and scale calibration model'),
(9, 'SNR', 'SNR = signal_rms/noise_rms', 'SNR,signal_rms,noise_rms', 'signal strength relative to noise'),
(10, 'Bayesian update', 'p(theta|D) proportional to p(D|theta)p(theta)', 'theta,D', 'posterior inference from likelihood and prior');

INSERT INTO model_metadata VALUES
(1, 'linear_calibration_curve', 'calibration fitting', 'slope and intercept', 'may fail under nonlinearity or extrapolation'),
(2, 'noise_snr_simulation', 'signal detection', 'SNR', 'assumes known clean signal in scaffold'),
(3, 'uncertainty_propagation', 'measurement uncertainty', 'u_y', 'linear approximation may fail under strong nonlinearity'),
(4, 'monte_carlo_uncertainty', 'nonlinear uncertainty propagation', 'output distribution', 'depends on input distribution assumptions'),
(5, 'fourier_noise_diagnostics', 'frequency-domain noise analysis', 'power spectrum', 'requires sampling and stationarity assumptions'),
(6, 'bayesian_measurement_update', 'parameter inference', 'posterior mean and sd', 'depends on likelihood and prior assumptions'),
(7, 'sql_metadata', 'reproducibility', 'provenance and assumptions', 'requires disciplined updates');

INSERT INTO source_notes VALUES
(1, 'MIT Experimental Physics Junior Lab', 'MIT OpenCourseWare', 'experimental physics laboratory course', 'https://ocw.mit.edu/courses/8-13-14-experimental-physics-i-ii-junior-lab-fall-2016-spring-2017/'),
(2, 'MIT Junior Lab Experiments', 'MIT OpenCourseWare', 'laboratory experiment guides', 'https://ocw.mit.edu/courses/8-13-14-experimental-physics-i-ii-junior-lab-fall-2016-spring-2017/pages/experiments/'),
(3, 'NIST Technical Note 1297', 'NIST', 'measurement uncertainty guidance', 'https://www.nist.gov/pml/nist-technical-note-1297'),
(4, 'NIST Traceability Policy', 'NIST', 'metrological traceability policy', 'https://www.nist.gov/calibrations/traceability'),
(5, 'NIST Uncertainty Results', 'NIST', 'uncertainty resources and calculator', 'https://physics.nist.gov/cuu/Uncertainty/'),
(6, 'BIPM SI Units', 'BIPM', 'international system of units reference', 'https://www.bipm.org/en/measurement-units'),
(7, 'JCGM GUM', 'Joint Committee for Guides in Metrology', 'guide to expression of uncertainty in measurement', 'https://www.iso.org/sites/JCGM/GUM/JCGM100/C045315e-html/C045315e_FILES/MAIN_C045315e/Pre_e.html'),
(8, 'Stanford Experiment in Physics', 'Stanford Encyclopedia of Philosophy', 'conceptual role of experiment in physics', 'https://plato.stanford.edu/archives/fall2005/entries/physics-experiment/');

INSERT INTO model_assumptions VALUES
(1, 'linear_calibration_curve', 'Uses ordinary least squares and assumes a linear instrument response.'),
(2, 'noise_snr_simulation', 'Uses additive Gaussian noise and known clean signal for demonstration.'),
(3, 'uncertainty_propagation', 'Uses independent voltage and current uncertainties for R = V/I.'),
(4, 'monte_carlo_uncertainty', 'Uses normal input distributions for voltage and current.'),
(5, 'fourier_noise_diagnostics', 'Requires previously generated synthetic signals and assumes uniform sampling.'),
(6, 'bayesian_measurement_update', 'Uses normal prior and normal likelihood with known observation standard deviation.'),
(7, 'experimental_physics_schema', 'Stores educational metadata rather than certified laboratory records.');

INSERT INTO simulation_runs VALUES
(1, 'experimental-physics-measurement-noise-calibration-and-inference', 'noise_snr_uncertainty', 'synthetic_signal_simulation', 'noise signal cases', 'signal table SNR summary and resistance uncertainty', '2026-04-25'),
(2, 'experimental-physics-measurement-noise-calibration-and-inference', 'calibration_curve_fit', 'ordinary_least_squares', 'calibration points', 'calibration coefficients and residuals', '2026-04-25'),
(3, 'experimental-physics-measurement-noise-calibration-and-inference', 'monte_carlo_uncertainty', 'monte_carlo_sampling', 'voltage and current normal input distributions', 'resistance uncertainty distribution summary', '2026-04-25'),
(4, 'experimental-physics-measurement-noise-calibration-and-inference', 'fourier_noise_diagnostics', 'fft_spectrum', 'synthetic measured signals', 'single-sided amplitude spectrum table', '2026-04-25'),
(5, 'experimental-physics-measurement-noise-calibration-and-inference', 'bayesian_measurement_update', 'normal_normal_update', 'repeated voltage observations', 'posterior mean and uncertainty', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

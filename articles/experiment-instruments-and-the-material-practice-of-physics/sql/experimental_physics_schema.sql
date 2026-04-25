-- Experiment, Instruments, and the Material Practice of Physics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores experiment metadata, instruments, calibration records,
-- measurement-chain stages, uncertainty budgets, analysis scripts,
-- source notes, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS experiments;
DROP TABLE IF EXISTS instruments;
DROP TABLE IF EXISTS calibration_records;
DROP TABLE IF EXISTS measurement_chain_steps;
DROP TABLE IF EXISTS uncertainty_budget;
DROP TABLE IF EXISTS analysis_scripts;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE experiments (
    experiment_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    experiment_name TEXT NOT NULL,
    measurand TEXT NOT NULL,
    measurement_model TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE instruments (
    instrument_id TEXT PRIMARY KEY,
    instrument_name TEXT NOT NULL,
    measured_quantity TEXT NOT NULL,
    resolution REAL,
    unit TEXT,
    calibration_status TEXT,
    notes TEXT
);

CREATE TABLE calibration_records (
    calibration_id INTEGER PRIMARY KEY,
    instrument_id TEXT NOT NULL,
    calibration_date TEXT,
    reference_standard TEXT,
    calibration_model TEXT,
    calibration_uncertainty TEXT,
    FOREIGN KEY (instrument_id) REFERENCES instruments(instrument_id)
);

CREATE TABLE measurement_chain_steps (
    step_id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL,
    chain_step INTEGER NOT NULL,
    stage TEXT NOT NULL,
    input_signal TEXT,
    output_signal TEXT,
    possible_uncertainty_source TEXT,
    FOREIGN KEY (experiment_id) REFERENCES experiments(experiment_id)
);

CREATE TABLE uncertainty_budget (
    budget_id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL,
    input_quantity TEXT NOT NULL,
    estimate REAL NOT NULL,
    standard_uncertainty REAL NOT NULL,
    unit TEXT NOT NULL,
    evaluation_type TEXT,
    sensitivity_coefficient REAL,
    contribution REAL,
    FOREIGN KEY (experiment_id) REFERENCES experiments(experiment_id)
);

CREATE TABLE analysis_scripts (
    script_id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL,
    script_path TEXT NOT NULL,
    language TEXT NOT NULL,
    purpose TEXT NOT NULL,
    reproducibility_note TEXT,
    FOREIGN KEY (experiment_id) REFERENCES experiments(experiment_id)
);

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    topic TEXT NOT NULL,
    note TEXT
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

INSERT INTO experiments (
    experiment_id,
    article_slug,
    experiment_name,
    measurand,
    measurement_model,
    notes
) VALUES
(1, 'experiment-instruments-and-the-material-practice-of-physics', 'pendulum_gravity_estimate', 'gravitational acceleration', 'g = 4*pi^2*L/T^2', 'teaching example for uncertainty propagation'),
(2, 'experiment-instruments-and-the-material-practice-of-physics', 'linear_calibration', 'calibrated voltage', 'reference_value = slope*reading + intercept', 'teaching example for calibration residuals'),
(3, 'experiment-instruments-and-the-material-practice-of-physics', 'detector_signal_chain', 'triggered signal', 'output = gain*(signal + noise) + offset', 'teaching example for detector response');

INSERT INTO instruments (
    instrument_id,
    instrument_name,
    measured_quantity,
    resolution,
    unit,
    calibration_status,
    notes
) VALUES
('I001', 'meter stick', 'length', 0.001, 'm', 'illustrative', 'current for teaching example'),
('I002', 'manual stopwatch', 'time', 0.01, 's', 'illustrative', 'reaction-time uncertainty dominates'),
('I003', 'digital voltmeter', 'voltage', 0.001, 'V', 'illustrative', 'used in calibration example'),
('I004', 'photodiode detector', 'optical signal', 0.000001, 'A', 'illustrative', 'signal-chain example'),
('I005', 'oscilloscope', 'voltage waveform', 0.001, 'V', 'illustrative', 'digitized waveform example');

INSERT INTO calibration_records (
    calibration_id,
    instrument_id,
    calibration_date,
    reference_standard,
    calibration_model,
    calibration_uncertainty
) VALUES
(1, 'I001', '2026-04-24', 'length reference example', 'offset checked against reference length', '0.001 m'),
(2, 'I002', '2026-04-24', 'time reference example', 'manual timing uncertainty estimated from repeated trials', '0.05 s per 10 oscillations'),
(3, 'I003', '2026-04-24', 'voltage reference example', 'linear calibration y = ax + b', 'illustrative');

INSERT INTO measurement_chain_steps (
    step_id,
    experiment_id,
    chain_step,
    stage,
    input_signal,
    output_signal,
    possible_uncertainty_source
) VALUES
(1, 1, 1, 'physical system', 'pendulum motion', 'periodic motion', 'small-angle approximation'),
(2, 1, 2, 'observer or sensor', 'oscillation count', 'time interval', 'reaction time or trigger threshold'),
(3, 1, 3, 'instrument', 'stopwatch display', 'digital time reading', 'resolution and latency'),
(4, 1, 4, 'data recording', 'display reading', 'tabulated value', 'transcription error'),
(5, 1, 5, 'analysis', 'tabulated value', 'period estimate', 'statistical variation'),
(6, 1, 6, 'measurement model', 'length and period', 'g estimate', 'model approximation and propagated uncertainty');

INSERT INTO uncertainty_budget (
    budget_id,
    experiment_id,
    input_quantity,
    estimate,
    standard_uncertainty,
    unit,
    evaluation_type,
    sensitivity_coefficient,
    contribution
) VALUES
(1, 1, 'length_m', 0.75, 0.001, 'm', 'Type B illustrative', 13.018, 0.000169),
(2, 1, 'period_s', 1.741, 0.005, 's', 'Type A/B illustrative', -11.214, 0.003144);

INSERT INTO analysis_scripts (
    script_id,
    experiment_id,
    script_path,
    language,
    purpose,
    reproducibility_note
) VALUES
(1, 1, 'python/pendulum_uncertainty.py', 'Python', 'first-order and Monte Carlo uncertainty propagation', 'uses fixed random seed'),
(2, 1, 'r/pendulum_repeated_measurements.R', 'R', 'repeated-measurement summary', 'reads CSV from data folder'),
(3, 2, 'python/calibration_fit_and_residuals.py', 'Python', 'linear calibration fitting', 'uses reproducible input CSV'),
(4, 3, 'python/detector_signal_chain_simulation.py', 'Python', 'signal-chain simulation', 'threshold and gain stored in input CSV');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'NIST Measurement Uncertainty', 'https://www.nist.gov/itl/sed/topic-areas/measurement-uncertainty', 'measurement uncertainty', 'NIST overview of GUM and VIM uncertainty definitions.'),
(2, 'NIST Uncertainty Machine', 'https://uncertainty.nist.gov/', 'measurement models', 'Web-based uncertainty evaluation for y=f(x0,...,xn).'),
(3, 'BIPM SI Brochure', 'https://www.bipm.org/en/si-brochure-9', 'SI units', 'International System of Units reference.'),
(4, 'JCGM GUM-6', 'https://www.bipm.org/en/doi/10.59161/jcgmgum-6-2020', 'measurement models', 'Guide to developing and using measurement models.'),
(5, 'MIT Junior Lab Notebook Requirements', 'https://ocw.mit.edu/courses/8-13-14-experimental-physics-i-ii-junior-lab-fall-2016-spring-2017/pages/requirements-for-experimental-notebooks/', 'laboratory notebooks', 'Raw data tables, units, uncertainties, and analysis scripts documentation.'),
(6, 'CERN How a Detector Works', 'https://home.cern/science/experiments/how-detector-works', 'detectors', 'Detector systems gather clues about particle properties.'),
(7, 'CERN Preserving Particle Physics Data', 'https://home.cern/news/news/experiments/preserving-particle-physics-data', 'data preservation', 'Trigger systems and long-term particle physics data preservation.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'experiment-instruments-and-the-material-practice-of-physics', 'pendulum_uncertainty', 'first_order_and_monte_carlo', 'L=0.75 m, repeated timing values', 'g estimate and uncertainty', '2026-04-24'),
(2, 'experiment-instruments-and-the-material-practice-of-physics', 'linear_calibration', 'least_squares', 'six calibration points', 'slope, intercept, residuals', '2026-04-24'),
(3, 'experiment-instruments-and-the-material-practice-of-physics', 'detector_signal_chain', 'threshold_model', 'gain, offset, noise, threshold', 'trigger decisions and SNR', '2026-04-24');

SELECT
    experiment_name,
    measurand,
    measurement_model
FROM experiments
ORDER BY experiment_id;

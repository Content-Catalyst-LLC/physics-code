-- Physics Introductory Data Model
--
-- This SQL workflow is intentionally kept in the GitHub repository,
-- not in the article body.
--
-- It supports experiment logs, measured values, model assumptions,
-- simulation runs, and parameter sweeps.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS experiment_runs;
DROP TABLE IF EXISTS simulation_runs;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS parameter_sweeps;

CREATE TABLE experiment_runs (
    experiment_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    experiment_name TEXT NOT NULL,
    instrument_notes TEXT,
    operator_notes TEXT,
    created_at TEXT NOT NULL
);

CREATE TABLE measurements (
    measurement_id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL,
    trial INTEGER NOT NULL,
    length_m REAL NOT NULL,
    period_s REAL NOT NULL,
    temperature_c REAL,
    release_angle_deg REAL,
    notes TEXT,
    FOREIGN KEY (experiment_id) REFERENCES experiment_runs(experiment_id)
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
);

CREATE TABLE simulation_runs (
    simulation_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    numerical_method TEXT,
    parameter_name TEXT NOT NULL,
    parameter_value REAL NOT NULL,
    parameter_unit TEXT NOT NULL,
    output_metric TEXT NOT NULL,
    output_value REAL NOT NULL,
    output_unit TEXT NOT NULL
);

CREATE TABLE parameter_sweeps (
    sweep_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    sweep_name TEXT NOT NULL,
    parameter_name TEXT NOT NULL,
    parameter_min REAL NOT NULL,
    parameter_max REAL NOT NULL,
    parameter_unit TEXT NOT NULL,
    n_points INTEGER NOT NULL
);

INSERT INTO experiment_runs (
    experiment_id,
    article_slug,
    experiment_name,
    instrument_notes,
    operator_notes,
    created_at
) VALUES (
    1,
    'what-is-physics',
    'Introductory pendulum timing experiment',
    'Stopwatch timing; meter-stick length estimate; small-angle release',
    'Illustrative dataset for physics article workflow',
    '2026-04-24'
);

INSERT INTO measurements (
    measurement_id,
    experiment_id,
    trial,
    length_m,
    period_s,
    temperature_c,
    release_angle_deg,
    notes
) VALUES
(1, 1, 1, 0.50, 1.420, 22.1, 5.0, 'small-angle manual timing'),
(2, 1, 2, 0.50, 1.418, 22.1, 5.0, 'small-angle manual timing'),
(3, 1, 3, 0.50, 1.424, 22.2, 5.0, 'small-angle manual timing'),
(4, 1, 4, 0.75, 1.739, 22.2, 5.0, 'small-angle manual timing'),
(5, 1, 5, 0.75, 1.735, 22.3, 5.0, 'small-angle manual timing'),
(6, 1, 6, 0.75, 1.742, 22.3, 5.0, 'small-angle manual timing'),
(7, 1, 7, 1.00, 2.006, 22.4, 5.0, 'small-angle manual timing'),
(8, 1, 8, 1.00, 2.010, 22.4, 5.0, 'small-angle manual timing'),
(9, 1, 9, 1.00, 2.004, 22.5, 5.0, 'small-angle manual timing');

INSERT INTO model_assumptions (
    assumption_id,
    article_slug,
    model_name,
    assumption_text
) VALUES
(1, 'what-is-physics', 'small_angle_pendulum', 'Angular displacement is small enough that sin(theta) is approximately theta.'),
(2, 'what-is-physics', 'small_angle_pendulum', 'Air resistance and pivot friction are neglected.'),
(3, 'what-is-physics', 'small_angle_pendulum', 'The pendulum bob is approximated as a point mass.'),
(4, 'what-is-physics', 'small_angle_pendulum', 'The string or rod is treated as massless and inextensible.'),
(5, 'what-is-physics', 'small_angle_pendulum', 'Local gravitational acceleration is treated as constant.');

INSERT INTO simulation_runs (
    simulation_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_name,
    parameter_value,
    parameter_unit,
    output_metric,
    output_value,
    output_unit
) VALUES
(1, 'what-is-physics', 'small_angle_pendulum', 'closed_form', 'length', 0.50, 'm', 'period', 1.4192, 's'),
(2, 'what-is-physics', 'small_angle_pendulum', 'closed_form', 'length', 0.75, 'm', 'period', 1.7381, 's'),
(3, 'what-is-physics', 'small_angle_pendulum', 'closed_form', 'length', 1.00, 'm', 'period', 2.0064, 's');

INSERT INTO parameter_sweeps (
    sweep_id,
    article_slug,
    model_name,
    sweep_name,
    parameter_name,
    parameter_min,
    parameter_max,
    parameter_unit,
    n_points
) VALUES (
    1,
    'what-is-physics',
    'small_angle_pendulum',
    'length_to_period_sweep',
    'length',
    0.10,
    2.00,
    'm',
    200
);

SELECT
    m.length_m,
    COUNT(*) AS n_measurements,
    AVG(m.period_s) AS mean_observed_period_s,
    s.output_value AS modeled_period_s,
    AVG(m.period_s) - s.output_value AS mean_residual_s
FROM measurements m
JOIN simulation_runs s
    ON s.parameter_value = m.length_m
WHERE s.model_name = 'small_angle_pendulum'
GROUP BY
    m.length_m,
    s.output_value
ORDER BY
    m.length_m;

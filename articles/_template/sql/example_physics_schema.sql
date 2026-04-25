DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE simulation_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    parameter_name TEXT NOT NULL,
    parameter_value REAL NOT NULL,
    output_metric TEXT NOT NULL,
    output_value REAL NOT NULL
);

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    parameter_name,
    parameter_value,
    output_metric,
    output_value
) VALUES
(1, 'example-physics-article', 'kinetic_energy', 'mass_kg', 2.0, 'kinetic_energy_j', 16.0);

SELECT * FROM simulation_runs;

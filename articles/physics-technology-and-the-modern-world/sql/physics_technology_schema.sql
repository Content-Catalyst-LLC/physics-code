-- Physics, Technology, and the Modern World Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores technology domains, physical relations, model assumptions,
-- simulation runs, measurement examples, and source notes.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS technology_domains;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS timing_measurements;
DROP TABLE IF EXISTS simulation_runs;
DROP TABLE IF EXISTS source_notes;

CREATE TABLE technology_domains (
    domain_id INTEGER PRIMARY KEY,
    domain_name TEXT NOT NULL,
    physics_foundation TEXT NOT NULL,
    example_system TEXT NOT NULL,
    measurement_dependency TEXT NOT NULL
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    technology_use TEXT NOT NULL
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
);

CREATE TABLE timing_measurements (
    measurement_id INTEGER PRIMARY KEY,
    timing_error_ns REAL NOT NULL,
    position_error_m REAL NOT NULL,
    system_context TEXT NOT NULL,
    notes TEXT
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

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    topic TEXT NOT NULL,
    note TEXT
);

INSERT INTO technology_domains (
    domain_id,
    domain_name,
    physics_foundation,
    example_system,
    measurement_dependency
) VALUES
(1, 'semiconductors', 'quantum mechanics and solid-state physics', 'microprocessor', 'dimensional and electrical metrology'),
(2, 'photonics', 'electromagnetism and optics', 'fiber optic communication', 'optical power and alignment'),
(3, 'navigation', 'relativity, timing, and signal propagation', 'GPS receiver', 'clock synchronization'),
(4, 'medical imaging', 'radiation, magnetism, acoustics, and detector physics', 'MRI, CT, PET, ultrasound', 'calibration and dose measurement'),
(5, 'energy', 'thermodynamics, electromagnetism, and nuclear physics', 'power grid and generation', 'efficiency and power quality'),
(6, 'space systems', 'orbital mechanics, radiation, and detector physics', 'satellite instruments', 'radiometry and timing');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    technology_use
) VALUES
(1, 'timing_to_distance', 'd = c * t', 'd,c,t', 'navigation and ranging'),
(2, 'timing_uncertainty_to_position_uncertainty', 'delta_d = c * delta_t', 'delta_d,c,delta_t', 'GPS and synchronization uncertainty'),
(3, 'power_from_energy', 'P = E / t', 'P,E,t', 'power and energy systems'),
(4, 'electrical_power', 'P = I * V', 'P,I,V', 'electrical devices and power electronics'),
(5, 'rc_delay', 'tau = R * C', 'tau,R,C', 'semiconductor and circuit timing'),
(6, 'efficiency', 'eta = useful_output / input', 'eta,output,input', 'energy conversion and systems analysis');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'timing_to_distance', 'Signal propagation is approximated using the speed of light in vacuum.'),
(2, 'timing_to_distance', 'Atmospheric effects, multipath, receiver noise, and geometry are ignored.'),
(3, 'power_from_energy', 'Energy delivery is averaged over a fixed time interval.'),
(4, 'rc_delay', 'Delay is approximated using a first-order resistance-capacitance relation.'),
(5, 'heat_diffusion_1d', 'Thermal diffusivity is treated as constant.'),
(6, 'heat_diffusion_1d', 'The model is one-dimensional and uses a simplified explicit scheme.');

INSERT INTO timing_measurements (
    measurement_id,
    timing_error_ns,
    position_error_m,
    system_context,
    notes
) VALUES
(1, 1.0, 0.299792458, 'high_precision_timing', 'nanosecond-scale timing'),
(2, 5.0, 1.49896229, 'navigation_receiver', 'small timing error'),
(3, 10.0, 2.99792458, 'distributed_infrastructure', 'timing synchronization example'),
(4, 25.0, 7.49481145, 'communication_system', 'moderate timing uncertainty'),
(5, 50.0, 14.9896229, 'networked_sensor_system', 'large precision loss'),
(6, 100.0, 29.9792458, 'low_precision_timing', 'substantial navigation error');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'physics-technology-and-the-modern-world', 'timing_to_distance', 'closed_form', 'timing errors from 1 to 100 ns', 'position uncertainty in meters', '2026-04-24'),
(2, 'physics-technology-and-the-modern-world', 'power_from_energy', 'closed_form', 'energy from 1 to 500 J over 5 s', 'power in watts', '2026-04-24'),
(3, 'physics-technology-and-the-modern-world', 'rc_delay', 'parameter_sweep', 'R and C sweep', 'delay in seconds and picoseconds', '2026-04-24'),
(4, 'physics-technology-and-the-modern-world', 'heat_diffusion_1d', 'explicit_finite_difference', '1D thermal diffusion', 'temperature over position and time', '2026-04-24');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'NIST CHIPS Metrology Program', 'https://www.nist.gov/chips/research-development-programs/metrology-program', 'semiconductor metrology', 'Measurement science for microelectronic materials, devices, circuits, and systems.'),
(2, 'NASA Physical Sciences Program', 'https://science.nasa.gov/biological-physical/programs/physical-sciences/', 'space physical science', 'Physical sciences research in microgravity and space environments.'),
(3, 'DOE Office of Science Microelectronics', 'https://science.osti.gov/Initiatives/Microelectronics', 'microelectronics', 'DOE scientific role in microelectronics.'),
(4, 'NIST Time and Frequency', 'https://www.nist.gov/time-frequency', 'time standards', 'Official U.S. time and frequency metrology.'),
(5, 'CERN Contribute to Society', 'https://home.cern/about/what-we-do/our-impact', 'technology transfer', 'CERN technologies and expertise transferred to society.');

SELECT
    domain_name,
    physics_foundation,
    example_system
FROM technology_domains
ORDER BY domain_id;

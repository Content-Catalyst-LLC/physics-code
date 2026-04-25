-- Cosmology and the History of the Universe Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores cosmic eras, cosmological relations, model assumptions,
-- sample parameters, source notes, and model-run metadata.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS cosmic_eras;
DROP TABLE IF EXISTS cosmological_relations;
DROP TABLE IF EXISTS cosmological_parameters;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE cosmic_eras (
    era_id INTEGER PRIMARY KEY,
    era_name TEXT NOT NULL,
    approximate_time TEXT NOT NULL,
    physical_significance TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE cosmological_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE cosmological_parameters (
    parameter_id INTEGER PRIMARY KEY,
    parameter_name TEXT NOT NULL,
    parameter_value REAL NOT NULL,
    parameter_unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE model_assumptions (
    assumption_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    assumption_text TEXT NOT NULL
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

INSERT INTO cosmic_eras (
    era_id,
    era_name,
    approximate_time,
    physical_significance,
    notes
) VALUES
(1, 'Inflationary or extremely early phase', 'fraction of a second', 'rapid expansion and seed fluctuations', 'model-dependent earliest phase'),
(2, 'Big Bang nucleosynthesis', 'first few minutes', 'formation of light nuclei', 'hydrogen helium and trace lithium'),
(3, 'Plasma epoch', 'before about 380000 years', 'matter and radiation tightly coupled', 'universe opaque to photons'),
(4, 'Recombination and CMB release', 'about 380000 years', 'neutral atoms form and photons travel freely', 'oldest observable light'),
(5, 'Dark ages', 'after CMB before first stars', 'neutral gas with no stars', 'pre-stellar universe'),
(6, 'First stars and galaxies', 'hundreds of millions of years', 'first luminous structures form', 'cosmic dawn'),
(7, 'Reionization', 'first billion years approximately', 'early light ionizes intergalactic gas', 'universe becomes transparent to UV light'),
(8, 'Structure growth', 'billions of years', 'galaxies clusters filaments and voids develop', 'cosmic web emerges'),
(9, 'Late accelerated expansion', 'recent cosmic history', 'dark energy dominates expansion', 'active frontier');

INSERT INTO cosmological_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'low_redshift_hubble_relation', 'v = H0 * d', 'v,H0,d', 'low-redshift expansion intuition'),
(2, 'redshift_wavelength_relation', '1 + z = lambda_obs / lambda_emit', 'z,lambda_obs,lambda_emit', 'wavelength stretching'),
(3, 'scale_factor_from_redshift', 'a = 1 / (1 + z)', 'a,z', 'relative cosmic expansion'),
(4, 'radiation_temperature_scaling', 'T(z) = T0 * (1 + z)', 'T,T0,z', 'radiation cools as universe expands'),
(5, 'flat_lcdm_expansion', 'H(z)=H0 sqrt(Omega_m(1+z)^3 + Omega_r(1+z)^4 + Omega_lambda)', 'H,H0,Omega_m,Omega_r,Omega_lambda,z', 'simplified ΛCDM expansion rate');

INSERT INTO cosmological_parameters (
    parameter_id,
    parameter_name,
    parameter_value,
    parameter_unit,
    notes
) VALUES
(1, 'H0', 70.0, 'km/s/Mpc', 'representative educational value'),
(2, 'T0', 2.7255, 'K', 'present CMB temperature approximate'),
(3, 'Omega_m', 0.315, 'dimensionless', 'sample matter density parameter'),
(4, 'Omega_r', 0.00009, 'dimensionless', 'sample radiation density parameter'),
(5, 'Omega_lambda', 0.685, 'dimensionless', 'sample dark energy density parameter');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'hubble_relation', 'Low-redshift approximation is used.'),
(2, 'scale_factor_conversion', 'Present scale factor is normalized to 1.'),
(3, 'radiation_temperature_scaling', 'Radiation temperature scales inversely with the scale factor.'),
(4, 'flat_lcdm_expansion', 'Spatial curvature is set to zero.'),
(5, 'flat_lcdm_expansion', 'Dark energy is treated as a cosmological constant.'),
(6, 'flat_lcdm_expansion', 'The workflow is educational and not a precision inference pipeline.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'NASA Cosmic History', 'https://science.nasa.gov/universe/overview/', 'cosmic history', 'NASA overview of cosmic history and major eras.'),
(2, 'ESA Cosmic Eras', 'https://www.esa.int/Science_Exploration/Space_Science/Cosmic_eras', 'cosmic eras', 'ESA overview of cosmic eras including recombination.'),
(3, 'ESA Planck and the CMB', 'https://www.esa.int/Science_Exploration/Space_Science/Planck/Planck_and_the_cosmic_microwave_background', 'CMB', 'ESA Planck explanation of recombination and CMB release.'),
(4, 'Berkeley Lab DESI 2025', 'https://newscenter.lbl.gov/2025/03/19/new-desi-results-strengthen-hints-that-dark-energy-may-evolve/', 'dark energy', 'DESI results and evolving dark-energy hints.'),
(5, 'NIST Cosmic Distances', 'https://www.nist.gov/how-do-you-measure-it/how-do-you-measure-distance-moon-planets-stars-and-beyond', 'measurement', 'NIST explanation of cosmic distance measurement methods.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'cosmology-and-the-history-of-the-universe', 'hubble_relation', 'closed_form', 'distances from 10 to 500 Mpc', 'recessional velocity table', '2026-04-24'),
(2, 'cosmology-and-the-history-of-the-universe', 'scale_factor_conversion', 'closed_form', 'redshift from 0 to 1100', 'scale-factor table', '2026-04-24'),
(3, 'cosmology-and-the-history-of-the-universe', 'radiation_temperature_scaling', 'closed_form', 'redshift from 0 to 1100', 'temperature table', '2026-04-24'),
(4, 'cosmology-and-the-history-of-the-universe', 'flat_lcdm_expansion', 'closed_form', 'sample Ω parameters', 'H(z) table', '2026-04-24');

SELECT
    era_name,
    approximate_time,
    physical_significance
FROM cosmic_eras
ORDER BY era_id;

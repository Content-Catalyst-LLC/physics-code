-- Measurement, Mathematics, and the Structure of Physical Inquiry Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, quantities, dimensions, pendulum measurements,
-- measurement models, traceability metadata, source notes, model assumptions,
-- and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS dimensional_quantities;
DROP TABLE IF EXISTS pendulum_measurements;
DROP TABLE IF EXISTS measurement_models;
DROP TABLE IF EXISTS traceability_metadata;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE constants (
    constant_id INTEGER PRIMARY KEY,
    constant_name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE dimensional_quantities (
    quantity_id INTEGER PRIMARY KEY,
    quantity_name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    dimension_text TEXT NOT NULL,
    si_unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE pendulum_measurements (
    trial INTEGER PRIMARY KEY,
    length_m REAL NOT NULL,
    time_10_oscillations_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE measurement_models (
    model_id INTEGER PRIMARY KEY,
    model_or_concept TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    key_quantity TEXT NOT NULL,
    limitation TEXT
);

CREATE TABLE traceability_metadata (
    traceability_id INTEGER PRIMARY KEY,
    item TEXT NOT NULL,
    reference TEXT NOT NULL,
    method TEXT NOT NULL,
    uncertainty_note TEXT,
    notes TEXT
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
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

INSERT INTO constants (
    constant_id,
    constant_name,
    symbol,
    value,
    unit,
    notes
) VALUES
(1, 'standard gravity', 'g0', 9.80665, 'm s^-2', 'standard acceleration due to gravity'),
(2, 'pi', 'pi', 3.141592653589793, 'dimensionless', 'mathematical constant'),
(3, 'meter', 'm', 1.0, 'm', 'SI unit of length'),
(4, 'second', 's', 1.0, 's', 'SI unit of time'),
(5, 'kilogram', 'kg', 1.0, 'kg', 'SI unit of mass'),
(6, 'newton', 'N', 1.0, 'kg m s^-2', 'SI unit of force'),
(7, 'joule', 'J', 1.0, 'kg m^2 s^-2', 'SI unit of energy');

INSERT INTO dimensional_quantities (
    quantity_id,
    quantity_name,
    symbol,
    dimension_text,
    si_unit,
    notes
) VALUES
(1, 'length', 'L', 'L', 'm', 'base spatial dimension'),
(2, 'time', 'T', 'T', 's', 'base temporal dimension'),
(3, 'mass', 'M', 'M', 'kg', 'base inertial dimension'),
(4, 'velocity', 'v', 'L T^-1', 'm s^-1', 'rate of change of position'),
(5, 'acceleration', 'a', 'L T^-2', 'm s^-2', 'rate of change of velocity'),
(6, 'force', 'F', 'M L T^-2', 'N', 'Newtonian interaction dimension'),
(7, 'energy', 'E', 'M L^2 T^-2', 'J', 'work and energy dimension'),
(8, 'power', 'P', 'M L^2 T^-3', 'W', 'energy transfer rate'),
(9, 'frequency', 'f', 'T^-1', 'Hz', 'cycles per unit time'),
(10, 'pressure', 'p', 'M L^-1 T^-2', 'Pa', 'force per area');

INSERT INTO pendulum_measurements (
    trial,
    length_m,
    time_10_oscillations_s,
    notes
) VALUES
(1, 0.75, 17.41, 'repeated pendulum timing'),
(2, 0.75, 17.36, 'repeated pendulum timing'),
(3, 0.75, 17.45, 'repeated pendulum timing'),
(4, 0.75, 17.39, 'repeated pendulum timing'),
(5, 0.75, 17.43, 'repeated pendulum timing'),
(6, 0.75, 17.38, 'repeated pendulum timing'),
(7, 0.75, 17.40, 'repeated pendulum timing'),
(8, 0.75, 17.42, 'repeated pendulum timing');

INSERT INTO measurement_models (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'repeated timing', 'estimate period and uncertainty', 'mean period', 'limited sample size'),
(2, 'small-angle pendulum', 'estimate g from length and period', 'g', 'requires small angle and ideal conditions'),
(3, 'uncertainty propagation', 'derive output uncertainty', 'u_c', 'first-order approximation'),
(4, 'dimensional analysis', 'check model coherence', 'dimension vector', 'does not replace physical derivation'),
(5, 'nonlinear pendulum', 'compare approximation with fuller model', 'period shift', 'still idealized without damping'),
(6, 'residual analysis', 'check model fit', 'residuals', 'depends on measurement quality'),
(7, 'traceability metadata', 'document measurement chain', 'source and calibration references', 'illustrative scaffold only');

INSERT INTO traceability_metadata (
    traceability_id,
    item,
    reference,
    method,
    uncertainty_note,
    notes
) VALUES
(1, 'pendulum length', 'SI meter', 'calibrated ruler or length standard', 'example u_L = 0.001 m', 'illustrative traceability note'),
(2, 'timing', 'SI second', 'digital timer or video frame rate', 'estimated from repeated timing', 'illustrative traceability note'),
(3, 'gravity estimate', 'derived from L and T', 'measurement model g=4pi^2L/T^2', 'propagated from L and T', 'illustrative derived quantity'),
(4, 'period estimate', 'repeated 10-oscillation timing', 'mean of repeated trials', 'standard error of mean', 'illustrative repeated measurement');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'velocity dimension', '[v] = L T^-1', 'v,L,T', 'dimension of velocity'),
(2, 'force dimension', '[F] = M L T^-2', 'F,M,L,T', 'dimension of force'),
(3, 'energy dimension', '[E] = M L^2 T^-2', 'E,M,L,T', 'dimension of energy'),
(4, 'velocity', 'v = dx/dt', 'v,x,t', 'rate of change of position'),
(5, 'acceleration', 'a = d2x/dt2', 'a,x,t', 'rate of change of velocity'),
(6, 'constant acceleration model', 'x(t)=x0+v0t+1/2at^2', 'x,x0,v0,a,t', 'kinematic model'),
(7, 'pendulum period', 'T = 2 pi sqrt(L/g)', 'T,L,g', 'small-angle pendulum period'),
(8, 'gravity estimate', 'g = 4 pi^2 L / T^2', 'g,L,T', 'gravity inferred from pendulum length and period'),
(9, 'uncertainty propagation', 'u_c^2(y)=sum_i (partial f/partial x_i)^2 u^2(x_i)', 'u_c,y,x_i', 'first-order propagation of independent standard uncertainties');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'BIPM SI Brochure PDF', 'BIPM', 'official SI PDF', 'https://www.bipm.org/documents/20126/41483022/SI-Brochure-9-EN.pdf'),
(3, 'JCGM 100 2008', 'BIPM/JCGM', 'Guide to the expression of uncertainty in measurement', 'https://www.bipm.org/en/doi/10.59161/jcgm100-2008e'),
(4, 'NIST TN 1297', 'NIST', 'uncertainty evaluation and expression guidance', 'https://www.nist.gov/pml/nist-technical-note-1297'),
(5, 'NIST SP 330', 'NIST', 'International System of Units reference', 'https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.330-2019.pdf'),
(6, 'NIST SP 811', 'NIST', 'SI usage guide', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(7, 'NIST CODATA', 'NIST', 'fundamental constants reference', 'https://www.nist.gov/programs-projects/codata-values-fundamental-physical-constants'),
(8, 'MIT Classical Mechanics', 'MIT OpenCourseWare', 'classical mechanics course', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'pendulum_measurement_uncertainty', 'Uses repeated timing measurements and first-order uncertainty propagation.'),
(2, 'pendulum_measurement_uncertainty', 'Assumes independent uncertainty sources for length and period.'),
(3, 'nonlinear_pendulum_model', 'Compares ideal small-angle period to nonlinear pendulum simulation without damping.'),
(4, 'dimensional_reasoning_table', 'Uses M-L-T dimension vectors for common mechanics quantities.'),
(5, 'measurement_residual_summary', 'Summarizes residuals relative to the mean period, not a full hierarchical model.'),
(6, 'measurement_inquiry_schema', 'Stores educational metadata rather than a production laboratory information-management database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'measurement-mathematics-and-the-structure-of-physical-inquiry', 'pendulum_measurement_uncertainty', 'summary_statistics_and_first_order_propagation', 'L=0.75 m and repeated 10-oscillation timing', 'g estimate and combined uncertainty', '2026-04-25'),
(2, 'measurement-mathematics-and-the-structure-of-physical-inquiry', 'nonlinear_pendulum_model', 'ode_integration', 'L=0.75 m and amplitudes 0.05..0.80 rad', 'small-angle vs nonlinear period comparison', '2026-04-25'),
(3, 'measurement-mathematics-and-the-structure-of-physical-inquiry', 'dimensional_reasoning_table', 'dimension_vector_table', 'M-L-T dimension convention', 'dimension vectors for common physics quantities', '2026-04-25'),
(4, 'measurement-mathematics-and-the-structure-of-physical-inquiry', 'measurement_residual_summary', 'residual_summary', 'repeated pendulum period measurements', 'residual table and summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

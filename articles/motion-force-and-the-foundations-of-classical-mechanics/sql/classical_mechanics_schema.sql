-- Motion, Force, and the Foundations of Classical Mechanics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, projectile cases, trajectory measurements,
-- force-time measurements, physical relations, source notes, model assumptions,
-- and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS projectile_cases;
DROP TABLE IF EXISTS trajectory_measurements;
DROP TABLE IF EXISTS force_time_measurements;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
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

CREATE TABLE projectile_cases (
    case_id TEXT PRIMARY KEY,
    initial_speed_m_per_s REAL NOT NULL,
    launch_angle_deg REAL NOT NULL,
    initial_height_m REAL NOT NULL,
    drag_coefficient_per_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE trajectory_measurements (
    point_id INTEGER PRIMARY KEY,
    time_s REAL NOT NULL,
    x_measured_m REAL NOT NULL,
    y_measured_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE force_time_measurements (
    point_id INTEGER PRIMARY KEY,
    time_s REAL NOT NULL,
    force_n REAL NOT NULL,
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

INSERT INTO constants (
    constant_id,
    constant_name,
    symbol,
    value,
    unit,
    notes
) VALUES
(1, 'standard gravity', 'g', 9.80665, 'm s^-2', 'standard acceleration due to gravity'),
(2, 'newton', 'N', 1.0, 'kg m s^-2', 'SI unit of force'),
(3, 'meter', 'm', 1.0, 'm', 'SI unit of length'),
(4, 'kilogram', 'kg', 1.0, 'kg', 'SI unit of mass'),
(5, 'second', 's', 1.0, 's', 'SI unit of time'),
(6, 'degree to radian', 'deg_to_rad', 0.0174532925199433, 'rad degree^-1', 'angle conversion factor');

INSERT INTO projectile_cases (
    case_id,
    initial_speed_m_per_s,
    launch_angle_deg,
    initial_height_m,
    drag_coefficient_per_m,
    notes
) VALUES
('base_ideal', 12.0, 45.0, 0.0, 0.0, 'article base ideal projectile'),
('low_angle', 12.0, 30.0, 0.0, 0.0, 'lower launch angle'),
('high_angle', 12.0, 60.0, 0.0, 0.0, 'higher launch angle'),
('fast_launch', 18.0, 45.0, 0.0, 0.0, 'higher initial speed'),
('drag_base', 12.0, 45.0, 0.0, 0.08, 'quadratic drag comparison'),
('high_drag', 12.0, 45.0, 0.0, 0.16, 'stronger drag comparison');

INSERT INTO trajectory_measurements (
    point_id,
    time_s,
    x_measured_m,
    y_measured_m,
    notes
) VALUES
(1, 0.00, 0.00, 0.00, 'illustrative measured-style point'),
(2, 0.10, 0.84, 0.80, 'illustrative measured-style point'),
(3, 0.20, 1.70, 1.50, 'illustrative measured-style point'),
(4, 0.30, 2.54, 2.10, 'illustrative measured-style point'),
(5, 0.40, 3.39, 2.60, 'illustrative measured-style point'),
(6, 0.50, 4.25, 3.00, 'illustrative measured-style point'),
(7, 0.60, 5.08, 3.30, 'illustrative measured-style point'),
(8, 0.70, 5.94, 3.52, 'illustrative measured-style point'),
(9, 0.80, 6.78, 3.60, 'illustrative measured-style point'),
(10, 0.90, 7.62, 3.55, 'illustrative measured-style point'),
(11, 1.00, 8.48, 3.45, 'illustrative measured-style point'),
(12, 1.10, 9.33, 3.18, 'illustrative measured-style point'),
(13, 1.20, 10.18, 2.82, 'illustrative measured-style point'),
(14, 1.30, 11.01, 2.36, 'illustrative measured-style point'),
(15, 1.40, 11.87, 1.80, 'illustrative measured-style point'),
(16, 1.50, 12.72, 1.12, 'illustrative measured-style point'),
(17, 1.60, 13.57, 0.36, 'illustrative measured-style point');

INSERT INTO force_time_measurements (
    point_id,
    time_s,
    force_n,
    notes
) VALUES
(1, 0.00, 0.0, 'impact-style impulse trace'),
(2, 0.01, 12.0, 'impact-style impulse trace'),
(3, 0.02, 35.0, 'impact-style impulse trace'),
(4, 0.03, 58.0, 'impact-style impulse trace'),
(5, 0.04, 42.0, 'impact-style impulse trace'),
(6, 0.05, 20.0, 'impact-style impulse trace'),
(7, 0.06, 5.0, 'impact-style impulse trace'),
(8, 0.07, 0.0, 'impact-style impulse trace');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'velocity', 'v = dr/dt', 'v,r,t', 'rate of change of position'),
(2, 'acceleration', 'a = d2r/dt2', 'a,r,t', 'rate of change of velocity'),
(3, 'Newton second law', 'F_net = m a', 'F,m,a', 'net force produces acceleration'),
(4, 'momentum', 'p = m v', 'p,m,v', 'quantity of motion'),
(5, 'momentum form of Newton second law', 'F_net = dp/dt', 'F,p,t', 'force as rate of change of momentum'),
(6, 'impulse', 'J = integral F dt = Delta p', 'J,F,t,p', 'time-integrated force changes momentum'),
(7, 'centripetal acceleration', 'a_c = v^2 / r', 'a_c,v,r', 'inward acceleration for circular motion'),
(8, 'projectile x motion', 'x(t) = x0 + v0 cos(theta) t', 'x,x0,v0,theta,t', 'horizontal ideal projectile position'),
(9, 'projectile y motion', 'y(t) = y0 + v0 sin(theta) t - 1/2 g t^2', 'y,y0,v0,theta,g,t', 'vertical ideal projectile position'),
(10, 'projectile range', 'R = v0^2 sin(2 theta) / g', 'R,v0,theta,g', 'flat-ground ideal projectile range');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'ideal projectile', 'parabolic motion without drag', 'range and height', 'neglects air resistance'),
(2, 'quadratic drag projectile', 'compare ideal and drag assumptions', 'trajectory and range', 'not calibrated aerodynamics'),
(3, 'Newton force model', 'convert net force to acceleration', 'F_net and m', 'requires complete force accounting'),
(4, 'impulse-momentum', 'integrate force over time', 'J and Delta p', 'depends on time resolution'),
(5, 'trajectory fit', 'compare measurement-style data with quadratic model', 'residuals', 'measurement noise simplified'),
(6, 'free-body reasoning', 'organize external forces', 'force components', 'diagram not directly encoded'),
(7, 'coordinate decomposition', 'simplify vector problems', 'components', 'depends on coordinate choice');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'BIPM SI Brochure PDF', 'BIPM', 'newton and SI derived units', 'https://www.bipm.org/documents/20126/41483022/SI-Brochure-9-EN.pdf'),
(3, 'NIST SI Guide', 'NIST', 'SI unit guidance and mass-weight distinction', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(4, 'NIST SP 330', 'NIST', 'International System of Units reference', 'https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.330-2019.pdf'),
(5, 'MIT Classical Mechanics', 'MIT OpenCourseWare', 'classical mechanics course', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/'),
(6, 'MIT Projectile Motion', 'MIT OpenCourseWare', 'projectile motion lesson', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/pages/week-1-kinematics/3-4-projectile-motion/'),
(7, 'MIT Newton Laws Chapter', 'MIT OpenCourseWare', 'Newton laws of motion', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/mit8_01scs22_chapter7.pdf'),
(8, 'Galileo Two New Sciences', 'Internet Archive', 'foundational mechanics source', 'https://archive.org/download/dialoguesconcern00galiuoft/dialoguesconcern00galiuoft.pdf'),
(9, 'Newton Principia', 'Internet Archive', 'foundational mechanics and gravitation source', 'https://archive.org/download/NewtonPrincipia_201701/The%20Principia%20Mathematical%20Principles%20of%20Natural%20Philosophy%20Isaac%20Newton.pdf');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'projectile_motion_models', 'Uses point-particle projectile motion with constant near-surface gravity.'),
(2, 'projectile_motion_models', 'Compares an ideal no-drag model with a compact quadratic drag teaching model.'),
(3, 'impulse_momentum_analysis', 'Uses trapezoidal integration of force-time measurements.'),
(4, 'newton_force_parameter_sweep', 'Applies F=ma under constant net force and constant mass assumptions.'),
(5, 'projectile_trajectory_fit', 'Uses simulated measurement-style data with small noise and a quadratic trajectory fit.'),
(6, 'classical_mechanics_schema', 'Stores educational metadata rather than a production mechanics database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'motion-force-and-the-foundations-of-classical-mechanics', 'projectile_motion_models', 'ode_integration', 'v0=12 m/s, theta=45 deg, g=9.80665 m/s^2, drag=0 or 0.08 per m', 'ideal and drag trajectory tables', '2026-04-25'),
(2, 'motion-force-and-the-foundations-of-classical-mechanics', 'impulse_momentum_analysis', 'trapezoidal_integration', 'force-time trace from 0 to 0.07 s', 'impulse and velocity-change summary', '2026-04-25'),
(3, 'motion-force-and-the-foundations-of-classical-mechanics', 'newton_force_parameter_sweep', 'closed_form_parameter_grid', 'masses 0.25..2 kg and forces 1..10 N', 'acceleration velocity and displacement table', '2026-04-25'),
(4, 'motion-force-and-the-foundations-of-classical-mechanics', 'projectile_trajectory_fit', 'quadratic_regression', 'v0=12 m/s and theta=45 deg with simulated measurement noise', 'fitted trajectory and residual summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

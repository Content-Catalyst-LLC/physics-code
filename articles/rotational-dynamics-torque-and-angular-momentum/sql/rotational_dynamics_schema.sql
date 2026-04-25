-- Rotational Dynamics, Torque, and Angular Momentum Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, rolling bodies, moments of inertia, torque profiles,
-- gyroscope cases, physical relations, source notes, model assumptions, and
-- simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS rolling_body_cases;
DROP TABLE IF EXISTS moment_of_inertia_shapes;
DROP TABLE IF EXISTS torque_time_profile;
DROP TABLE IF EXISTS gyroscope_cases;
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

CREATE TABLE rolling_body_cases (
    body_id INTEGER PRIMARY KEY,
    object_name TEXT NOT NULL,
    beta REAL NOT NULL,
    mass_kg REAL NOT NULL,
    radius_m REAL NOT NULL,
    height_drop_m REAL NOT NULL,
    incline_angle_deg REAL NOT NULL,
    notes TEXT
);

CREATE TABLE moment_of_inertia_shapes (
    shape_id INTEGER PRIMARY KEY,
    shape_name TEXT NOT NULL,
    beta_or_formula TEXT NOT NULL,
    axis TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE torque_time_profile (
    point_id INTEGER PRIMARY KEY,
    time_s REAL NOT NULL,
    applied_torque_n_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE gyroscope_cases (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    lever_arm_m REAL NOT NULL,
    moment_of_inertia_kg_m2 REAL NOT NULL,
    spin_omega_rad_per_s REAL NOT NULL,
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
(2, 'radian', 'rad', 1.0, 'dimensionless', 'SI named derived unit for plane angle'),
(3, 'newton metre', 'N m', 1.0, 'kg m^2 s^-2', 'SI unit expression for torque or moment of force'),
(4, 'joule', 'J', 1.0, 'kg m^2 s^-2', 'SI unit of energy; dimensionally same as N m but different meaning'),
(5, 'watt', 'W', 1.0, 'kg m^2 s^-3', 'SI unit of power');

INSERT INTO rolling_body_cases (
    body_id,
    object_name,
    beta,
    mass_kg,
    radius_m,
    height_drop_m,
    incline_angle_deg,
    notes
) VALUES
(1, 'hoop', 1.0, 1.0, 0.10, 1.0, 20.0, 'thin hoop approximation'),
(2, 'solid_disk', 0.5, 1.0, 0.10, 1.0, 20.0, 'solid disk or cylinder approximation'),
(3, 'solid_sphere', 0.4, 1.0, 0.10, 1.0, 20.0, 'solid sphere approximation'),
(4, 'thin_spherical_shell', 0.6666667, 1.0, 0.10, 1.0, 20.0, 'thin spherical shell approximation'),
(5, 'point_mass_sliding', 0.0, 1.0, 0.10, 1.0, 20.0, 'translation-only comparison');

INSERT INTO moment_of_inertia_shapes (
    shape_id,
    shape_name,
    beta_or_formula,
    axis,
    notes
) VALUES
(1, 'hoop', 'beta=1', 'central symmetry axis', 'I = M R^2'),
(2, 'solid_disk', 'beta=1/2', 'central symmetry axis', 'I = 1/2 M R^2'),
(3, 'solid_sphere', 'beta=2/5', 'diameter', 'I = 2/5 M R^2'),
(4, 'thin_spherical_shell', 'beta=2/3', 'diameter', 'I = 2/3 M R^2'),
(5, 'thin_rod_center', 'I=(1/12)ML^2', 'through center perpendicular to length', 'rod length L'),
(6, 'thin_rod_end', 'I=(1/3)ML^2', 'through one end perpendicular to length', 'parallel-axis example');

INSERT INTO torque_time_profile (
    point_id,
    time_s,
    applied_torque_n_m,
    notes
) VALUES
(1, 0.0, 0.0, 'ramp start'),
(2, 0.5, 0.4, 'ramp'),
(3, 1.0, 0.8, 'steady torque begins'),
(4, 2.0, 0.8, 'steady torque'),
(5, 3.0, 0.8, 'steady torque'),
(6, 4.0, 0.8, 'decline begins'),
(7, 5.0, 0.4, 'decline'),
(8, 6.0, 0.0, 'torque ends'),
(9, 7.0, 0.0, 'no applied torque'),
(10, 8.0, 0.0, 'no applied torque');

INSERT INTO gyroscope_cases (
    case_id,
    mass_kg,
    lever_arm_m,
    moment_of_inertia_kg_m2,
    spin_omega_rad_per_s,
    notes
) VALUES
('small_fast_rotor', 0.50, 0.08, 0.0020, 500.0, 'illustrative precession case'),
('medium_rotor', 1.00, 0.10, 0.0060, 300.0, 'illustrative precession case'),
('slow_heavy_rotor', 2.00, 0.12, 0.0200, 120.0, 'illustrative precession case');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'angular displacement', 'theta = s/r', 'theta,s,r', 'angle from arc length and radius'),
(2, 'angular velocity', 'omega = d theta / dt', 'omega,theta,t', 'rate of change of angular position'),
(3, 'angular acceleration', 'alpha = d omega / dt', 'alpha,omega,t', 'rate of change of angular velocity'),
(4, 'tangential speed', 'v = r omega', 'v,r,omega', 'linear speed of a point on rotating body'),
(5, 'moment of inertia', 'I = sum m_i r_i^2', 'I,m_i,r_i', 'rotational inertia from mass distribution'),
(6, 'torque', 'tau = r x F', 'tau,r,F', 'moment of force'),
(7, 'rotational dynamics', 'tau_net = I alpha', 'tau,I,alpha', 'fixed-axis rotational analogue of F=ma'),
(8, 'angular momentum', 'L = r x p', 'L,r,p', 'angular momentum of a point particle'),
(9, 'rigid-body angular momentum', 'L = I omega', 'L,I,omega', 'fixed-axis angular momentum about principal axis'),
(10, 'torque and angular momentum', 'tau_net = dL/dt', 'tau,L,t', 'net torque changes angular momentum'),
(11, 'rotational kinetic energy', 'K_rot = 1/2 I omega^2', 'K,I,omega', 'energy associated with rotation'),
(12, 'rolling constraint', 'v_cm = R omega', 'v_cm,R,omega', 'rolling without slipping'),
(13, 'rolling acceleration', 'a = g sin(theta)/(1+beta)', 'a,g,theta,beta', 'ideal rolling acceleration when I=betaMR^2');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'fixed-axis rotation', 'connect torque to angular acceleration', 'alpha', 'single principal axis assumed'),
(2, 'moment of inertia', 'encode mass distribution relative to axis', 'I', 'depends on chosen axis'),
(3, 'rolling without slipping', 'couple translation and rotation', 'v=R omega', 'no slip or rolling resistance'),
(4, 'angular momentum conservation', 'analyze torque-free rotational behavior', 'L', 'requires zero external torque about chosen point'),
(5, 'gyroscope precession', 'estimate precessional response', 'Omega', 'simplified steady-precession approximation'),
(6, 'energy partition', 'compare rolling bodies', 'K_rot and K_trans', 'ideal mechanical-energy conservation');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'MIT Classical Mechanics', 'MIT OpenCourseWare', 'classical mechanics course overview', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/'),
(2, 'MIT Week 10 Rotational Motion', 'MIT OpenCourseWare', 'rotational motion torque and moment of inertia', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/resources/week-10-introduction/'),
(3, 'MIT Week 11 Angular Momentum', 'MIT OpenCourseWare', 'angular momentum and angular impulse', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/pages/week-11-angular-momentum/'),
(4, 'MIT Week 12 Rolling', 'MIT OpenCourseWare', 'rolling kinematics dynamics and gyroscopes', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/pages/week-12-rotations-and-translation-rolling/'),
(5, 'MIT Chapter 19 Angular Momentum', 'MIT OpenCourseWare', 'angular momentum lecture note PDF', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/mit8_01scs22_chapter19.pdf'),
(6, 'NIST SI Guide', 'NIST', 'SI units and torque unit distinction', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(7, 'NIST SI Chapter 4', 'NIST', 'derived units and radian status', 'https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-4-two-classes-si-units-and-si-prefixes'),
(8, 'BIPM SI Brochure', 'BIPM', 'official SI framework', 'https://www.bipm.org/en/si-brochure-9');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'torque_driven_rotation', 'Uses fixed-axis rigid-body rotation with scalar moment of inertia.'),
(2, 'torque_driven_rotation', 'Includes simple linear rotational damping as a teaching scaffold.'),
(3, 'rolling_body_comparison', 'Assumes rolling without slipping and no rolling resistance.'),
(4, 'gyroscope_precession_scaffold', 'Uses simplified steady-precession estimate Omega = tau/L.'),
(5, 'rolling_energy_partition', 'Uses ideal mechanical-energy conservation for rolling bodies.'),
(6, 'rotational_dynamics_schema', 'Stores educational metadata rather than a production rigid-body dynamics database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'rotational-dynamics-torque-and-angular-momentum', 'torque_driven_rotation', 'ode_integration', 'solid disk M=2 kg R=0.25 m with time-varying torque and damping', 'angular position velocity momentum and energy table', '2026-04-25'),
(2, 'rotational-dynamics-torque-and-angular-momentum', 'rolling_body_comparison', 'closed_form_parameter_table', 'beta values for hoop disk sphere shell and sliding point-mass comparison', 'rolling acceleration speed and energy partition', '2026-04-25'),
(3, 'rotational-dynamics-torque-and-angular-momentum', 'gyroscope_precession_scaffold', 'closed_form_precession_estimate', 'three illustrative rotor cases', 'torque spin angular momentum and precession estimates', '2026-04-25'),
(4, 'rotational-dynamics-torque-and-angular-momentum', 'rolling_energy_partition', 'closed_form_table', 'rolling bodies on 20 degree incline with 1 m height drop', 'R rolling energy partition table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

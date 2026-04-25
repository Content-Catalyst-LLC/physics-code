-- Fluid Dynamics and the Physics of Flow Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores fluid properties, flow cases, Bernoulli cases, dimensionless
-- numbers, physical relations, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS fluid_properties;
DROP TABLE IF EXISTS pipe_flow_cases;
DROP TABLE IF EXISTS bernoulli_cases;
DROP TABLE IF EXISTS dimensionless_numbers;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE fluid_properties (
    fluid TEXT PRIMARY KEY,
    density_kg_per_m3 REAL NOT NULL,
    dynamic_viscosity_pa_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE pipe_flow_cases (
    case_id TEXT PRIMARY KEY,
    fluid TEXT NOT NULL,
    velocity_m_per_s REAL NOT NULL,
    characteristic_length_m REAL NOT NULL,
    notes TEXT
);

CREATE TABLE bernoulli_cases (
    case_id TEXT PRIMARY KEY,
    fluid TEXT NOT NULL,
    v1_m_per_s REAL NOT NULL,
    v2_m_per_s REAL NOT NULL,
    z1_m REAL NOT NULL,
    z2_m REAL NOT NULL,
    p1_pa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE dimensionless_numbers (
    number_name TEXT PRIMARY KEY,
    symbol TEXT NOT NULL,
    definition TEXT NOT NULL,
    primary_ratio TEXT NOT NULL,
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

INSERT INTO fluid_properties (
    fluid,
    density_kg_per_m3,
    dynamic_viscosity_pa_s,
    notes
) VALUES
('water_20c', 998.2, 0.001002, 'approximate water properties near 20 C'),
('air_20c', 1.204, 0.0000181, 'approximate dry air properties near 20 C'),
('engine_oil', 850.0, 0.20, 'illustrative viscous oil'),
('glycerin', 1260.0, 1.49, 'illustrative high-viscosity liquid'),
('blood_approx', 1060.0, 0.0035, 'simplified approximate whole-blood value for teaching only');

INSERT INTO pipe_flow_cases (
    case_id,
    fluid,
    velocity_m_per_s,
    characteristic_length_m,
    notes
) VALUES
('slow_water_small_pipe', 'water_20c', 0.02, 0.01, 'slow water in small pipe'),
('moderate_water_pipe', 'water_20c', 0.50, 0.05, 'moderate water pipe flow'),
('fast_water_pipe', 'water_20c', 2.00, 0.10, 'fast water pipe flow'),
('viscous_oil_pipe', 'engine_oil', 0.20, 0.04, 'viscous oil pipe flow'),
('microfluidic_channel', 'water_20c', 0.001, 0.0001, 'microfluidic water channel'),
('air_duct', 'air_20c', 5.0, 0.20, 'air duct example'),
('blood_vessel_approx', 'blood_approx', 0.10, 0.004, 'simplified biological flow example');

INSERT INTO bernoulli_cases (
    case_id,
    fluid,
    v1_m_per_s,
    v2_m_per_s,
    z1_m,
    z2_m,
    p1_pa,
    notes
) VALUES
('horizontal_nozzle', 'water_20c', 1.0, 3.0, 0.0, 0.0, 200000.0, 'horizontal ideal nozzle'),
('rising_pipe', 'water_20c', 1.5, 1.5, 0.0, 5.0, 250000.0, 'same speed rising pipe ideal case'),
('air_speedup', 'air_20c', 20.0, 60.0, 0.0, 0.0, 101325.0, 'ideal air speedup comparison'),
('hydraulic_drop', 'water_20c', 0.8, 2.0, 10.0, 0.0, 180000.0, 'ideal elevation drop case');

INSERT INTO dimensionless_numbers (
    number_name,
    symbol,
    definition,
    primary_ratio,
    notes
) VALUES
('Reynolds', 'Re', 'rho v L / mu', 'inertia to viscosity', 'flow regime and dynamic similarity'),
('Froude', 'Fr', 'v / sqrt(g L)', 'inertia to gravity', 'free-surface and open-channel flows'),
('Mach', 'Ma', 'v / c', 'flow speed to sound speed', 'compressibility and shocks'),
('Weber', 'We', 'rho v^2 L / sigma', 'inertia to surface tension', 'droplets bubbles capillary flows'),
('Strouhal', 'St', 'f L / v', 'unsteady oscillation to advection', 'vortex shedding and unsteady flow'),
('Peclet', 'Pe', 'v L / D', 'advection to diffusion', 'scalar transport'),
('Prandtl', 'Pr', 'nu / alpha', 'momentum diffusivity to thermal diffusivity', 'heat-transfer boundary layers');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'density', 'rho = m/V', 'rho,m,V', 'mass per unit volume'),
(2, 'pressure', 'p = F/A', 'p,F,A', 'normal force per unit area'),
(3, 'hydrostatic pressure', 'p = p0 + rho g h', 'p,p0,rho,g,h', 'pressure increase with depth'),
(4, 'material derivative', 'D/Dt = partial/partial t + u dot grad', 'D,t,u,grad', 'rate of change following a fluid parcel'),
(5, 'continuity equation', 'partial rho/partial t + div(rho u)=0', 'rho,t,u', 'mass conservation'),
(6, 'incompressible continuity', 'div u = 0', 'u', 'volume-preserving incompressible flow'),
(7, 'Bernoulli equation', 'p + 1/2 rho v^2 + rho g z = constant', 'p,rho,v,g,z', 'ideal steady inviscid energy relation'),
(8, 'Newtonian shear stress', 'tau = mu du/dy', 'tau,mu,u,y', 'linear viscous shear relation'),
(9, 'kinematic viscosity', 'nu = mu/rho', 'nu,mu,rho', 'momentum diffusivity'),
(10, 'Navier-Stokes equation', 'rho(partial u/partial t + (u dot grad)u) = -grad p + mu laplacian u + f', 'rho,u,t,p,mu,f', 'viscous momentum balance'),
(11, 'Reynolds number', 'Re = rho v L / mu', 'Re,rho,v,L,mu', 'inertia to viscosity ratio'),
(12, 'vorticity', 'omega = curl u', 'omega,u', 'local rotational structure of flow'),
(13, 'drag force', 'F_D = 1/2 rho v^2 C_D A', 'F_D,rho,v,C_D,A', 'drag force model');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'continuum approximation', 'field description of fluids', 'rho u p', 'breaks near molecular scales or rarefied gases'),
(2, 'Bernoulli equation', 'ideal energy relation', 'p v z', 'requires restrictive assumptions'),
(3, 'Reynolds number', 'regime classification', 'Re', 'thresholds depend on geometry and disturbance environment'),
(4, 'Navier-Stokes equation', 'viscous momentum balance', 'u and p', 'difficult to solve in turbulent regimes'),
(5, 'vorticity field', 'diagnose local rotation', 'curl u', 'requires spatially resolved velocity field'),
(6, 'advection-diffusion', 'transport scalar in flow', 'c', 'does not solve full momentum equations'),
(7, 'CFD scaffold', 'numerical approximation', 'grid and timestep', 'not a production solver');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'MIT Marine Hydrodynamics', 'MIT OpenCourseWare', 'fluid fundamentals hydrodynamics vorticity Bernoulli and potential flow', 'https://ocw.mit.edu/courses/2-20-marine-hydrodynamics-13-021-spring-2005/pages/lecture-notes/'),
(2, 'MIT Engineering Mechanics II', 'MIT OpenCourseWare', 'fluid mechanics Bernoulli Reynolds pipe flow drag lift open channel flow', 'https://ocw.mit.edu/courses/1-060-engineering-mechanics-ii-spring-2006/pages/lecture-notes/'),
(3, 'MIT Numerical Fluid Mechanics', 'MIT OpenCourseWare', 'numerical methods CFD finite differences finite volume Navier-Stokes review', 'https://ocw.mit.edu/courses/2-29-numerical-fluid-mechanics-spring-2015/pages/lecture-notes-and-references/'),
(4, 'MIT Fields Forces and Flows in Biological Systems', 'MIT OpenCourseWare', 'viscosity drag Reynolds number Stokes flow biological flow', 'https://ocw.mit.edu/courses/20-330j-fields-forces-and-flows-in-biological-systems-spring-2007/pages/lecture-notes/'),
(5, 'NIST SI Guide', 'NIST', 'SI units for pressure viscosity and derived quantities', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(6, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(7, 'Reynolds 1883', 'Royal Society', 'classic experimental transition and Reynolds number paper', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1883.0029');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'vorticity_field_diagnostics', 'Uses a streamfunction-generated two-dimensional incompressible velocity field.'),
(2, 'vorticity_field_diagnostics', 'Uses finite differences to estimate divergence and vorticity.'),
(3, 'bernoulli_pipe_scaffold', 'Uses ideal Bernoulli assumptions and does not include head loss.'),
(4, 'advection_diffusion_scaffold', 'Uses a one-dimensional explicit finite-difference transport scaffold.'),
(5, 'reynolds_number_classification', 'Uses simplified pipe-flow threshold labels for teaching.'),
(6, 'fluid_dynamics_schema', 'Stores educational metadata rather than a production CFD database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'fluid-dynamics-and-the-physics-of-flow', 'vorticity_field_diagnostics', 'finite_difference_field_diagnostics', 'streamfunction sin(pi x) sin(pi y) on 101 by 101 grid', 'velocity divergence and vorticity diagnostics', '2026-04-25'),
(2, 'fluid-dynamics-and-the-physics-of-flow', 'bernoulli_pipe_scaffold', 'closed_form_bernoulli_table', 'four ideal Bernoulli cases using fluid properties table', 'pressure and dynamic-pressure table', '2026-04-25'),
(3, 'fluid-dynamics-and-the-physics-of-flow', 'advection_diffusion_scaffold', 'explicit_finite_difference', 'one-dimensional scalar transport with advection and diffusion', 'scalar concentration snapshots', '2026-04-25'),
(4, 'fluid-dynamics-and-the-physics-of-flow', 'reynolds_number_classification', 'closed_form_parameter_table', 'pipe and channel flow cases across fluids and scales', 'Reynolds number and regime labels', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

-- Gravitation, Orbits, and Celestial Mechanics Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, central bodies, orbital cases, transfer cases,
-- physical relations, source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS central_bodies;
DROP TABLE IF EXISTS orbital_cases;
DROP TABLE IF EXISTS hohmann_transfer_cases;
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

CREATE TABLE central_bodies (
    body_id INTEGER PRIMARY KEY,
    body_name TEXT NOT NULL,
    mu_m3_per_s2 REAL NOT NULL,
    radius_m REAL NOT NULL,
    mass_kg REAL NOT NULL,
    notes TEXT
);

CREATE TABLE orbital_cases (
    case_id TEXT PRIMARY KEY,
    central_body TEXT NOT NULL,
    altitude_m REAL NOT NULL,
    semimajor_axis_m REAL NOT NULL,
    eccentricity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE hohmann_transfer_cases (
    case_id TEXT PRIMARY KEY,
    central_body TEXT NOT NULL,
    r1_m REAL NOT NULL,
    r2_m REAL NOT NULL,
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
(1, 'Newtonian constant of gravitation', 'G', 6.67430e-11, 'm^3 kg^-1 s^-2', 'NIST CODATA value'),
(2, 'standard gravity', 'g0', 9.80665, 'm s^-2', 'standard acceleration due to gravity'),
(3, 'astronomical unit', 'au', 1.495978707e11, 'm', 'IAU-defined astronomical unit'),
(4, 'day', 'day', 86400.0, 's', 'mean solar day used as time conversion'),
(5, 'Julian year', 'yr', 31557600.0, 's', 'Julian year of 365.25 days');

INSERT INTO central_bodies (
    body_id,
    body_name,
    mu_m3_per_s2,
    radius_m,
    mass_kg,
    notes
) VALUES
(1, 'Earth', 3.986004418e14, 6.371e6, 5.9722e24, 'standard Earth examples'),
(2, 'Moon', 4.9048695e12, 1.7374e6, 7.342e22, 'lunar examples'),
(3, 'Sun', 1.32712440018e20, 6.9634e8, 1.9885e30, 'solar-system examples'),
(4, 'Mars', 4.282837e13, 3.3895e6, 6.4171e23, 'Mars orbit examples'),
(5, 'Jupiter', 1.26686534e17, 6.9911e7, 1.8982e27, 'giant planet examples');

INSERT INTO orbital_cases (
    case_id,
    central_body,
    altitude_m,
    semimajor_axis_m,
    eccentricity,
    notes
) VALUES
('low_earth_400_km', 'Earth', 400000.0, 6771000.0, 0.0, 'near-circular low Earth orbit'),
('low_earth_700_km', 'Earth', 700000.0, 7071000.0, 0.0, 'article integration case'),
('medium_earth_20200_km', 'Earth', 20200000.0, 26571000.0, 0.0, 'GNSS-like orbit comparison'),
('geostationary', 'Earth', 35786000.0, 42157000.0, 0.0, 'geostationary-radius comparison'),
('high_earth_60000_km', 'Earth', 60000000.0, 66371000.0, 0.0, 'high Earth orbit comparison'),
('lunar_low_100_km', 'Moon', 100000.0, 1837400.0, 0.0, 'low lunar orbit comparison'),
('mars_low_400_km', 'Mars', 400000.0, 3789500.0, 0.0, 'low Mars orbit comparison');

INSERT INTO hohmann_transfer_cases (
    case_id,
    central_body,
    r1_m,
    r2_m,
    notes
) VALUES
('leo_to_geostationary', 'Earth', 6771000.0, 42157000.0, 'low Earth orbit to geostationary radius'),
('leo_to_medium_earth', 'Earth', 6771000.0, 26571000.0, 'low Earth orbit to medium Earth orbit'),
('earth_orbit_inner_to_outer', 'Sun', 1.495978707e11, 2.279392e11, 'Earth-like solar orbit to Mars-like solar orbit'),
('moon_low_to_high', 'Moon', 1837400.0, 5000000.0, 'low lunar orbit to higher lunar orbit'),
('mars_low_to_high', 'Mars', 3789500.0, 10000000.0, 'low Mars orbit to higher Mars orbit');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'Newtonian gravitation', 'F = G m1 m2 / r^2', 'F,G,m1,m2,r', 'inverse-square gravitational attraction'),
(2, 'gravitational potential energy', 'U = -G M m / r', 'U,G,M,m,r', 'potential energy for two masses'),
(3, 'standard gravitational parameter', 'mu = G M', 'mu,G,M', 'central body gravitational parameter'),
(4, 'circular speed', 'v_circ = sqrt(mu/r)', 'v,mu,r', 'speed for circular orbit'),
(5, 'escape speed', 'v_esc = sqrt(2mu/r)', 'v,mu,r', 'threshold speed for parabolic escape'),
(6, 'circular period', 'T = 2 pi sqrt(r^3/mu)', 'T,r,mu', 'orbital period for circular two-body orbit'),
(7, 'specific orbital energy', 'epsilon = v^2/2 - mu/r', 'epsilon,v,mu,r', 'energy per unit mass'),
(8, 'elliptic energy', 'epsilon = -mu/(2a)', 'epsilon,mu,a', 'specific energy of bound elliptical orbit'),
(9, 'vis-viva equation', 'v^2 = mu(2/r - 1/a)', 'v,mu,r,a', 'speed along Keplerian orbit'),
(10, 'specific angular momentum', 'h = r x v', 'h,r,v', 'angular momentum per unit mass'),
(11, 'areal velocity', 'dA/dt = h/2', 'A,t,h', 'Kepler second law from angular momentum conservation'),
(12, 'Kepler third law', 'T^2 = 4 pi^2 a^3 / mu', 'T,a,mu', 'period-semimajor-axis relation');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'circular orbit', 'estimate orbital speed and period', 'v_circ', 'assumes two-body circular motion'),
(2, 'escape speed', 'estimate threshold for unbound trajectory', 'v_esc', 'ignores atmosphere and propulsion losses'),
(3, 'vis-viva equation', 'compute speed along Keplerian orbit', 'v', 'ideal two-body conic orbit'),
(4, 'two-body integration', 'simulate Newtonian orbital motion', 'r and v', 'no perturbations by default'),
(5, 'Hohmann transfer', 'estimate two-burn coplanar transfer', 'delta-v', 'ideal impulsive burns and circular endpoints'),
(6, 'Kepler third law', 'relate period and semimajor axis', 'T^2/a^3', 'two-body approximation'),
(7, 'energy classification', 'classify bound or unbound orbit', 'epsilon', 'ideal Newtonian potential');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'MIT Chapter 25 Celestial Mechanics', 'MIT OpenCourseWare', 'celestial mechanics lecture note', 'https://ocw.mit.edu/courses/8-01sc-classical-mechanics-fall-2016/mit8_01scs22_chapter25new.pdf'),
(2, 'MIT Central Force Motion Kepler Laws', 'MIT OpenCourseWare', 'central-force and Kepler laws reference', 'https://ocw.mit.edu/courses/16-07-dynamics-fall-2009/d931dd84ca3025a3676ed2244f48ab85_MIT16_07F09_Lec15.pdf'),
(3, 'MIT Kepler Laws Lecture', 'MIT OpenCourseWare', 'advanced classical mechanics Kepler derivation', 'https://ocw.mit.edu/courses/8-223-classical-mechanics-ii-january-iap-2017/9875b46d4a49c3e6bd50f00aac768fef_MIT8_223IAP17_Lec8.pdf'),
(4, 'NIST CODATA G', 'NIST', 'Newtonian constant of gravitation value', 'https://physics.nist.gov/cgi-bin/cuu/Value?bg='),
(5, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(6, 'NASA From Stargazers to Starships', 'NASA Goddard', 'educational orbital mechanics and spaceflight reference', 'https://pwg.gsfc.nasa.gov/stargaze/Smap.htm'),
(7, 'Kepler Astronomia Nova', 'Internet Archive', 'primary source on planetary motion', 'https://archive.org/details/Astronomianovaa00Kepl'),
(8, 'Newton Principia', 'Internet Archive', 'primary source on mechanics and universal gravitation', 'https://archive.org/download/NewtonPrincipia_201701/The%20Principia%20Mathematical%20Principles%20of%20Natural%20Philosophy%20Isaac%20Newton.pdf'),
(9, 'Laplace Mecanique Celeste', 'Internet Archive', 'classic celestial mechanics treatise', 'https://archive.org/details/mecaniqueceleste11829lapl');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'two_body_orbit_integration', 'Uses Newtonian two-body motion around a central body.'),
(2, 'two_body_orbit_integration', 'Uses a planar near-circular low Earth orbit as an introductory example.'),
(3, 'orbital_energy_diagnostics', 'Classifies ideal orbital energy without atmospheric or perturbation effects.'),
(4, 'hohmann_transfer_scaffold', 'Assumes coplanar circular endpoints and impulsive burns.'),
(5, 'circular_orbit_scaling', 'Uses spherically symmetric central-body approximation.'),
(6, 'celestial_mechanics_schema', 'Stores educational metadata rather than a production ephemeris database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'gravitation-orbits-and-celestial-mechanics', 'two_body_orbit_integration', 'ode_integration', 'Earth orbit at 700 km altitude with circular initial speed', 'orbit state table and conservation diagnostics', '2026-04-25'),
(2, 'gravitation-orbits-and-celestial-mechanics', 'orbital_energy_diagnostics', 'closed_form_table', 'sample circular orbits around Earth Moon and Mars', 'energy speed and classification table', '2026-04-25'),
(3, 'gravitation-orbits-and-celestial-mechanics', 'hohmann_transfer_scaffold', 'closed_form_transfer_estimate', 'sample Earth Moon Mars and solar transfer cases', 'ideal delta-v and transfer-time table', '2026-04-25'),
(4, 'gravitation-orbits-and-celestial-mechanics', 'kepler_period_law_summary', 'closed_form_period_scaling', 'sample circular orbital cases', 'period-law ratio diagnostics', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

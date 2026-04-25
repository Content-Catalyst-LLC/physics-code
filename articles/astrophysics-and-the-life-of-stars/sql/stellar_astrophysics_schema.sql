-- Astrophysics and the Life of Stars Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores stellar classes, evolutionary stages, observables, physical
-- relations, model assumptions, source notes, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS stellar_classes;
DROP TABLE IF EXISTS evolutionary_stages;
DROP TABLE IF EXISTS stellar_observables;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE stellar_classes (
    class_id INTEGER PRIMARY KEY,
    spectral_type TEXT NOT NULL,
    mass_solar REAL,
    temperature_k REAL,
    radius_solar REAL,
    notes TEXT
);

CREATE TABLE evolutionary_stages (
    stage_id INTEGER PRIMARY KEY,
    stage_name TEXT NOT NULL,
    primary_energy_source TEXT,
    dominant_physics TEXT,
    typical_outcome TEXT,
    notes TEXT
);

CREATE TABLE stellar_observables (
    observable_id INTEGER PRIMARY KEY,
    observable_name TEXT NOT NULL,
    measurement_method TEXT NOT NULL,
    physical_interpretation TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE physical_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
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

INSERT INTO stellar_classes (
    class_id,
    spectral_type,
    mass_solar,
    temperature_k,
    radius_solar,
    notes
) VALUES
(1, 'O5', 40.0, 40000.0, 18.0, 'very massive hot luminous main-sequence example'),
(2, 'B0', 16.0, 28000.0, 7.0, 'massive blue main-sequence example'),
(3, 'A0', 3.3, 10000.0, 2.5, 'intermediate-mass main-sequence example'),
(4, 'F0', 1.7, 7500.0, 1.4, 'moderately massive main-sequence example'),
(5, 'G0', 1.1, 6000.0, 1.1, 'solar-like main-sequence example'),
(6, 'K0', 0.8, 5000.0, 0.8, 'cool lower-main-sequence example'),
(7, 'M0', 0.4, 3500.0, 0.6, 'red dwarf-style main-sequence example');

INSERT INTO evolutionary_stages (
    stage_id,
    stage_name,
    primary_energy_source,
    dominant_physics,
    typical_outcome,
    notes
) VALUES
(1, 'Molecular cloud', 'none', 'gravity, turbulence, cooling', 'collapse or dispersal', 'star formation begins in cold gas'),
(2, 'Protostar', 'gravitational contraction', 'accretion heating, disks, outflows', 'pre-main-sequence object', 'fusion not yet dominant'),
(3, 'Main sequence', 'hydrogen fusion', 'hydrostatic equilibrium and nuclear burning', 'long-lived stable star', 'longest phase for many stars'),
(4, 'Red giant or supergiant', 'shell burning', 'core contraction and envelope expansion', 'late-stage giant star', 'post-main-sequence transformation'),
(5, 'Planetary nebula', 'exposed hot core and ejected envelope', 'radiation, ionization, mass loss', 'white dwarf formation', 'common for Sun-like stars'),
(6, 'Core-collapse supernova', 'gravitational collapse and explosive nucleosynthesis', 'nuclear physics, hydrodynamics, neutrinos', 'neutron star or black hole', 'massive-star endpoint'),
(7, 'White dwarf', 'residual thermal energy', 'electron degeneracy and cooling', 'compact remnant', 'low-intermediate mass endpoint'),
(8, 'Neutron star', 'residual cooling and compact matter', 'neutron-rich dense matter and relativity', 'compact remnant', 'massive-star endpoint'),
(9, 'Black hole', 'accretion if fueled', 'strong gravity and event horizon', 'compact remnant', 'collapse beyond pressure support');

INSERT INTO stellar_observables (
    observable_id,
    observable_name,
    measurement_method,
    physical_interpretation,
    notes
) VALUES
(1, 'apparent_brightness', 'photometry', 'observed flux received at telescope', 'requires calibration'),
(2, 'parallax', 'astrometry', 'distance estimate', 'foundation for luminosity calibration'),
(3, 'spectrum', 'spectroscopy', 'temperature composition velocity and surface gravity', 'uses atomic line data'),
(4, 'color_index', 'multi-band photometry', 'temperature proxy', 'affected by extinction'),
(5, 'proper_motion', 'astrometry', 'sky-plane motion', 'combined with distance for velocity'),
(6, 'radial_velocity', 'doppler spectroscopy', 'line-of-sight motion', 'requires wavelength calibration'),
(7, 'luminosity', 'distance plus brightness', 'total energy output', 'depends on distance and extinction correction'),
(8, 'effective_temperature', 'spectral fitting or color', 'surface temperature proxy', 'model-dependent');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'hydrostatic_equilibrium', 'dP/dr = -G M(r) rho(r) / r^2', 'P,r,G,M,rho', 'pressure gradient balances gravity'),
(2, 'mass_continuity', 'dM/dr = 4 pi r^2 rho(r)', 'M,r,rho', 'enclosed mass changes with radius'),
(3, 'stefan_boltzmann_luminosity', 'L = 4 pi R^2 sigma T_eff^4', 'L,R,sigma,T_eff', 'luminosity radius temperature relation'),
(4, 'mass_luminosity_scaling', 'L = M^3.5', 'L,M', 'approximate main-sequence scaling'),
(5, 'lifetime_scaling', 't = M / L', 't,M,L', 'approximate main-sequence lifetime intuition');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'mass_luminosity_scaling', 'Uses a single exponent of 3.5 for educational approximation.'),
(2, 'mass_luminosity_scaling', 'Does not account for metallicity, rotation, mass loss, or binary evolution.'),
(3, 'lifetime_scaling', 'Assumes lifetime scales with available fuel divided by luminosity.'),
(4, 'hr_radius_scaling', 'Uses solar-normalized Stefan-Boltzmann scaling.'),
(5, 'hydrostatic_equilibrium_toy_model', 'Uses a simplified density profile and is not a calibrated stellar model.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'NASA Star Basics', 'https://science.nasa.gov/universe/stars/', 'stars', 'NASA overview of star birth, life, and death.'),
(2, 'ESA Stars', 'https://sci.esa.int/web/gaia/-/40576-stars', 'stellar evolution', 'ESA Gaia overview of stellar evolution and H-R diagram work.'),
(3, 'ESA Stellar Astrophysics with Gaia', 'https://sci.esa.int/web/gaia/-/31398-stellar-astrophysics', 'Gaia stellar astrophysics', 'Gaia stellar measurements and H-R diagram calibration.'),
(4, 'OpenStax H-R Diagram', 'https://openstax.org/books/astronomy-2e/pages/18-4-the-h-r-diagram', 'H-R diagram', 'OpenStax explanation of main sequence and stellar evolution.'),
(5, 'NIST Atomic Spectra Database', 'https://www.nist.gov/pml/atomic-spectra-database', 'spectroscopy', 'Critically evaluated atomic wavelength and transition data.'),
(6, 'NIST How Bright Are the Stars', 'https://www.nist.gov/measuring-cosmos/how-bright-are-stars', 'luminosity calibration', 'NIST overview of starlight calibration.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'astrophysics-and-the-life-of-stars', 'mass_luminosity_scaling', 'closed_form', 'mass from 0.2 to 40 solar masses', 'luminosity and lifetime scaling table', '2026-04-24'),
(2, 'astrophysics-and-the-life-of-stars', 'hr_radius_scaling', 'closed_form', 'sample spectral classes', 'radius temperature luminosity table', '2026-04-24'),
(3, 'astrophysics-and-the-life-of-stars', 'hydrostatic_equilibrium_toy_model', 'toy_profile', 'radius fraction from 0.05 to 1.0', 'pressure gradient table', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

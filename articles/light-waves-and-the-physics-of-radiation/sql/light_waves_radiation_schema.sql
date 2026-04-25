-- Light, Waves, and the Physics of Radiation Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, spectral bands, interference setups, blackbody
-- temperatures, physical relations, source notes, model assumptions, and
-- simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS spectral_bands;
DROP TABLE IF EXISTS interference_setups;
DROP TABLE IF EXISTS blackbody_temperatures;
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

CREATE TABLE spectral_bands (
    band_id INTEGER PRIMARY KEY,
    band_name TEXT NOT NULL,
    approx_min_wavelength_m REAL,
    approx_max_wavelength_m REAL,
    common_unit TEXT,
    notes TEXT
);

CREATE TABLE interference_setups (
    setup_id INTEGER PRIMARY KEY,
    setup_name TEXT NOT NULL,
    wavelength_m REAL NOT NULL,
    slit_separation_m REAL,
    screen_distance_m REAL,
    aperture_width_m REAL,
    notes TEXT
);

CREATE TABLE blackbody_temperatures (
    temperature_id INTEGER PRIMARY KEY,
    case_id TEXT NOT NULL,
    temperature_k REAL NOT NULL,
    wien_peak_wavelength_m REAL,
    stefan_boltzmann_exitance_w_m2 REAL,
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
(1, 'speed of light', 'c', 299792458.0, 'm s^-1', 'exact SI value'),
(2, 'Planck constant', 'h', 6.62607015e-34, 'J s', 'exact SI value'),
(3, 'Boltzmann constant', 'k_B', 1.380649e-23, 'J K^-1', 'exact SI value'),
(4, 'Stefan-Boltzmann constant', 'sigma', 5.670374419e-8, 'W m^-2 K^-4', 'exact derived constant value'),
(5, 'Wien displacement constant', 'b', 2.897771955e-3, 'm K', 'wavelength displacement constant'),
(6, 'elementary charge', 'e', 1.602176634e-19, 'C', 'exact SI value'),
(7, 'electron volt', 'eV', 1.602176634e-19, 'J', 'energy conversion');

INSERT INTO spectral_bands (
    band_id,
    band_name,
    approx_min_wavelength_m,
    approx_max_wavelength_m,
    common_unit,
    notes
) VALUES
(1, 'radio', 1e-3, 1e5, 'm', 'longest-wavelength electromagnetic radiation category'),
(2, 'microwave', 1e-4, 1e-1, 'm', 'communications radar and remote sensing'),
(3, 'infrared', 7e-7, 1e-3, 'm', 'thermal sensing and molecular vibration region'),
(4, 'visible', 3.8e-7, 7.0e-7, 'm', 'human-visible portion of spectrum'),
(5, 'ultraviolet', 1e-8, 4e-7, 'm', 'shorter wavelength than visible light'),
(6, 'x-ray', 1e-11, 1e-8, 'm', 'high-energy imaging and materials analysis'),
(7, 'gamma ray', 1e-15, 1e-11, 'm', 'shortest-wavelength high-energy radiation category');

INSERT INTO interference_setups (
    setup_id,
    setup_name,
    wavelength_m,
    slit_separation_m,
    screen_distance_m,
    aperture_width_m,
    notes
) VALUES
(1, 'article_double_slit', 550e-9, 0.2e-3, 1.5, NULL, 'double-slit article example'),
(2, 'article_single_slit_envelope', 550e-9, NULL, 1.5, 0.05e-3, 'single-slit diffraction envelope scaffold');

INSERT INTO blackbody_temperatures (
    temperature_id,
    case_id,
    temperature_k,
    wien_peak_wavelength_m,
    stefan_boltzmann_exitance_w_m2,
    notes
) VALUES
(1, 'T3000', 3000, 9.65923985e-7, 45930026.7939, 'warm incandescent-style spectrum'),
(2, 'T4500', 4500, 6.43949323e-7, 232520760.894, 'warm stellar thermal example'),
(3, 'T5800', 5800, 4.99615854e-7, 64165847.0, 'solar-like photospheric scale example placeholder'),
(4, 'T6000', 6000, 4.82961993e-7, 734879469.902, 'hot visible-emitting thermal example');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'wave_relation', 'v = f lambda', 'v,f,lambda', 'connects speed frequency and wavelength'),
(2, 'electromagnetic_vacuum_relation', 'c = f lambda', 'c,f,lambda', 'vacuum electromagnetic wave relation'),
(3, 'monochromatic_wave', 'y(x,t)=A sin(kx - omega t + phi)', 'y,A,k,x,omega,t,phi', 'sinusoidal wave representation'),
(4, 'wavenumber', 'k = 2 pi / lambda', 'k,lambda', 'spatial oscillation rate'),
(5, 'angular_frequency', 'omega = 2 pi f', 'omega,f', 'temporal angular oscillation rate'),
(6, 'constructive_interference', 'Delta = m lambda', 'Delta,m,lambda', 'bright fringe condition'),
(7, 'double_slit_fringe', 'y_m = m lambda L / d', 'y_m,m,lambda,L,d', 'small-angle double-slit bright fringe position'),
(8, 'poynting_vector', 'S = (1/mu0) E x B', 'S,mu0,E,B', 'electromagnetic energy flux density'),
(9, 'planck_law', 'B_lambda(T) = (2hc^2/lambda^5)/(exp(hc/(lambda kB T))-1)', 'B,h,c,lambda,kB,T', 'blackbody spectral radiance'),
(10, 'stefan_boltzmann', 'M = sigma T^4', 'M,sigma,T', 'total blackbody exitance'),
(11, 'wien_displacement', 'lambda_max T = b', 'lambda_max,T,b', 'blackbody peak wavelength scaling'),
(12, 'photon_energy', 'E = h f = h c / lambda', 'E,h,f,c,lambda', 'photon energy relation');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'wave relation', 'connect frequency wavelength and speed', 'c or v', 'medium must be specified'),
(2, 'double-slit interference', 'phase-based fringe modeling', 'path difference', 'ideal coherent slits'),
(3, 'single-slit diffraction', 'aperture spreading model', 'sinc envelope', 'scalar far-field model'),
(4, 'Planck law', 'blackbody spectral radiance', 'temperature and wavelength', 'ideal blackbody'),
(5, 'Wien law', 'peak wavelength estimate', 'b/T', 'only peak-location scaling'),
(6, 'Stefan-Boltzmann law', 'total blackbody exitance', 'sigma T^4', 'integrated ideal blackbody'),
(7, 'photon energy', 'energy-frequency relation', 'hf', 'quantum relation not full quantum optics');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'NASA Introduction to the Electromagnetic Spectrum', 'NASA', 'electromagnetic spectrum overview', 'https://science.nasa.gov/ems/01_intro/'),
(2, 'NASA Spectroscopy 101 Light and Matter', 'NASA/Webb', 'spectroscopy and light-matter explanation', 'https://science.nasa.gov/mission/webb/science-overview/science-explainers/spectroscopy-101-light-and-matter/'),
(3, 'BIPM SI Defining Constants', 'BIPM', 'SI defining constants', 'https://www.bipm.org/en/measurement-units/si-defining-constants'),
(4, 'NIST Speed of Light', 'NIST', 'CODATA speed of light value', 'https://physics.nist.gov/cgi-bin/cuu/Value?c='),
(5, 'NIST Planck Constant', 'NIST', 'CODATA Planck constant value', 'https://physics.nist.gov/cgi-bin/cuu/Value?h'),
(6, 'NIST Boltzmann Constant', 'NIST', 'CODATA Boltzmann constant value', 'https://physics.nist.gov/cgi-bin/cuu/Value?k='),
(7, 'NIST Stefan-Boltzmann Constant', 'NIST', 'CODATA Stefan-Boltzmann constant value', 'https://physics.nist.gov/cgi-bin/cuu/Value?sigma='),
(8, 'Maxwell 1865', 'Royal Society', 'electromagnetic theory of light', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1865.0008'),
(9, 'Young 1802', 'Royal Society', 'wave theory and interference', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1802.0004');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'interference_planck_radiation', 'Uses idealized coherent double-slit interference without a diffraction envelope in the main example.'),
(2, 'interference_planck_radiation', 'Uses ideal blackbody Planck spectra.'),
(3, 'diffraction_envelope', 'Uses scalar far-field single-slit diffraction envelope.'),
(4, 'spectral_band_summary', 'Uses approximate spectral-band wavelength ranges for educational metadata.'),
(5, 'light_waves_radiation_schema', 'Stores educational metadata rather than a calibrated radiometry database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'light-waves-and-the-physics-of-radiation', 'interference_planck_radiation', 'closed_form_grid', '550 nm double slit and 5800 K blackbody', 'interference pattern and blackbody spectrum', '2026-04-24'),
(2, 'light-waves-and-the-physics-of-radiation', 'diffraction_envelope', 'closed_form_grid', '550 nm and 0.05 mm slit width', 'single-slit envelope table', '2026-04-24'),
(3, 'light-waves-and-the-physics-of-radiation', 'spectral_band_summary', 'metadata_conversion', 'approximate band ranges', 'frequency and photon energy ranges', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

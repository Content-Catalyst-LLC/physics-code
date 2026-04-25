-- Waves, Oscillations, and Resonance Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores oscillator cases, wave media, standing-wave cases, Fourier
-- components, physical relations, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS oscillator_cases;
DROP TABLE IF EXISTS wave_medium_cases;
DROP TABLE IF EXISTS standing_wave_cases;
DROP TABLE IF EXISTS fourier_signal_components;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE oscillator_cases (
    case_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    spring_constant_n_per_m REAL NOT NULL,
    damping_coefficient_kg_per_s REAL NOT NULL,
    driving_force_n REAL NOT NULL,
    driving_frequency_ratio REAL NOT NULL,
    notes TEXT
);

CREATE TABLE wave_medium_cases (
    case_id TEXT PRIMARY KEY,
    wave_type TEXT NOT NULL,
    wave_speed_m_per_s REAL NOT NULL,
    frequency_hz REAL NOT NULL,
    wavelength_m REAL,
    notes TEXT
);

CREATE TABLE standing_wave_cases (
    case_id TEXT PRIMARY KEY,
    length_m REAL NOT NULL,
    wave_speed_m_per_s REAL NOT NULL,
    max_mode INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE fourier_signal_components (
    component_id TEXT PRIMARY KEY,
    frequency_hz REAL NOT NULL,
    amplitude REAL NOT NULL,
    phase_rad REAL NOT NULL,
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

INSERT INTO oscillator_cases (
    case_id,
    mass_kg,
    spring_constant_n_per_m,
    damping_coefficient_kg_per_s,
    driving_force_n,
    driving_frequency_ratio,
    notes
) VALUES
('light_damping', 1.0, 25.0, 0.2, 1.0, 0.95, 'low damping near resonance'),
('moderate_damping', 1.0, 25.0, 0.6, 1.0, 0.95, 'article base case'),
('strong_damping', 1.0, 25.0, 1.2, 1.0, 0.95, 'stronger damping comparison'),
('below_resonance', 1.0, 25.0, 0.6, 1.0, 0.60, 'driven below natural frequency'),
('above_resonance', 1.0, 25.0, 0.6, 1.0, 1.40, 'driven above natural frequency');

INSERT INTO wave_medium_cases (
    case_id,
    wave_type,
    wave_speed_m_per_s,
    frequency_hz,
    wavelength_m,
    notes
) VALUES
('sound_air_440hz', 'sound', 343.0, 440.0, NULL, 'concert A in air approximate'),
('string_100hz', 'string', 120.0, 100.0, NULL, 'illustrative string wave'),
('water_wave', 'water', 2.5, 0.5, NULL, 'illustrative shallow water-style case'),
('em_wave_vacuum', 'electromagnetic', 299792458.0, 100000000.0, NULL, '100 MHz electromagnetic wave in vacuum'),
('seismic_s_wave', 'seismic', 3500.0, 2.0, NULL, 'illustrative seismic shear wave');

INSERT INTO standing_wave_cases (
    case_id,
    length_m,
    wave_speed_m_per_s,
    max_mode,
    notes
) VALUES
('string_short', 0.65, 120.0, 8, 'short string fixed at both ends'),
('string_long', 1.00, 120.0, 8, 'longer string fixed at both ends'),
('air_column_open_open', 0.75, 343.0, 8, 'open-open acoustic column approximation'),
('air_column_closed_open', 0.75, 343.0, 8, 'closed-open acoustic column extension placeholder');

INSERT INTO fourier_signal_components (
    component_id,
    frequency_hz,
    amplitude,
    phase_rad,
    notes
) VALUES
('fundamental', 5.0, 1.00, 0.0, 'base component'),
('second_harmonic', 10.0, 0.40, 0.2, 'added harmonic'),
('third_harmonic', 15.0, 0.25, -0.3, 'added harmonic'),
('low_modulation', 1.0, 0.15, 0.0, 'slow modulation component');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'Hooke law', 'F = -kx', 'F,k,x', 'linear restoring force'),
(2, 'simple harmonic oscillator', 'd2x/dt2 + omega0^2 x = 0', 'x,t,omega0', 'ideal oscillator equation'),
(3, 'natural angular frequency', 'omega0 = sqrt(k/m)', 'omega0,k,m', 'mass-spring natural angular frequency'),
(4, 'period', 'T = 2 pi / omega0', 'T,omega0', 'oscillation period'),
(5, 'frequency angular frequency relation', 'omega = 2 pi f', 'omega,f', 'angular frequency and frequency relation'),
(6, 'damped oscillator', 'd2x/dt2 + 2 gamma dx/dt + omega0^2 x = 0', 'x,t,gamma,omega0', 'linear damping model'),
(7, 'driven oscillator', 'd2x/dt2 + 2 gamma dx/dt + omega0^2 x = (F0/m) cos(omega t)', 'x,t,gamma,omega0,F0,m,omega', 'driven damped oscillator'),
(8, 'traveling wave', 'y(x,t) = A cos(kx - omega t + phi)', 'y,A,k,x,omega,t,phi', 'sinusoidal traveling wave'),
(9, 'wave speed', 'v = omega/k = f lambda', 'v,omega,k,f,lambda', 'wave propagation speed'),
(10, 'wave equation', 'd2y/dt2 = v^2 d2y/dx2', 'y,t,v,x', 'one-dimensional wave equation'),
(11, 'standing wave frequency', 'f_n = n v/(2L)', 'f_n,n,v,L', 'fixed-end standing-wave modes'),
(12, 'beat frequency', 'f_beat = |f1 - f2|', 'f_beat,f1,f2', 'beat frequency from close tones'),
(13, 'group velocity', 'v_g = d omega / dk', 'v_g,omega,k', 'wave packet velocity in dispersive systems');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'simple harmonic oscillator', 'baseline oscillator model', 'omega0', 'linear restoring force'),
(2, 'damped oscillator', 'model energy loss', 'gamma', 'viscous damping approximation'),
(3, 'driven oscillator', 'model resonance response', 'A(omega)', 'sinusoidal steady-state idealization'),
(4, 'standing wave', 'mode frequencies under boundary conditions', 'f_n', 'ideal fixed or open boundaries'),
(5, 'wave equation', 'propagation of disturbances', 'y(x,t)', 'one-dimensional linear scaffold'),
(6, 'Fourier decomposition', 'frequency-domain representation', 'spectrum', 'finite sample limitations'),
(7, 'beat frequency', 'interference of close frequencies', 'f_beat', 'requires near-frequency components');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'MIT Physics III Vibrations and Waves', 'MIT OpenCourseWare', 'core vibrations and waves course', 'https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/'),
(2, 'MIT Mechanical Vibrations and Waves', 'MIT OpenCourseWare', 'oscillator waves modes and beats', 'https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/pages/part-i-mechanical-vibrations-and-waves/'),
(3, 'MIT Driven Oscillators Resonance', 'MIT OpenCourseWare', 'driven oscillator and resonance lecture', 'https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/pages/part-i-mechanical-vibrations-and-waves/lecture-6/'),
(4, 'The Physics of Waves', 'MIT OpenCourseWare', 'open textbook on waves', 'https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/ef731c1b91d77a6db003f6c27e300d25_MIT8_03SCF16_Textbook.pdf'),
(5, 'NIST SI Guide', 'NIST', 'SI units frequency hertz radian and angular frequency', 'https://physics.nist.gov/cuu/pdf/sp811.pdf'),
(6, 'NIST SP330', 'NIST', 'International System of Units reference', 'https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.330-2019.pdf'),
(7, 'BIPM SI Brochure', 'BIPM', 'official SI framework', 'https://www.bipm.org/en/si-brochure-9'),
(8, 'Fourier Analytical Theory of Heat', 'Internet Archive', 'classic Fourier analysis source', 'https://archive.org/details/analyticaltheory00fourrich'),
(9, 'Rayleigh Theory of Sound', 'Internet Archive', 'classic acoustics and wave source', 'https://archive.org/details/theorysound00raylgoog');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'damped_driven_oscillator', 'Uses a linear spring and viscous damping.'),
(2, 'damped_driven_oscillator', 'Uses sinusoidal forcing and one-dimensional motion.'),
(3, 'resonance_parameter_sweep', 'Uses steady-state amplitude formula for a linear driven damped oscillator.'),
(4, 'wave_equation_string_scaffold', 'Uses a one-dimensional finite-difference scaffold with fixed-end boundaries.'),
(5, 'fourier_signal_decomposition', 'Uses a synthetic signal with known sinusoidal components.'),
(6, 'waves_oscillations_schema', 'Stores educational metadata rather than a production acoustics or wave-simulation database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'waves-oscillations-and-resonance', 'damped_driven_oscillator', 'ode_integration', 'm=1 kg k=25 N/m b=0.6 kg/s drive near resonance', 'time-domain oscillator and energy table', '2026-04-25'),
(2, 'waves-oscillations-and-resonance', 'resonance_parameter_sweep', 'closed_form_parameter_grid', 'damping values 0.2 0.6 1.2 and omega 0.1..12 rad/s', 'resonance curve and peak summaries', '2026-04-25'),
(3, 'waves-oscillations-and-resonance', 'wave_equation_string_scaffold', 'finite_difference_time_domain', 'fixed string length 1 m wave speed 100 m/s', 'string displacement snapshots', '2026-04-25'),
(4, 'waves-oscillations-and-resonance', 'fourier_signal_decomposition', 'fft_spectrum', 'synthetic signal components at 1 5 10 15 Hz', 'frequency spectrum table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

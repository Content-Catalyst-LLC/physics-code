-- Scattering Theory, Cross Sections, and Physical Inference Data Model
--
-- SQLite-compatible metadata and scaffold tables.

DROP TABLE IF EXISTS scattering_constants;
DROP TABLE IF EXISTS angular_distribution_cases;
DROP TABLE IF EXISTS resonance_cases;
DROP TABLE IF EXISTS born_potential_cases;
DROP TABLE IF EXISTS partial_wave_cases;
DROP TABLE IF EXISTS event_rate_cases;
DROP TABLE IF EXISTS detector_response_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS inference_runs;

CREATE TABLE scattering_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE angular_distribution_cases (
    case_id TEXT PRIMARY KEY,
    sigma_0 REAL NOT NULL,
    alpha REAL NOT NULL,
    n_grid INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE resonance_cases (
    case_id TEXT PRIMARY KEY,
    resonance_energy REAL NOT NULL,
    width REAL NOT NULL,
    amplitude REAL NOT NULL,
    background REAL NOT NULL,
    energy_min REAL NOT NULL,
    energy_max REAL NOT NULL,
    n_points INTEGER NOT NULL,
    noise_seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE born_potential_cases (
    case_id TEXT PRIMARY KEY,
    potential_strength REAL NOT NULL,
    potential_range REAL NOT NULL,
    mass REAL NOT NULL,
    hbar REAL NOT NULL,
    q_min REAL NOT NULL,
    q_max REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE partial_wave_cases (
    case_id TEXT PRIMARY KEY,
    k REAL NOT NULL,
    l_max INTEGER NOT NULL,
    phase_shift_scale REAL NOT NULL,
    notes TEXT
);

CREATE TABLE event_rate_cases (
    case_id TEXT PRIMARY KEY,
    integrated_luminosity_inv_fb REAL NOT NULL,
    cross_section_fb REAL NOT NULL,
    efficiency REAL NOT NULL,
    acceptance REAL NOT NULL,
    background_events REAL NOT NULL,
    notes TEXT
);

CREATE TABLE detector_response_cases (
    case_id TEXT PRIMARY KEY,
    energy_resolution_fraction REAL NOT NULL,
    efficiency REAL NOT NULL,
    background_level REAL NOT NULL,
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

CREATE TABLE inference_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    numerical_method TEXT,
    parameter_summary TEXT,
    output_summary TEXT,
    created_at TEXT NOT NULL
);

INSERT INTO scattering_constants VALUES
('h', 6.62607015e-34, 'J s', 'Planck constant exact SI'),
('hbar', 1.054571817e-34, 'J s', 'reduced Planck constant'),
('electron_charge', 1.602176634e-19, 'C', 'elementary charge exact SI'),
('speed_of_light', 299792458, 'm s^-1', 'exact SI'),
('barn', 1e-28, 'm^2', 'standard cross-section unit'),
('millibarn', 1e-31, 'm^2', '10^-3 barn'),
('microbarn', 1e-34, 'm^2', '10^-6 barn'),
('nanobarn', 1e-37, 'm^2', '10^-9 barn'),
('picobarn', 1e-40, 'm^2', '10^-12 barn'),
('femtobarn', 1e-43, 'm^2', '10^-15 barn');

INSERT INTO angular_distribution_cases VALUES
('isotropic', 1.0, 0.0, 20000, 'isotropic angular distribution'),
('mild_anisotropy', 1.0, 0.5, 20000, 'moderate cos squared anisotropy'),
('strong_anisotropy', 1.0, 1.0, 20000, 'stronger angular anisotropy'),
('larger_scale', 2.0, 1.0, 20000, 'larger normalization'),
('forward_weighted', 0.5, 2.0, 20000, 'larger angular coefficient');

INSERT INTO resonance_cases VALUES
('baseline_resonance', 1.0, 0.12, 8.0, 0.5, 0.5, 1.5, 80, 42, 'baseline Breit-Wigner scaffold'),
('narrow_resonance', 1.0, 0.06, 8.0, 0.5, 0.7, 1.3, 80, 101, 'narrower resonance peak'),
('broad_resonance', 1.0, 0.24, 8.0, 0.5, 0.4, 1.6, 80, 202, 'broader resonance peak'),
('higher_background', 1.0, 0.12, 8.0, 1.5, 0.5, 1.5, 80, 303, 'higher nonresonant background');

INSERT INTO physical_relations VALUES
(1, 'scattering wavefunction', 'psi(r) ~ exp(ikz) + f(theta,phi) exp(ikr)/r', 'psi,k,r,f,theta,phi', 'incident plane wave plus outgoing spherical wave'),
(2, 'differential cross section', 'd sigma / d Omega = |f(theta,phi)|^2', 'sigma,Omega,f', 'angular scattering probability density'),
(3, 'total cross section', 'sigma_total = integral (d sigma/d Omega) d Omega', 'sigma_total,Omega', 'integrated effective interaction probability'),
(4, 'azimuthal total cross section', 'sigma_total = 2 pi integral_0^pi (d sigma/d Omega)(theta) sin(theta) d theta', 'sigma_total,theta', 'total cross section for azimuthal symmetry'),
(5, 'Born approximation', 'f(q) = -m/(2 pi hbar^2) integral exp(-i q dot r) V(r) d^3r', 'f,q,m,hbar,V', 'first-order weak-potential scattering amplitude'),
(6, 'partial-wave amplitude', 'f(theta) = (1/k) sum_l (2l+1) exp(i delta_l) sin(delta_l) P_l(cos theta)', 'f,k,l,delta_l,P_l', 'central-potential scattering amplitude by angular momentum channel'),
(7, 'partial-wave total cross section', 'sigma_el = (4 pi/k^2) sum_l (2l+1) sin^2(delta_l)', 'sigma_el,k,l,delta_l', 'elastic cross section by phase shifts'),
(8, 'optical theorem', 'sigma_total = (4 pi/k) Im f(0)', 'sigma_total,k,f', 'unitarity relation between forward amplitude and total cross section'),
(9, 'Breit-Wigner resonance', 'sigma(E) = sigma0 (Gamma^2/4)/((E-E_R)^2 + Gamma^2/4)', 'sigma,E,E_R,Gamma', 'simple resonance cross-section form'),
(10, 'event rate', 'R = L sigma', 'R,L,sigma', 'instantaneous rate from luminosity and cross section'),
(11, 'expected observed count', 'N_obs = L_int sigma epsilon A + N_background', 'N,L_int,sigma,epsilon,A', 'counting-experiment cross-section inference'),
(12, 'Poisson likelihood', 'P(n|s,b) = ((s+b)^n exp(-(s+b)))/n!', 'n,s,b', 'counting uncertainty model');

INSERT INTO source_notes VALUES
(1, 'MIT Quantum Physics III Scattering', 'MIT OpenCourseWare', 'scattering lectures covering amplitude cross sections partial waves phase shifts and optical theorem', 'https://ocw.mit.edu/courses/8-06-quantum-physics-iii-spring-2018/pages/video-lectures/scattering-and-identical-particles/'),
(2, 'MIT Quantum Physics III Chapter 7', 'MIT OpenCourseWare', 'scattering lecture notes', 'https://ocw.mit.edu/courses/8-06-quantum-physics-iii-spring-2018/45dbd7038c3e969491eceeae86c44d42_MIT8_06S18ch7.pdf'),
(3, 'CERN Luminosity Diagnostics', 'CERN Accelerator School', 'luminosity event rates and cross sections', 'https://cas.web.cern.ch/sites/default/files/lectures/dourdan-2008/wenninger-luninosity.pdf'),
(4, 'CERN LHC Cross Section', 'CERN', 'cross section and event rate explanation', 'https://www.lhc-closer.es/taking_a_closer_look_at_lhc/0.cross_section'),
(5, 'NIST Neutron Cross Section Standards', 'NIST', 'neutron cross-section metrology standards', 'https://www.nist.gov/programs-projects/basic-metrology-neutron-cross-section-standards'),
(6, 'NIST Neutron Scattering Lengths and Cross Sections', 'NIST Center for Neutron Research', 'neutron scattering lengths and cross-section tables', 'https://www.nist.gov/ncnr/planning-your-experiment/scattering-length-periodic-table'),
(7, 'PDG Cross Section Formulae', 'Particle Data Group', 'specific high-energy process cross-section formulae', 'https://pdg.lbl.gov/2023/reviews/rpp2023-rev-cross-section-formulae.pdf');

INSERT INTO model_assumptions VALUES
(1, 'angular_cross_section_integration', 'Uses a simple analytic angular model with azimuthal symmetry.'),
(2, 'resonance_breit_wigner_fit', 'Uses a simple noninterfering Breit-Wigner resonance plus flat background.'),
(3, 'born_approximation_gaussian_potential', 'Uses dimensionless units and a Gaussian potential scaffold.'),
(4, 'partial_wave_phase_shift_table', 'Uses toy phase-shift values rather than solving the radial Schrodinger equation.'),
(5, 'event_rate_inference', 'Uses simple event-count formula with fixed efficiency, acceptance, and background.'),
(6, 'detector_smearing_scaffold', 'Uses Gaussian energy smearing and simplified efficiency.');

INSERT INTO inference_runs VALUES
(1, 'scattering-theory-cross-sections-and-physical-inference', 'angular_cross_section_integration', 'trapezoid_integration', 'sigma0 alpha cases', 'numeric and analytic total cross sections', '2026-04-25'),
(2, 'scattering-theory-cross-sections-and-physical-inference', 'resonance_breit_wigner_fit', 'weighted_least_squares', 'resonance cases', 'parameter estimates and standard errors', '2026-04-25'),
(3, 'scattering-theory-cross-sections-and-physical-inference', 'born_approximation_gaussian_potential', 'closed_form_fourier_transform', 'Gaussian potential cases', 'Born amplitude and differential cross-section table', '2026-04-25'),
(4, 'scattering-theory-cross-sections-and-physical-inference', 'partial_wave_phase_shift_table', 'toy_phase_shift_summation', 'partial wave cases', 'phase-shift contributions and total elastic cross section', '2026-04-25'),
(5, 'scattering-theory-cross-sections-and-physical-inference', 'event_rate_inference', 'closed_form_count_expectation', 'luminosity cross-section efficiency cases', 'expected counts and simple significance metrics', '2026-04-25'),
(6, 'scattering-theory-cross-sections-and-physical-inference', 'detector_smearing_scaffold', 'Monte Carlo smearing', 'detector response cases', 'smeared event samples and summary tables', '2026-04-25');

SELECT relation_name, equation_text, interpretation
FROM physical_relations
ORDER BY relation_id;

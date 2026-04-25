-- Semiconductor Physics and Electronic Materials Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores semiconductor constants, material parameters, doping and mobility cases,
-- diode parameters, p-n junction cases, MOS oxide cases, physical relations,
-- model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS semiconductor_constants;
DROP TABLE IF EXISTS material_parameter_cases;
DROP TABLE IF EXISTS doping_mobility_cases;
DROP TABLE IF EXISTS diode_parameter_cases;
DROP TABLE IF EXISTS pn_junction_cases;
DROP TABLE IF EXISTS mos_oxide_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE semiconductor_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE material_parameter_cases (
    material TEXT PRIMARY KEY,
    band_gap_ev REAL NOT NULL,
    nc_cm3 REAL NOT NULL,
    nv_cm3 REAL NOT NULL,
    electron_mobility_cm2_v_s REAL NOT NULL,
    hole_mobility_cm2_v_s REAL NOT NULL,
    relative_permittivity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE doping_mobility_cases (
    case_id TEXT PRIMARY KEY,
    carrier_type TEXT NOT NULL,
    carrier_concentration_cm3 REAL NOT NULL,
    mobility_cm2_v_s REAL NOT NULL,
    temperature_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE diode_parameter_cases (
    case_id TEXT PRIMARY KEY,
    saturation_current_a REAL NOT NULL,
    ideality_factor REAL NOT NULL,
    temperature_k REAL NOT NULL,
    area_cm2 REAL NOT NULL,
    voltage_min_v REAL NOT NULL,
    voltage_max_v REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE pn_junction_cases (
    case_id TEXT PRIMARY KEY,
    acceptor_cm3 REAL NOT NULL,
    donor_cm3 REAL NOT NULL,
    intrinsic_cm3 REAL NOT NULL,
    relative_permittivity REAL NOT NULL,
    temperature_k REAL NOT NULL,
    applied_voltage_v REAL NOT NULL,
    notes TEXT
);

CREATE TABLE mos_oxide_cases (
    case_id TEXT PRIMARY KEY,
    relative_permittivity REAL NOT NULL,
    oxide_thickness_nm REAL NOT NULL,
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

INSERT INTO semiconductor_constants VALUES
('elementary_charge', 1.602176634e-19, 'C', 'exact SI value'),
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('vacuum_permittivity', 8.8541878128e-12, 'F m^-1', 'electric constant'),
('silicon_relative_permittivity', 11.7, 'dimensionless', 'illustrative silicon value'),
('silicon_dioxide_relative_permittivity', 3.9, 'dimensionless', 'illustrative oxide value'),
('room_temperature', 300, 'K', 'standard educational calculation temperature'),
('ev_to_joule', 1.602176634e-19, 'J per eV', 'exact conversion');

INSERT INTO material_parameter_cases VALUES
('silicon_300k', 1.12, 2.8e19, 1.04e19, 1400, 450, 11.7, 'illustrative silicon at room temperature'),
('germanium_300k', 0.66, 1.04e19, 6.0e18, 3900, 1900, 16.0, 'illustrative germanium'),
('gallium_arsenide_300k', 1.42, 4.7e17, 7.0e18, 8500, 400, 12.9, 'illustrative GaAs'),
('silicon_carbide_4h_300k', 3.26, 1.6e19, 2.5e19, 900, 120, 9.7, 'illustrative wide-bandgap SiC'),
('gallium_nitride_300k', 3.4, 2.3e18, 4.6e19, 1000, 30, 9.5, 'illustrative GaN');

INSERT INTO doping_mobility_cases VALUES
('n_light_doping', 'n', 1.0e14, 1400, 300, 'light n-type silicon-like case'),
('n_medium_doping', 'n', 1.0e16, 1000, 300, 'moderate n-type case'),
('n_heavy_doping', 'n', 1.0e18, 250, 300, 'heavily doped n-type case'),
('p_light_doping', 'p', 1.0e14, 450, 300, 'light p-type case'),
('p_medium_doping', 'p', 1.0e16, 300, 300, 'moderate p-type case'),
('p_heavy_doping', 'p', 1.0e18, 100, 300, 'heavily doped p-type case');

INSERT INTO diode_parameter_cases VALUES
('ideal_room_temperature', 1.0e-12, 1.0, 300, 1.0e-4, -0.5, 0.8, 132, 'article baseline'),
('recombination_diode', 1.0e-12, 2.0, 300, 1.0e-4, -0.5, 0.8, 132, 'higher ideality factor'),
('higher_temperature', 1.0e-11, 1.0, 350, 1.0e-4, -0.5, 0.8, 132, 'illustrative higher temperature and Is'),
('lower_saturation_current', 1.0e-14, 1.0, 300, 1.0e-4, -0.5, 0.8, 132, 'lower leakage baseline');

INSERT INTO pn_junction_cases VALUES
('symmetric_moderate', 1.0e16, 1.0e16, 1.0e10, 11.7, 300, 0.0, 'symmetric abrupt junction'),
('asymmetric_p_heavy', 1.0e18, 1.0e16, 1.0e10, 11.7, 300, 0.0, 'p-side heavily doped'),
('reverse_bias', 1.0e16, 1.0e16, 1.0e10, 11.7, 300, -5.0, 'reverse biased junction'),
('forward_bias', 1.0e16, 1.0e16, 1.0e10, 11.7, 300, 0.5, 'forward bias within depletion approximation limit'),
('wide_gap_low_ni', 1.0e17, 1.0e17, 1.0e-2, 9.7, 300, 0.0, 'wide-bandgap illustrative case');

INSERT INTO mos_oxide_cases VALUES
('sio2_10nm', 3.9, 10.0, 'classic silicon dioxide educational case'),
('sio2_2nm', 3.9, 2.0, 'thin oxide illustrative case'),
('highk_5nm', 20.0, 5.0, 'high-k dielectric illustrative case'),
('highk_2nm', 20.0, 2.0, 'thin high-k illustrative case');

INSERT INTO physical_relations VALUES
(1, 'band gap', 'Eg = Ec - Ev', 'Eg,Ec,Ev', 'energy separation between conduction and valence band edges'),
(2, 'Fermi-Dirac distribution', 'f(E)=1/[1+exp((E-EF)/(kB T))]', 'f,E,EF,kB,T', 'occupation probability for fermions'),
(3, 'intrinsic carrier concentration', 'ni=sqrt(Nc Nv) exp[-Eg/(2 kB T)]', 'ni,Nc,Nv,Eg,kB,T', 'thermal carrier concentration in intrinsic semiconductor'),
(4, 'mass-action relation', 'np=ni^2', 'n,p,ni', 'equilibrium carrier relation under nondegenerate assumptions'),
(5, 'conductivity', 'sigma=q(n mu_n + p mu_p)', 'sigma,q,n,p,mu_n,mu_p', 'carrier contribution to electrical conductivity'),
(6, 'Einstein relation', 'D=mu kB T/q', 'D,mu,kB,T,q', 'relation between diffusion coefficient and mobility'),
(7, 'built-in potential', 'Vbi=(kB T/q) ln(NA ND/ni^2)', 'Vbi,kB,T,q,NA,ND,ni', 'equilibrium p-n junction potential'),
(8, 'depletion width', 'W=sqrt[(2 eps_s/q)((NA+ND)/(NA ND))(Vbi-V)]', 'W,eps_s,q,NA,ND,Vbi,V', 'abrupt junction depletion width'),
(9, 'ideal diode equation', 'I=Is[exp(qV/(n kB T))-1]', 'I,Is,q,V,n,kB,T', 'ideal diode current-voltage relation'),
(10, 'oxide capacitance', 'Cox=epsilon_ox/t_ox', 'Cox,epsilon_ox,t_ox', 'MOS oxide capacitance per unit area');

INSERT INTO model_metadata VALUES
(1, 'intrinsic_carrier_concentration', 'thermal carriers in intrinsic semiconductor', 'ni', 'nondegenerate approximation and fixed material parameters'),
(2, 'conductivity_model', 'conductivity and resistivity', 'sigma', 'requires mobility model and carrier assumptions'),
(3, 'pn_junction_depletion', 'abrupt junction electrostatics', 'Vbi and W', 'depletion approximation'),
(4, 'ideal_diode_equation', 'current-voltage behavior', 'I', 'ignores series resistance leakage and breakdown'),
(5, 'mos_capacitance', 'oxide gate control', 'Cox', 'does not include interface traps or quantum effects'),
(6, 'mobility_model', 'transport sensitivity', 'mu', 'simplified empirical assumptions'),
(7, 'semiconductor_metadata', 'reproducibility', 'units and assumptions', 'requires disciplined documentation');

INSERT INTO source_notes VALUES
(1, 'MIT Integrated Microelectronic Devices', 'MIT OpenCourseWare', 'semiconductor fundamentals p-n junction MOS contacts MOSFET BJT and scaling', 'https://ocw.mit.edu/courses/6-720j-integrated-microelectronic-devices-spring-2007/'),
(2, 'MIT Physics for Solid-State Applications', 'MIT OpenCourseWare', 'crystal lattices band structure phonons effective mass and transport', 'https://ocw.mit.edu/courses/6-730-physics-for-solid-state-applications-spring-2003/'),
(3, 'MIT Microelectronic Devices and Circuits', 'MIT OpenCourseWare', 'p-n junctions MOSFETs BJTs and microelectronic device physics', 'https://ocw.mit.edu/courses/6-012-microelectronic-devices-and-circuits-fall-2009/pages/lecture-notes/'),
(4, 'NIST CHIPS Metrology Program', 'NIST', 'measurement science for microelectronic materials devices circuits and systems', 'https://www.nist.gov/chips/research-development-programs/metrology-program'),
(5, 'NIST Semiconductors', 'NIST', 'nanofabrication measurement and semiconductor research', 'https://www.nist.gov/semiconductors'),
(6, 'NIST Fundamental Constants', 'NIST', 'CODATA physical constants', 'https://physics.nist.gov/cuu/Constants/'),
(7, 'Sze Physics of Semiconductor Devices', 'Wiley', 'semiconductor device physics reference', 'https://www.wiley.com/en-us/Physics+of+Semiconductor+Devices%2C+3rd+Edition-p-9780471143239'),
(8, 'Yu Cardona Fundamentals of Semiconductors', 'Springer', 'physics and materials properties reference', 'https://link.springer.com/book/10.1007/978-3-642-00710-1');

INSERT INTO model_assumptions VALUES
(1, 'diode_iv_curve', 'Uses the ideal diode equation and does not include series resistance leakage breakdown or recombination-specific branches.'),
(2, 'intrinsic_carrier_concentration', 'Uses nondegenerate carrier statistics with fixed effective densities of states and band gaps.'),
(3, 'pn_junction_electrostatics', 'Uses abrupt junction depletion approximation.'),
(4, 'mos_capacitance', 'Computes oxide capacitance only and does not model interface traps threshold voltage or inversion charge.'),
(5, 'mobility_conductivity_model', 'Approximates carrier concentration and mobility as provided inputs.'),
(6, 'semiconductor_physics_schema', 'Stores educational metadata rather than a production semiconductor device database.');

INSERT INTO simulation_runs VALUES
(1, 'semiconductor-physics-and-electronic-materials', 'diode_iv_curve', 'ideal_diode_equation', 'sample Is ideality temperature and voltage cases', 'I-V curves and summary table', '2026-04-25'),
(2, 'semiconductor-physics-and-electronic-materials', 'intrinsic_carrier_concentration', 'closed_form_non_degenerate_formula', 'sample materials and temperatures', 'intrinsic carrier concentration table', '2026-04-25'),
(3, 'semiconductor-physics-and-electronic-materials', 'pn_junction_electrostatics', 'depletion_approximation', 'abrupt junction cases', 'built-in potential and depletion width table', '2026-04-25'),
(4, 'semiconductor-physics-and-electronic-materials', 'mos_capacitance', 'oxide_capacitance_formula', 'oxide dielectric and thickness cases', 'Cox table', '2026-04-25'),
(5, 'semiconductor-physics-and-electronic-materials', 'mobility_conductivity_model', 'carrier_mobility_conductivity_formula', 'carrier concentration and mobility cases', 'conductivity and resistivity table', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

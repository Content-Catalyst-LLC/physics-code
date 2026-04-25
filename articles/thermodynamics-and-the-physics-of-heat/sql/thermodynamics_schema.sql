-- Thermodynamics and the Physics of Heat Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, process cases, thermal measurements, thermodynamic
-- relations, source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS ideal_gas_process_cases;
DROP TABLE IF EXISTS thermal_measurements;
DROP TABLE IF EXISTS process_metadata;
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

CREATE TABLE ideal_gas_process_cases (
    case_id TEXT PRIMARY KEY,
    amount_mol REAL NOT NULL,
    temperature_k REAL NOT NULL,
    initial_volume_m3 REAL NOT NULL,
    final_volume_m3 REAL NOT NULL,
    heat_capacity_ratio REAL NOT NULL,
    cv_j_per_mol_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE thermal_measurements (
    sample_id TEXT PRIMARY KEY,
    mass_kg REAL NOT NULL,
    specific_heat_j_per_kg_k REAL NOT NULL,
    initial_temperature_k REAL NOT NULL,
    final_temperature_k REAL NOT NULL,
    heat_added_j REAL NOT NULL,
    notes TEXT
);

CREATE TABLE process_metadata (
    process_id INTEGER PRIMARY KEY,
    process_name TEXT NOT NULL,
    fixed_or_controlled_quantities TEXT NOT NULL,
    key_relation TEXT NOT NULL,
    primary_quantity TEXT NOT NULL,
    limitation TEXT
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
(1, 'Boltzmann constant', 'k_B', 1.380649e-23, 'J K^-1', 'exact SI value'),
(2, 'Avogadro constant', 'N_A', 6.02214076e23, 'mol^-1', 'exact SI value'),
(3, 'gas constant', 'R', 8.31446261815324, 'J mol^-1 K^-1', 'derived from N_A k_B'),
(4, 'standard atmosphere', 'atm', 101325.0, 'Pa', 'standard pressure unit'),
(5, 'room temperature', 'T_room', 300.0, 'K', 'article example temperature');

INSERT INTO ideal_gas_process_cases (
    case_id,
    amount_mol,
    temperature_k,
    initial_volume_m3,
    final_volume_m3,
    heat_capacity_ratio,
    cv_j_per_mol_k,
    notes
) VALUES
('base_expansion', 1.0, 300, 0.02, 0.08, 1.4, 20.786, 'article base example'),
('small_expansion', 1.0, 300, 0.02, 0.04, 1.4, 20.786, 'smaller volume ratio'),
('warm_expansion', 1.0, 400, 0.02, 0.08, 1.4, 20.786, 'higher temperature comparison'),
('diatomic_like', 1.0, 300, 0.02, 0.08, 1.4, 20.786, 'diatomic ideal gas approximation'),
('monatomic_like', 1.0, 300, 0.02, 0.08, 1.6666667, 12.4717, 'monatomic ideal gas approximation');

INSERT INTO thermal_measurements (
    sample_id,
    mass_kg,
    specific_heat_j_per_kg_k,
    initial_temperature_k,
    final_temperature_k,
    heat_added_j,
    notes
) VALUES
('water_like_01', 0.25, 4184, 293.15, 303.15, 10460, 'illustrative calorimetry example'),
('water_like_02', 0.50, 4184, 293.15, 313.15, 41840, 'illustrative calorimetry example'),
('aluminum_like_01', 0.30, 900, 293.15, 323.15, 8100, 'illustrative calorimetry example'),
('copper_like_01', 0.40, 385, 293.15, 313.15, 3080, 'illustrative calorimetry example'),
('glass_like_01', 0.20, 840, 293.15, 333.15, 6720, 'illustrative calorimetry example');

INSERT INTO process_metadata (
    process_id,
    process_name,
    fixed_or_controlled_quantities,
    key_relation,
    primary_quantity,
    limitation
) VALUES
(1, 'isothermal ideal gas', 'T,n', 'PV=nRT and W=nRT ln(V2/V1)', 'work and entropy', 'ideal gas and reversible path'),
(2, 'adiabatic reversible ideal gas', 'Q=0,n', 'PV^gamma=constant', 'work and temperature change', 'requires reversibility and constant gamma'),
(3, 'constant pressure heating', 'P,n', 'W=P Delta V and Delta H=nCp DeltaT', 'enthalpy and heat', 'simple compressible ideal gas'),
(4, 'constant volume heating', 'V,n', 'W=0 and Delta U=nCv DeltaT', 'internal energy and heat', 'no boundary work'),
(5, 'Carnot cycle', 'Th,Tc', 'eta=1-Tc/Th', 'maximum efficiency', 'ideal reversible engine'),
(6, 'free energy constant T P', 'T,P', 'G=H-TS', 'spontaneity criterion', 'equilibrium thermodynamic condition');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'ideal gas law', 'PV = nRT', 'P,V,n,R,T', 'equation of state for ideal gas'),
(2, 'first law', 'dU = delta Q - delta W', 'U,Q,W', 'energy conservation for thermodynamic systems'),
(3, 'isothermal work', 'W = nRT ln(V2/V1)', 'W,n,R,T,V1,V2', 'reversible isothermal ideal-gas expansion work'),
(4, 'entropy change ideal gas', 'Delta S = nCv ln(T2/T1) + nR ln(V2/V1)', 'S,n,Cv,T,V,R', 'reversible ideal-gas entropy change'),
(5, 'Carnot efficiency', 'eta = 1 - Tc/Th', 'eta,Tc,Th', 'maximum ideal heat-engine efficiency'),
(6, 'enthalpy', 'H = U + PV', 'H,U,P,V', 'thermodynamic potential useful at constant pressure'),
(7, 'Helmholtz free energy', 'F = U - TS', 'F,U,T,S', 'thermodynamic potential useful at constant temperature and volume'),
(8, 'Gibbs free energy', 'G = H - TS', 'G,H,T,S', 'thermodynamic potential useful at constant temperature and pressure'),
(9, 'adiabatic ideal gas', 'PV^gamma = constant', 'P,V,gamma', 'reversible adiabatic ideal-gas relation');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'ideal gas law', 'relate P V n T', 'R', 'neglects intermolecular interactions'),
(2, 'isothermal work', 'compute reversible expansion work', 'W', 'requires reversible ideal-gas path'),
(3, 'adiabatic relation', 'model insulated reversible expansion', 'gamma', 'constant heat-capacity ratio assumed'),
(4, 'Carnot efficiency', 'upper bound for heat engines', 'eta', 'ideal reversible reservoirs'),
(5, 'entropy accounting', 'measure directional process structure', 'Delta S', 'requires careful system boundary'),
(6, 'free energy', 'spontaneity under constraints', 'F or G', 'equilibrium thermodynamic criterion'),
(7, 'response functions', 'material response to perturbation', 'Cp Cv alpha kappa', 'requires measured or modeled properties');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'BIPM kelvin mise en pratique', 'BIPM', 'kelvin definition realization guidance', 'https://www.bipm.org/documents/20126/41489682/SI-App2-kelvin.pdf'),
(3, 'BIPM kelvin base unit', 'BIPM', 'kelvin base unit definition', 'https://www.bipm.org/en/si-base-units/kelvin'),
(4, 'NIST Boltzmann constant', 'NIST', 'exact Boltzmann constant value', 'https://physics.nist.gov/cgi-bin/cuu/Value?k='),
(5, 'NIST Kelvin thermodynamic temperature', 'NIST', 'kelvin redefinition explanation', 'https://www.nist.gov/si-redefinition/kelvin/kelvin-thermodynamic-temperature'),
(6, 'MIT Thermodynamics and Kinetics', 'MIT OpenCourseWare', 'equilibrium thermodynamics and kinetics course', 'https://ocw.mit.edu/courses/5-60-thermodynamics-kinetics-spring-2008/'),
(7, 'Carnot Reflections', 'University of Pittsburgh', 'foundational heat-engine text', 'https://sites.pitt.edu/~jdnorton/teaching/2559_Therm_Stat_Mech/docs/Carnot%20Reflections%201897%20facsimile.pdf'),
(8, 'Clausius Mechanical Theory of Heat', 'Internet Archive', 'mechanical theory of heat source text', 'https://ia601306.us.archive.org/8/items/cu31924101120883/cu31924101120883.pdf'),
(9, 'Maxwell Theory of Heat', 'Internet Archive', 'classical thermodynamics text', 'https://dn721704.ca.archive.org/0/items/theoryofheat00maxwuoft/theoryofheat00maxwuoft.pdf');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'process_paths', 'Uses ideal-gas relations and simple compressible system assumptions.'),
(2, 'process_paths', 'Uses sign convention where work done by the gas is positive.'),
(3, 'carnot_efficiency_surface', 'Computes ideal reversible upper-bound efficiencies, not real-engine efficiencies.'),
(4, 'free_energy_surface', 'Uses a linearized illustrative Gibbs free-energy relation, not a real-material property model.'),
(5, 'isothermal_entropy_accounting', 'Assumes reversible isothermal ideal-gas expansion.'),
(6, 'thermodynamics_schema', 'Stores educational metadata rather than a production thermophysical-property database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'thermodynamics-and-the-physics-of-heat', 'process_paths', 'closed_form_grid', '1 mol ideal gas, 300 K, V1=0.02 m3, V2=0.08 m3', 'isothermal and adiabatic paths plus process summary', '2026-04-25'),
(2, 'thermodynamics-and-the-physics-of-heat', 'carnot_efficiency_surface', 'parameter_grid', 'Th=350..1200 K, Tc=250..500 K', 'Carnot efficiency surface', '2026-04-25'),
(3, 'thermodynamics-and-the-physics-of-heat', 'free_energy_surface', 'linearized_grid', 'T=250..450 K, P=80..200 kPa', 'illustrative Gibbs free-energy surface', '2026-04-25'),
(4, 'thermodynamics-and-the-physics-of-heat', 'isothermal_entropy_accounting', 'analytic_and_numeric_work', '1 mol, 300 K, V1=0.02 m3, V2=0.08 m3', 'isothermal work and entropy accounting', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

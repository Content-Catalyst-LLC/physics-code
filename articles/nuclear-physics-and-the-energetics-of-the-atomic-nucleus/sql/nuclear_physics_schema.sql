-- Nuclear Physics and the Energetics of the Atomic Nucleus Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores isotope metadata, decay modes, nuclear relations, nuclear models,
-- nuclear-data sources, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS isotopes;
DROP TABLE IF EXISTS decay_modes;
DROP TABLE IF EXISTS nuclear_relations;
DROP TABLE IF EXISTS nuclear_models;
DROP TABLE IF EXISTS nuclear_data_sources;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE isotopes (
    isotope_id INTEGER PRIMARY KEY,
    nuclide TEXT NOT NULL,
    z INTEGER NOT NULL,
    n INTEGER NOT NULL,
    a INTEGER NOT NULL,
    half_life TEXT,
    decay_mode TEXT,
    notes TEXT
);

CREATE TABLE decay_modes (
    decay_mode_id INTEGER PRIMARY KEY,
    decay_mode TEXT NOT NULL,
    composition_change TEXT NOT NULL,
    interaction_or_process TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE nuclear_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    variables TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE nuclear_models (
    model_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    primary_focus TEXT NOT NULL,
    strength TEXT NOT NULL,
    limitation TEXT
);

CREATE TABLE nuclear_data_sources (
    source_id INTEGER PRIMARY KEY,
    source_name TEXT NOT NULL,
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

INSERT INTO isotopes (
    isotope_id,
    nuclide,
    z,
    n,
    a,
    half_life,
    decay_mode,
    notes
) VALUES
(1, 'Hydrogen-1', 1, 0, 1, 'stable', 'stable', 'protium'),
(2, 'Helium-4', 2, 2, 4, 'stable', 'stable', 'tightly bound light nucleus'),
(3, 'Carbon-12', 6, 6, 12, 'stable', 'stable', 'carbon isotope'),
(4, 'Carbon-14', 6, 8, 14, '5730 years', 'beta minus', 'radiocarbon dating isotope'),
(5, 'Cobalt-60', 27, 33, 60, '5.27 years', 'beta minus', 'gamma calibration and source example'),
(6, 'Uranium-238', 92, 146, 238, '4.468 billion years', 'alpha', 'long-lived heavy isotope'),
(7, 'Iodine-131', 53, 78, 131, '8.02 days', 'beta minus', 'medical and environmental relevance'),
(8, 'Technetium-99m', 43, 56, 99, '6.01 hours', 'isomeric transition', 'medical imaging relevance');

INSERT INTO decay_modes (
    decay_mode_id,
    decay_mode,
    composition_change,
    interaction_or_process,
    notes
) VALUES
(1, 'alpha', 'Z decreases by 2 and A decreases by 4', 'alpha emission', 'common in heavy nuclei'),
(2, 'beta_minus', 'Z increases by 1 and N decreases by 1', 'weak interaction', 'neutron transforms to proton'),
(3, 'beta_plus', 'Z decreases by 1 and N increases by 1', 'weak interaction', 'proton transforms to neutron with positron emission'),
(4, 'electron_capture', 'Z decreases by 1 and N increases by 1', 'weak interaction', 'orbital electron captured by nucleus'),
(5, 'gamma', 'no Z or N change', 'electromagnetic de-excitation', 'excited nucleus emits photon'),
(6, 'isomeric_transition', 'no Z or N change', 'nuclear state transition', 'metastable nuclear state decays'),
(7, 'spontaneous_fission', 'heavy nucleus splits', 'nuclear deformation and tunneling', 'heavy-nucleus decay process');

INSERT INTO nuclear_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'mass number', 'A = Z + N', 'A,Z,N', 'nuclear composition'),
(2, 'mass energy', 'E = m c^2', 'E,m,c', 'mass-energy equivalence'),
(3, 'binding energy', 'B = delta_m c^2', 'B,delta_m,c', 'binding from mass defect'),
(4, 'decay law', 'N(t) = N0 exp(-lambda t)', 'N,N0,lambda,t', 'radioactive decay population law'),
(5, 'half life', 't_1/2 = ln(2)/lambda', 't_1/2,lambda', 'half-life and decay constant relation'),
(6, 'activity', 'A_act = lambda N', 'A_act,lambda,N', 'decays per unit time'),
(7, 'semi empirical mass formula', 'B = a_v A - a_s A^(2/3) - a_c Z(Z-1)/A^(1/3) - a_a(A-2Z)^2/A + delta', 'B,A,Z,delta', 'broad binding-energy trend model');

INSERT INTO nuclear_models (
    model_id,
    model_name,
    primary_focus,
    strength,
    limitation
) VALUES
(1, 'liquid drop model', 'collective binding trends', 'broad energetics and fission intuition', 'limited fine-structure detail'),
(2, 'shell model', 'single-particle nuclear structure', 'magic numbers spectra spin-parity patterns', 'computational complexity for heavy nuclei'),
(3, 'semi empirical mass formula', 'binding energy systematics', 'compact trend model', 'not precision nuclear mass prediction'),
(4, 'collective model', 'deformation rotation vibration', 'connects spectra to collective motion', 'model-dependent interpretation'),
(5, 'cluster model', 'substructures in light nuclei', 'useful for selected light-nucleus phenomena', 'not universal');

INSERT INTO nuclear_data_sources (
    source_id,
    source_name,
    organization,
    primary_role,
    url
) VALUES
(1, 'IAEA Nuclear Data Services', 'IAEA', 'nuclear and atomic data services', 'https://www-nds.iaea.org/'),
(2, 'IAEA LiveChart of Nuclides', 'IAEA', 'interactive nuclear structure and decay chart', 'https://nds.iaea.org/relnsd/vcharthtml/VChartHTML.html'),
(3, 'NuDat 3', 'NNDC', 'interactive nuclear structure and decay data', 'https://www.nndc.bnl.gov/nudat3/'),
(4, 'NIST Radioactivity Group', 'NIST', 'radioactivity metrology and nuclear data measurement', 'https://www.nist.gov/pml/radiation-physics/radioactivity'),
(5, 'PDG Review of Particle Physics', 'Particle Data Group', 'particle and fundamental physics reference', 'https://pdg.lbl.gov/');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'decay_binding_energy', 'Uses single-isotope exponential decay without daughter buildup.'),
(2, 'decay_binding_energy', 'Uses approximate educational helium-4 nuclear mass values.'),
(3, 'semi_empirical_mass_formula', 'Uses a simplified semi-empirical mass formula with standard illustrative coefficients.'),
(4, 'half_life_decay_fit', 'Fits log counts with a linear model and assumes exponential decay dominates.'),
(5, 'isotope_summary', 'Uses small sample isotope metadata for educational tabulation.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'nuclear-physics-and-the-energetics-of-the-atomic-nucleus', 'decay_binding_energy', 'closed_form', 'lambda=0.22 and helium-4 mass sample', 'decay table and binding-energy table', '2026-04-24'),
(2, 'nuclear-physics-and-the-energetics-of-the-atomic-nucleus', 'semi_empirical_mass_formula', 'closed_form', 'sample isotopes from H-1 to U-238', 'SEMF binding-energy estimates', '2026-04-24'),
(3, 'nuclear-physics-and-the-energetics-of-the-atomic-nucleus', 'half_life_decay_fit', 'log_linear_fit', 'sample decay counts from t=0 to t=8', 'decay constant and half-life estimate', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM nuclear_relations
ORDER BY relation_id;

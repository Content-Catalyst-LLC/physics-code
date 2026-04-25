-- Quantum Fields, Particles, and the Standard Model Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores particles, fields, gauge sectors, interactions, Higgs-sector
-- quantities, physical relations, model assumptions, source notes, and
-- simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS particles;
DROP TABLE IF EXISTS fields;
DROP TABLE IF EXISTS gauge_sectors;
DROP TABLE IF EXISTS higgs_quantities;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE particles (
    particle_id INTEGER PRIMARY KEY,
    particle_name TEXT NOT NULL,
    category TEXT NOT NULL,
    generation INTEGER,
    spin REAL,
    charge_e REAL,
    mass_gev REAL,
    notes TEXT
);

CREATE TABLE fields (
    field_id INTEGER PRIMARY KEY,
    field_name TEXT NOT NULL,
    field_type TEXT NOT NULL,
    associated_particles TEXT,
    transformation_role TEXT,
    notes TEXT
);

CREATE TABLE gauge_sectors (
    sector_id INTEGER PRIMARY KEY,
    sector_name TEXT NOT NULL,
    gauge_group TEXT NOT NULL,
    mediators TEXT NOT NULL,
    interaction TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE higgs_quantities (
    quantity_id INTEGER PRIMARY KEY,
    quantity_name TEXT NOT NULL,
    value REAL,
    unit TEXT,
    interpretation TEXT
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

INSERT INTO particles (
    particle_id,
    particle_name,
    category,
    generation,
    spin,
    charge_e,
    mass_gev,
    notes
) VALUES
(1, 'electron', 'fermion', 1, 0.5, -1.0, 0.000511, 'charged lepton'),
(2, 'muon', 'fermion', 2, 0.5, -1.0, 0.10566, 'charged lepton'),
(3, 'tau', 'fermion', 3, 0.5, -1.0, 1.77686, 'charged lepton'),
(4, 'up quark', 'fermion', 1, 0.5, 0.6666667, 0.00216, 'quark'),
(5, 'down quark', 'fermion', 1, 0.5, -0.3333333, 0.00467, 'quark'),
(6, 'charm quark', 'fermion', 2, 0.5, 0.6666667, 1.27, 'quark'),
(7, 'bottom quark', 'fermion', 3, 0.5, -0.3333333, 4.18, 'quark'),
(8, 'top quark', 'fermion', 3, 0.5, 0.6666667, 172.61, 'quark'),
(9, 'photon', 'gauge boson', NULL, 1.0, 0.0, 0.0, 'electromagnetic gauge boson'),
(10, 'gluon', 'gauge boson', NULL, 1.0, 0.0, 0.0, 'strong interaction gauge boson'),
(11, 'W boson', 'gauge boson', NULL, 1.0, 1.0, 80.0, 'charged weak boson scale'),
(12, 'Z boson', 'gauge boson', NULL, 1.0, 0.0, 91.0, 'neutral weak boson scale'),
(13, 'Higgs boson', 'scalar boson', NULL, 0.0, 0.0, 125.25, 'scalar excitation of Higgs field');

INSERT INTO fields (
    field_id,
    field_name,
    field_type,
    associated_particles,
    transformation_role,
    notes
) VALUES
(1, 'fermion fields', 'spinor', 'quarks and leptons', 'matter representations', 'Standard Model matter fields'),
(2, 'gluon field', 'gauge', 'gluons', 'SU(3)_C gauge field', 'QCD gauge sector'),
(3, 'electroweak gauge fields', 'gauge', 'photon, W bosons, Z boson', 'SU(2)_L x U(1)_Y gauge fields', 'electroweak sector'),
(4, 'Higgs field', 'scalar', 'Higgs boson', 'electroweak symmetry breaking', 'scalar field with nonzero vacuum expectation value');

INSERT INTO gauge_sectors (
    sector_id,
    sector_name,
    gauge_group,
    mediators,
    interaction,
    notes
) VALUES
(1, 'strong', 'SU(3)_C', 'gluons', 'quantum chromodynamics', 'color gauge interaction'),
(2, 'electroweak', 'SU(2)_L x U(1)_Y', 'W bosons, Z boson, photon', 'weak and electromagnetic interactions', 'broken to electromagnetic U(1)'),
(3, 'electromagnetic', 'U(1)_EM', 'photon', 'electromagnetism', 'unbroken low-energy gauge symmetry'),
(4, 'higgs', 'scalar electroweak doublet', 'Higgs boson', 'electroweak symmetry breaking', 'mass generation structure');

INSERT INTO higgs_quantities (
    quantity_id,
    quantity_name,
    value,
    unit,
    interpretation
) VALUES
(1, 'higgs_vev', 246.0, 'GeV', 'electroweak symmetry-breaking scale approximation'),
(2, 'higgs_boson_mass', 125.25, 'GeV', 'illustrative Higgs mass scale'),
(3, 'schematic_mu2', -1.0, 'arbitrary', 'schematic potential coefficient'),
(4, 'schematic_lambda', 0.5, 'arbitrary', 'schematic quartic coefficient');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'standard_model_gauge_group', 'SU(3)_C x SU(2)_L x U(1)_Y', 'SU3,SU2,U1', 'internal gauge symmetry structure of the Standard Model'),
(2, 'klein_gordon_equation', '(partial_t^2 - nabla^2 + m^2) phi = 0', 'phi,m', 'free scalar-field equation in natural-unit schematic form'),
(3, 'dirac_equation', '(i gamma^mu partial_mu - m) psi = 0', 'gamma,psi,m', 'free spinor-field equation'),
(4, 'covariant_derivative', 'D_mu = partial_mu + i g A_mu', 'D,partial,g,A', 'gauge-covariant derivative in schematic Abelian form'),
(5, 'higgs_potential', 'V(phi)=mu2 phi^2 + lambda phi^4', 'V,phi,mu2,lambda', 'schematic scalar symmetry-breaking potential'),
(6, 'yukawa_mass_relation', 'm_f = y_f v / sqrt(2)', 'm_f,y_f,v', 'fermion mass relation after electroweak symmetry breaking'),
(7, 'yukawa_coupling_relation', 'y_f = sqrt(2) m_f / v', 'y_f,m_f,v', 'Yukawa coupling inferred from fermion mass and Higgs vev');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'yukawa_higgs_potential', 'Uses illustrative fermion masses and a Higgs vev of 246 GeV.'),
(2, 'yukawa_higgs_potential', 'Uses a one-dimensional scalar potential as a teaching scaffold, not the full Higgs doublet.'),
(3, 'running_coupling_toy_model', 'Uses a schematic scale-dependence formula, not a precision renormalization-group equation.'),
(4, 'particle_metadata_summary', 'Uses a compact educational particle table rather than a complete evaluated database.'),
(5, 'standard_model_schema', 'Stores metadata for education and reproducibility rather than precision particle-data review.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'CERN Standard Model', 'https://home.cern/science/physics/standard-model', 'Standard Model', 'Official CERN explanatory reference for Standard Model particle physics.'),
(2, 'CERN Higgs Boson', 'https://home.cern/science/physics/higgs-boson', 'Higgs field', 'CERN overview of the Higgs boson and Higgs field.'),
(3, 'Particle Data Group Review of Particle Physics', 'https://pdg.lbl.gov/', 'particle data', 'Evaluated particle physics reference and review infrastructure.'),
(4, 'PDG Electroweak Model and Constraints on New Physics', 'https://ccwww.kek.jp/pdg/2025/reviews/rpp2025-rev-standard-model.pdf', 'precision electroweak', 'Current electroweak Standard Model review and constraints.'),
(5, 'Dirac Quantum Theory of the Electron', 'https://royalsocietypublishing.org/doi/10.1098/rspa.1928.0023', 'Dirac equation', 'Foundational relativistic quantum electron paper.'),
(6, 'Glashow Partial Symmetries of Weak Interactions', 'https://inspirehep.net/literature/4328', 'electroweak theory', 'Foundational weak-interaction symmetry paper metadata.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'quantum-fields-particles-and-the-standard-model', 'yukawa_higgs_potential', 'closed_form_and_grid_scan', 'fermion masses and phi from -3 to 3', 'Yukawa table and potential minima', '2026-04-24'),
(2, 'quantum-fields-particles-and-the-standard-model', 'running_coupling_toy_model', 'closed_form_grid', 'mu from 1 GeV to 100000 GeV', 'toy running-coupling table', '2026-04-24'),
(3, 'quantum-fields-particles-and-the-standard-model', 'particle_metadata_summary', 'grouped_summary', 'sample Standard Model particle table', 'category summary', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

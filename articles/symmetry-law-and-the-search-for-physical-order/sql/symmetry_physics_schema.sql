-- Symmetry, Law, and the Search for Physical Order Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores symmetry types, associated conservation laws, physical examples,
-- model assumptions, source notes, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS symmetry_types;
DROP TABLE IF EXISTS conservation_laws;
DROP TABLE IF EXISTS physical_examples;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE symmetry_types (
    symmetry_id INTEGER PRIMARY KEY,
    symmetry_name TEXT NOT NULL,
    transformation TEXT NOT NULL,
    symmetry_class TEXT NOT NULL,
    physical_role TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE conservation_laws (
    conservation_id INTEGER PRIMARY KEY,
    symmetry_name TEXT NOT NULL,
    conserved_quantity TEXT NOT NULL,
    noether_connection TEXT NOT NULL,
    example_system TEXT
);

CREATE TABLE physical_examples (
    example_id INTEGER PRIMARY KEY,
    topic TEXT NOT NULL,
    example_name TEXT NOT NULL,
    governing_expression TEXT,
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

INSERT INTO symmetry_types (
    symmetry_id,
    symmetry_name,
    transformation,
    symmetry_class,
    physical_role,
    notes
) VALUES
(1, 'time translation', 't -> t + epsilon', 'continuous spacetime', 'supports energy conservation', 'Noether-style example'),
(2, 'spatial translation', 'x -> x + epsilon', 'continuous spacetime', 'supports momentum conservation', 'Noether-style example'),
(3, 'rotation', 'spatial rotation', 'continuous spacetime', 'supports angular momentum conservation', 'Noether-style example'),
(4, 'reflection', 'x -> -x', 'discrete spacetime', 'parity-style comparison', 'may be violated in weak interactions'),
(5, 'global phase', 'psi -> exp(i alpha) psi', 'continuous internal', 'supports charge-style conservation', 'simplified quantum example'),
(6, 'local gauge phase', 'psi(x) -> exp(i alpha(x)) psi(x)', 'local internal', 'requires gauge-field structure', 'gauge theory context'),
(7, 'spontaneous symmetry breaking', 'symmetric law with asymmetric selected state', 'realization pattern', 'generates ordered phases', 'condensed matter and Higgs-style intuition');

INSERT INTO conservation_laws (
    conservation_id,
    symmetry_name,
    conserved_quantity,
    noether_connection,
    example_system
) VALUES
(1, 'time translation', 'energy', 'continuous time invariance of action', 'time-independent harmonic oscillator'),
(2, 'spatial translation', 'linear momentum', 'continuous spatial invariance of action', 'free particle'),
(3, 'rotation', 'angular momentum', 'continuous rotational invariance of action', 'central-force system'),
(4, 'global phase', 'charge', 'continuous internal phase invariance', 'complex field example');

INSERT INTO physical_examples (
    example_id,
    topic,
    example_name,
    governing_expression,
    interpretation
) VALUES
(1, 'reflection symmetry', 'symmetric potential', 'V(x)=x^2', 'invariant under x -> -x'),
(2, 'explicit symmetry breaking', 'tilted potential', 'V(x)=x^2 + epsilon*x', 'reflection symmetry broken by linear term'),
(3, 'spontaneous symmetry breaking', 'double-well potential', 'V(x)=-a*x^2+b*x^4', 'symmetric potential with nonzero minima'),
(4, 'Noether-style conservation', 'harmonic oscillator', 'E=0.5*m*v^2+0.5*k*x^2', 'ideal total energy is conserved'),
(5, 'gauge-phase invariance', 'phase transformation', 'psi -> exp(i alpha) psi', 'modulus squared remains invariant');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'reflection_symmetry_summary', 'Uses one-dimensional toy potentials.'),
(2, 'symmetry_breaking_potential_scan', 'The double-well potential is a conceptual scaffold, not a full field-theory model.'),
(3, 'noether_energy_conservation', 'Uses the ideal analytic harmonic oscillator with no damping.'),
(4, 'gauge_phase_invariance_demo', 'Uses a global phase transformation as a simplified gateway to gauge ideas.'),
(5, 'potential_parameter_sweep', 'Parameter values are educational and not fitted to a physical material or field theory.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'Stanford Encyclopedia of Philosophy: Symmetry and Symmetry Breaking', 'https://plato.stanford.edu/entries/symmetry-breaking/', 'symmetry and philosophy of physics', 'Overview of symmetry, symmetry breaking, gauge symmetry, and parity violation.'),
(2, 'Stanford Encyclopedia of Philosophy: Gauge Theories in Physics', 'https://plato.stanford.edu/entries/gauge-theories/', 'gauge theory', 'Overview of gauge theories and representation questions.'),
(3, 'CERN Standard Model', 'https://home.cern/science/physics/standard-model', 'Standard Model', 'CERN overview of Standard Model particles and interactions.'),
(4, 'ATLAS Higgs Mechanism', 'https://atlas.cern/Updates/Press-Statement/Under-Hood-Higgs', 'Higgs mechanism', 'ATLAS explanation of electroweak symmetry breaking and BEH mechanism.'),
(5, 'APS Robustness of Noether Principle', 'https://link.aps.org/doi/10.1103/PhysRevX.10.041035', 'Noether theorem', 'Quantum-information perspective on symmetry and conservation.'),
(6, 'Brown and Holland Noether perspective', 'https://arxiv.org/pdf/2010.10909', 'Noether theorem', 'Perspective on whether symmetries explain conservation laws.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'symmetry-law-and-the-search-for-physical-order', 'reflection_symmetry_summary', 'closed_form', 'x values from -3 to 3', 'reflection difference table', '2026-04-24'),
(2, 'symmetry-law-and-the-search-for-physical-order', 'symmetry_breaking_potential_scan', 'grid_scan', 'double-well potential from -3 to 3', 'potential minima table', '2026-04-24'),
(3, 'symmetry-law-and-the-search-for-physical-order', 'noether_energy_conservation', 'analytic_table', 'harmonic oscillator from t=0 to 10', 'energy conservation summary', '2026-04-24'),
(4, 'symmetry-law-and-the-search-for-physical-order', 'gauge_phase_invariance_demo', 'complex_phase_transform', 'global phase alpha=pi/3', 'modulus invariance table', '2026-04-24');

SELECT
    symmetry_name,
    transformation,
    physical_role
FROM symmetry_types
ORDER BY symmetry_id;

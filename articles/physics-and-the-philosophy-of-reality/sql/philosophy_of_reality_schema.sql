-- Philosophy of Reality Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores interpretations, formal objects, ontological commitments,
-- philosophical claims, and source notes.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS interpretations;
DROP TABLE IF EXISTS formal_objects;
DROP TABLE IF EXISTS philosophical_claims;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_runs;

CREATE TABLE interpretations (
    interpretation_id INTEGER PRIMARY KEY,
    interpretation_name TEXT NOT NULL,
    wavefunction_status TEXT NOT NULL,
    observer_independent_state INTEGER NOT NULL,
    measurement_role TEXT NOT NULL,
    ontology_notes TEXT
);

CREATE TABLE formal_objects (
    object_id INTEGER PRIMARY KEY,
    symbol TEXT NOT NULL,
    physics_role TEXT NOT NULL,
    ontological_question TEXT NOT NULL
);

CREATE TABLE philosophical_claims (
    claim_id INTEGER PRIMARY KEY,
    topic TEXT NOT NULL,
    claim_text TEXT NOT NULL,
    confidence_level TEXT NOT NULL,
    limitation TEXT
);

CREATE TABLE source_notes (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    topic TEXT NOT NULL,
    note TEXT
);

CREATE TABLE model_runs (
    run_id INTEGER PRIMARY KEY,
    article_slug TEXT NOT NULL,
    model_name TEXT NOT NULL,
    formal_object TEXT NOT NULL,
    interpretive_issue TEXT NOT NULL,
    created_at TEXT NOT NULL
);

INSERT INTO interpretations (
    interpretation_id,
    interpretation_name,
    wavefunction_status,
    observer_independent_state,
    measurement_role,
    ontology_notes
) VALUES
(1, 'Wavefunction realism', 'physically real', 1, 'requires physical account', 'The wavefunction is treated as part of ontology.'),
(2, 'Epistemic interpretation', 'knowledge or information', 0, 'updates information', 'The wavefunction reflects knowledge or credence.'),
(3, 'Relational interpretation', 'relative state assignment', 0, 'defines relational outcome', 'State assignment depends on physical relation.'),
(4, 'Operational interpretation', 'prediction tool', 0, 'connects preparation and outcome', 'Formalism organizes observable procedures.'),
(5, 'Everettian interpretation', 'universal wavefunction', 1, 'branching structure', 'Measurement outcomes occur across branches.'),
(6, 'Hidden-variable interpretation', 'supplemented by variables', 1, 'reveals configured outcome', 'Wavefunction may guide additional ontology.');

INSERT INTO formal_objects (
    object_id,
    symbol,
    physics_role,
    ontological_question
) VALUES
(1, 'psi', 'quantum state or wavefunction', 'Is it physically real, epistemic, relational, or operational?'),
(2, 'H_hat', 'Hamiltonian operator', 'Does it represent energy structure, dynamical law, or model generator?'),
(3, 'g_mu_nu', 'metric tensor', 'Is spacetime geometry physical, relational, or representational?'),
(4, 'A_mu', 'gauge potential', 'Which parts are physical and which are redundant?'),
(5, 'F_mu_nu', 'field-strength tensor', 'Does invariant field structure identify physical content?'),
(6, 'rho', 'density matrix', 'Does it represent state, knowledge, subsystem state, or ensemble?');

INSERT INTO philosophical_claims (
    claim_id,
    topic,
    claim_text,
    confidence_level,
    limitation
) VALUES
(1, 'scientific realism', 'Predictive success supports some realist commitment.', 'moderate', 'The exact target of commitment remains contested.'),
(2, 'structural realism', 'Mathematical structure may be more stable than ontology across theory change.', 'moderate', 'The meaning of structure is itself debated.'),
(3, 'quantum interpretation', 'Identical formalism can support different ontological interpretations.', 'high', 'Interpretations may differ in explanatory virtues and costs.'),
(4, 'gauge theory', 'Representational redundancy complicates simple realism about formal variables.', 'high', 'The ontology of gauge theory remains philosophically disputed.'),
(5, 'quantum gravity', 'Spacetime ontology may be provisional at the deepest level.', 'moderate', 'No completed empirically confirmed theory of quantum gravity currently settles the issue.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'Scientific Realism - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/scientific-realism/', 'scientific realism', 'Overview of realism and antirealism debates.'),
(2, 'Structural Realism - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/structural-realism/', 'structural realism', 'Overview of structural realism.'),
(3, 'Philosophical Issues in Quantum Theory - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/qt-issues/', 'quantum interpretation', 'Overview of philosophical issues raised by quantum theory.'),
(4, 'Gauge Theories in Physics - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/gauge-theories/', 'gauge theory', 'Overview of gauge theory and philosophical issues.'),
(5, 'Quantum Gravity - Stanford Encyclopedia of Philosophy', 'https://plato.stanford.edu/entries/quantum-gravity/', 'quantum gravity', 'Overview of quantum gravity and conceptual issues.');

INSERT INTO model_runs (
    run_id,
    article_slug,
    model_name,
    formal_object,
    interpretive_issue,
    created_at
) VALUES
(1, 'physics-and-the-philosophy-of-reality', 'two_state_probability', 'psi', 'same formal state, different interpretations', '2026-04-24'),
(2, 'physics-and-the-philosophy-of-reality', 'basis_invariance_demo', 'psi', 'representation change versus invariant norm', '2026-04-24');

SELECT
    interpretation_name,
    wavefunction_status,
    observer_independent_state,
    measurement_role
FROM interpretations
ORDER BY interpretation_id;

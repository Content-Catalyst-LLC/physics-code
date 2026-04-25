-- Condensed Matter and the Physics of Materials Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores materials, phases, band gaps, transport measurements,
-- defects, physical relations, model assumptions, source notes, and
-- simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS materials;
DROP TABLE IF EXISTS material_phases;
DROP TABLE IF EXISTS transport_measurements;
DROP TABLE IF EXISTS defect_types;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE materials (
    material_id INTEGER PRIMARY KEY,
    material_name TEXT NOT NULL,
    formula TEXT,
    band_gap_ev REAL,
    simplified_class TEXT,
    notes TEXT
);

CREATE TABLE material_phases (
    phase_id INTEGER PRIMARY KEY,
    phase_name TEXT NOT NULL,
    order_parameter TEXT,
    dominant_physics TEXT,
    notes TEXT
);

CREATE TABLE transport_measurements (
    measurement_id INTEGER PRIMARY KEY,
    material_class TEXT NOT NULL,
    temperature_k REAL NOT NULL,
    resistivity REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE defect_types (
    defect_id INTEGER PRIMARY KEY,
    defect_type TEXT NOT NULL,
    example TEXT,
    typical_effect TEXT,
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

INSERT INTO materials (
    material_id,
    material_name,
    formula,
    band_gap_ev,
    simplified_class,
    notes
) VALUES
(1, 'Copper', 'Cu', 0.0, 'metal_or_semimetal_like', 'metallic conductor example'),
(2, 'Silicon', 'Si', 1.12, 'semiconductor_like', 'canonical semiconductor example'),
(3, 'Germanium', 'Ge', 0.66, 'semiconductor_like', 'small-gap semiconductor example'),
(4, 'Gallium arsenide', 'GaAs', 1.42, 'semiconductor_like', 'compound semiconductor example'),
(5, 'Diamond', 'C', 5.47, 'insulator_like', 'wide-gap material example'),
(6, 'Sodium chloride', 'NaCl', 8.5, 'insulator_like', 'ionic insulator example'),
(7, 'Graphene', 'C', 0.0, 'metal_or_semimetal_like', 'zero-gap idealized example');

INSERT INTO material_phases (
    phase_id,
    phase_name,
    order_parameter,
    dominant_physics,
    notes
) VALUES
(1, 'metal', 'carrier density and Fermi surface', 'electronic conduction', 'available states near Fermi level'),
(2, 'semiconductor', 'band gap and carrier density', 'thermal excitation and doping', 'tunable electronic properties'),
(3, 'insulator', 'large band gap', 'suppressed conduction', 'filled and empty states separated'),
(4, 'ferromagnet', 'magnetization', 'exchange and collective spin order', 'spontaneous magnetic order'),
(5, 'superconductor', 'complex superconducting order parameter', 'macroscopic quantum coherence', 'zero resistance and Meissner effect'),
(6, 'topological insulator', 'topological invariant', 'protected boundary states', 'topological band structure');

INSERT INTO transport_measurements (
    measurement_id,
    material_class,
    temperature_k,
    resistivity,
    unit,
    notes
) VALUES
(1, 'metal', 300.0, 1.0e-8, 'ohm meter', 'illustrative metal-like reference'),
(2, 'metal', 400.0, 1.4e-8, 'ohm meter', 'illustrative metal-like high temperature'),
(3, 'semiconductor', 300.0, 0.78577, 'arbitrary', 'illustrative activated trend'),
(4, 'semiconductor', 400.0, 0.14841, 'arbitrary', 'illustrative activated trend');

INSERT INTO defect_types (
    defect_id,
    defect_type,
    example,
    typical_effect,
    notes
) VALUES
(1, 'vacancy', 'missing lattice atom', 'scattering and diffusion pathway', 'important in ionic transport and diffusion'),
(2, 'interstitial', 'extra atom in lattice', 'local strain and electronic modification', 'can alter diffusion and strength'),
(3, 'substitutional impurity', 'dopant atom', 'carrier-density control', 'central in semiconductor doping'),
(4, 'dislocation', 'line defect', 'plastic deformation and strength', 'central to mechanical properties'),
(5, 'grain boundary', 'interface between grains', 'scattering and mechanical behavior', 'important in polycrystals'),
(6, 'surface defect', 'modified surface atom', 'catalytic and optical behavior', 'surface-sensitive');

INSERT INTO physical_relations (
    relation_id,
    relation_name,
    equation_text,
    variables,
    interpretation
) VALUES
(1, 'Bloch form', 'psi_k(r)=exp(i k dot r) u_k(r)', 'psi,k,r,u', 'electronic wavefunction structure in periodic lattice'),
(2, 'free electron dispersion', 'E(k)=hbar^2 k^2/(2m)', 'E,hbar,k,m', 'simple parabolic electronic dispersion'),
(3, 'tight binding dispersion', 'E(k)=E0-2t cos(ka)', 'E,E0,t,k,a', 'simple lattice-based electronic band'),
(4, 'phonon dispersion', 'omega(k)=2 sqrt(K/M) |sin(ka/2)|', 'omega,K,M,k,a', 'simple one-dimensional lattice vibration'),
(5, 'intrinsic carrier trend', 'n_i proportional to exp[-E_g/(2 k_B T)]', 'n_i,E_g,k_B,T', 'schematic semiconductor carrier trend');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'transport_resistivity_summary', 'Uses simplified metal-like and semiconductor-like transport formulas.'),
(2, 'band_phonon_dispersion', 'Uses arbitrary units and one-dimensional toy models.'),
(3, 'band_gap_classifier', 'Uses simplified band-gap thresholds and ignores temperature, disorder, and carrier density.'),
(4, 'tight_binding_lattice_model', 'Uses a single-band one-dimensional tight-binding model.'),
(5, 'phonon_dispersion_table', 'Uses a nearest-neighbor spring-mass lattice model.');

INSERT INTO source_notes (
    source_id,
    source_title,
    source_url,
    topic,
    note
) VALUES
(1, 'OpenStax Band Theory of Solids', 'https://openstax.org/books/university-physics-volume-3/pages/9-5-band-theory-of-solids', 'band theory', 'Teaching reference for energy bands, gaps, conductors, semiconductors, and insulators.'),
(2, 'MIT OCW Modern Quantum Many-Body Physics for Condensed Matter Systems', 'https://ocw.mit.edu/courses/8-513-modern-quantum-many-body-physics-for-condensed-matter-systems-fall-2021/', 'many-body condensed matter', 'Graduate-level course on quantum effects in solids and interacting many-body systems.'),
(3, 'APS Reviews of Modern Physics Topological Band Theory', 'https://link.aps.org/doi/10.1103/RevModPhys.88.021004', 'topological materials', 'Review of topological band theory.'),
(4, 'NIST Standard Reference Materials Catalog January 2025', 'https://www.nist.gov/publications/srm-nist-standard-reference-materials-catalog-january-2025', 'materials metrology', 'NIST catalog of standard reference materials.'),
(5, 'NIST Materials Data Repository', 'https://materialsdata.nist.gov/', 'materials data', 'Repository for research data on materials systems.'),
(6, 'Materials Project', 'https://next-gen.materialsproject.org/', 'computational materials', 'Open computed materials information and analysis tools.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'condensed-matter-and-the-physics-of-materials', 'transport_resistivity_summary', 'closed_form', 'temperature from 50 K to 400 K', 'metal and semiconductor transport summaries', '2026-04-24'),
(2, 'condensed-matter-and-the-physics-of-materials', 'band_phonon_dispersion', 'grid_scan', 'k from -pi to pi', 'free-electron, tight-binding, and phonon dispersion table', '2026-04-24'),
(3, 'condensed-matter-and-the-physics-of-materials', 'band_gap_classifier', 'threshold_classifier', 'sample material band gaps', 'simplified material classification table', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

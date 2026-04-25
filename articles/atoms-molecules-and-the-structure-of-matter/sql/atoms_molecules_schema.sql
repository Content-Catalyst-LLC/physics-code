-- Atoms, Molecules, and the Structure of Matter Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, spectral lines, atomic levels, molecules, structural
-- relations, source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS spectral_lines;
DROP TABLE IF EXISTS bohr_levels;
DROP TABLE IF EXISTS molecules;
DROP TABLE IF EXISTS structural_relations;
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

CREATE TABLE spectral_lines (
    line_id INTEGER PRIMARY KEY,
    line_name TEXT NOT NULL,
    wavelength_nm REAL NOT NULL,
    series TEXT,
    initial_n INTEGER,
    final_n INTEGER,
    notes TEXT
);

CREATE TABLE bohr_levels (
    level_id INTEGER PRIMARY KEY,
    n INTEGER NOT NULL,
    energy_ev REAL NOT NULL,
    notes TEXT
);

CREATE TABLE molecules (
    molecule_id INTEGER PRIMARY KEY,
    molecule_name TEXT NOT NULL,
    formula TEXT NOT NULL,
    atoms INTEGER,
    geometry TEXT,
    polarity TEXT,
    notes TEXT
);

CREATE TABLE structural_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    role TEXT NOT NULL,
    notes TEXT
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
(1, 'Planck constant', 'h', 6.62607015e-34, 'J s', 'exact SI value'),
(2, 'speed of light', 'c', 299792458.0, 'm s^-1', 'exact SI value'),
(3, 'elementary charge', 'e', 1.602176634e-19, 'C', 'exact SI value'),
(4, 'Bohr energy scale', 'E_H', 13.6, 'eV', 'introductory hydrogen energy scale'),
(5, 'nanometer', 'nm', 1.0e-9, 'm', 'length conversion'),
(6, 'electron volt', 'eV', 1.602176634e-19, 'J', 'energy conversion');

INSERT INTO spectral_lines (
    line_id,
    line_name,
    wavelength_nm,
    series,
    initial_n,
    final_n,
    notes
) VALUES
(1, 'H_alpha', 656.3, 'Balmer', 3, 2, 'illustrative Balmer line'),
(2, 'H_beta', 486.1, 'Balmer', 4, 2, 'illustrative Balmer line'),
(3, 'H_gamma', 434.0, 'Balmer', 5, 2, 'illustrative Balmer line'),
(4, 'H_delta', 410.2, 'Balmer', 6, 2, 'illustrative Balmer line');

INSERT INTO bohr_levels (
    level_id,
    n,
    energy_ev,
    notes
) VALUES
(1, 1, -13.6, 'ground state'),
(2, 2, -3.4, 'first excited level in simple Bohr model'),
(3, 3, -1.5111111111, 'Balmer initial level for H alpha'),
(4, 4, -0.85, 'Balmer initial level for H beta'),
(5, 5, -0.544, 'Balmer initial level for H gamma'),
(6, 6, -0.3777777778, 'Balmer initial level for H delta'),
(7, 7, -0.2775510204, 'higher excited level'),
(8, 8, -0.2125, 'higher excited level');

INSERT INTO molecules (
    molecule_id,
    molecule_name,
    formula,
    atoms,
    geometry,
    polarity,
    notes
) VALUES
(1, 'hydrogen', 'H2', 2, 'linear', 'nonpolar', 'simplest neutral diatomic molecule'),
(2, 'water', 'H2O', 3, 'bent', 'polar', 'important bent molecule'),
(3, 'carbon dioxide', 'CO2', 3, 'linear', 'nonpolar', 'polar bonds cancel by symmetry'),
(4, 'ammonia', 'NH3', 4, 'trigonal pyramidal', 'polar', 'lone pair affects geometry'),
(5, 'methane', 'CH4', 5, 'tetrahedral', 'nonpolar', 'symmetric covalent molecule'),
(6, 'oxygen', 'O2', 2, 'linear', 'nonpolar', 'diatomic molecule'),
(7, 'nitrogen', 'N2', 2, 'linear', 'nonpolar', 'diatomic molecule');

INSERT INTO structural_relations (
    relation_id,
    relation_name,
    equation_text,
    role,
    notes
) VALUES
(1, 'photon energy frequency', 'E = h nu', 'links frequency to photon energy', 'spectroscopy bridge relation'),
(2, 'photon energy wavelength', 'E = h c / lambda', 'links wavelength to photon energy', 'common spectral conversion'),
(3, 'bohr energy', 'E_n = -13.6/n^2', 'hydrogen-like energy levels', 'introductory atomic model'),
(4, 'schrodinger equation', 'H psi = E psi', 'bound quantum states', 'formal quantum structure'),
(5, 'normalization', 'integral |psi|^2 d tau = 1', 'probability normalization', 'wavefunction interpretation'),
(6, 'molecular stability', 'E_bound < E_separated', 'bonding logic', 'energy-lowering condition'),
(7, 'lennard jones', 'U(r)=4 epsilon [(sigma/r)^12-(sigma/r)^6]', 'schematic diatomic potential', 'teaching potential curve');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'IUPAC Gold Book Atom', 'IUPAC', 'official terminology for atom', 'https://goldbook.iupac.org/terms/view/A00493'),
(2, 'IUPAC Gold Book Molecule', 'IUPAC', 'official terminology for molecule', 'https://goldbook.iupac.org/terms/view/M04002'),
(3, 'IUPAC Gold Book Chemical Bond', 'IUPAC', 'official terminology for chemical bond', 'https://goldbook.iupac.org/terms/view/CT07009'),
(4, 'NIST Atomic Spectra Database', 'NIST', 'critically evaluated atomic spectra data', 'https://www.nist.gov/pml/atomic-spectra-database'),
(5, 'NIST Chemistry WebBook', 'NIST', 'chemical and molecular property data', 'https://webbook.nist.gov/chemistry/'),
(6, 'NIST Meet the Constants', 'NIST', 'SI constants and exact values', 'https://www.nist.gov/si-redefinition/meet-constants'),
(7, 'MIT Introduction to Solid State Chemistry', 'MIT OCW', 'atomic models bonding spectra and materials learning resource', 'https://ocw.mit.edu/courses/3-091sc-introduction-to-solid-state-chemistry-fall-2010/');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'hydrogen_levels_diatomic_potential', 'Uses Bohr-like hydrogen levels for educational demonstration.'),
(2, 'hydrogen_levels_diatomic_potential', 'Uses a Lennard-Jones-style potential as a schematic diatomic curve, not a quantum chemistry result.'),
(3, 'hydrogen_spectral_lines', 'Uses illustrative Balmer line wavelengths for photon-energy conversion.'),
(4, 'molecular_structure_summary', 'Uses small sample molecular metadata for organization and summary.'),
(5, 'atoms_molecules_schema', 'Stores educational metadata rather than a complete evaluated atomic or molecular database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'atoms-molecules-and-the-structure-of-matter', 'hydrogen_spectral_lines', 'closed_form', 'Balmer wavelengths in nm', 'photon energies in J and eV', '2026-04-24'),
(2, 'atoms-molecules-and-the-structure-of-matter', 'hydrogen_levels_diatomic_potential', 'closed_form_and_grid_scan', 'n=1..8 and r=0.75..3.0', 'energy levels, transitions, and potential minimum', '2026-04-24'),
(3, 'atoms-molecules-and-the-structure-of-matter', 'molecular_structure_summary', 'grouped_summary', 'sample molecules by geometry and polarity', 'molecular metadata summary', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    role
FROM structural_relations
ORDER BY relation_id;

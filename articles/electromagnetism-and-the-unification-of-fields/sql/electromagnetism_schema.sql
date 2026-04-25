-- Electromagnetism and the Unification of Fields Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, field models, materials, Maxwell relations,
-- source notes, model assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS constants;
DROP TABLE IF EXISTS point_charge_measurements;
DROP TABLE IF EXISTS material_properties;
DROP TABLE IF EXISTS maxwell_relations;
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

CREATE TABLE point_charge_measurements (
    measurement_id INTEGER PRIMARY KEY,
    radius_m REAL NOT NULL,
    electric_field_measured_n_per_c REAL NOT NULL,
    notes TEXT
);

CREATE TABLE material_properties (
    material_id INTEGER PRIMARY KEY,
    material_name TEXT NOT NULL,
    relative_permittivity REAL,
    relative_permeability REAL,
    conductivity_s_per_m REAL,
    notes TEXT
);

CREATE TABLE maxwell_relations (
    relation_id INTEGER PRIMARY KEY,
    relation_name TEXT NOT NULL,
    equation_text TEXT NOT NULL,
    role TEXT NOT NULL,
    notes TEXT
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
(1, 'speed of light', 'c', 299792458.0, 'm s^-1', 'exact SI value'),
(2, 'elementary charge', 'e', 1.602176634e-19, 'C', 'exact SI value'),
(3, 'vacuum electric permittivity', 'epsilon_0', 8.8541878188e-12, 'F m^-1', '2022 CODATA value'),
(4, 'vacuum magnetic permeability', 'mu_0', 1.25663706127e-6, 'N A^-2', '2022 CODATA value'),
(5, 'Coulomb constant', 'k_e', 8.9875517862e9, 'N m^2 C^-2', 'derived from 1/(4 pi epsilon_0)');

INSERT INTO point_charge_measurements (
    measurement_id,
    radius_m,
    electric_field_measured_n_per_c,
    notes
) VALUES
(1, 0.05, 3650, 'illustrative lab-style measurement'),
(2, 0.10, 920, 'illustrative lab-style measurement'),
(3, 0.20, 235, 'illustrative lab-style measurement'),
(4, 0.40, 59, 'illustrative lab-style measurement'),
(5, 0.80, 14, 'illustrative lab-style measurement');

INSERT INTO material_properties (
    material_id,
    material_name,
    relative_permittivity,
    relative_permeability,
    conductivity_s_per_m,
    notes
) VALUES
(1, 'vacuum', 1.0, 1.0, 0.0, 'reference medium'),
(2, 'air', 1.0006, 1.00000037, 3e-15, 'approximate dry air values'),
(3, 'copper', 1.0, 0.999994, 5.96e7, 'excellent conductor approximation'),
(4, 'silicon', 11.7, 0.999996, 1e-3, 'strongly depends on doping'),
(5, 'water', 78.4, 0.999992, 5.5e-6, 'approximate pure water at room temperature'),
(6, 'glass', 5.0, 1.0, 1e-11, 'representative dielectric approximation'),
(7, 'ferrite', 10.0, 2000.0, 1e-3, 'illustrative magnetic material');

INSERT INTO maxwell_relations (
    relation_id,
    relation_name,
    equation_text,
    role,
    notes
) VALUES
(1, 'Gauss electric', 'div E = rho / epsilon_0', 'electric charge as source of electric field', 'differential form'),
(2, 'Gauss magnetic', 'div B = 0', 'no magnetic monopoles in classical Maxwell theory', 'differential form'),
(3, 'Faraday', 'curl E = - partial B / partial t', 'changing magnetic field generates circulating electric field', 'differential form'),
(4, 'Ampere Maxwell', 'curl B = mu_0 J + mu_0 epsilon_0 partial E / partial t', 'current and changing electric field generate magnetic field', 'differential form'),
(5, 'Lorentz force', 'F = q(E + v x B)', 'force on moving charge', 'dynamical law'),
(6, 'Poynting vector', 'S = E x H', 'electromagnetic energy flux', 'field energy transport');

INSERT INTO model_metadata (
    model_id,
    model_or_concept,
    primary_use,
    key_quantity,
    limitation
) VALUES
(1, 'point-charge electrostatics', 'radial field and potential', 'E and V', 'singular source idealization'),
(2, 'wire magnetic field', 'magnetic scaling around long straight current', 'B', 'ideal infinite-wire approximation'),
(3, 'dipole superposition', 'two-charge field geometry', 'potential and field', 'numerical softening used near charges'),
(4, 'Laplace equation', 'charge-free boundary-value problems', 'V', 'requires specified boundary conditions'),
(5, 'Poisson equation', 'field from charge density', 'V and rho', 'requires source distribution'),
(6, 'Maxwell wave relation', 'electromagnetic radiation', 'c', 'source-free vacuum simplification'),
(7, 'constitutive relations', 'field behavior in media', 'epsilon mu sigma', 'linear isotropic examples only');

INSERT INTO source_notes (
    source_id,
    source_title,
    organization,
    primary_role,
    url
) VALUES
(1, 'BIPM SI Brochure', 'BIPM', 'official SI unit framework', 'https://www.bipm.org/en/si-brochure-9'),
(2, 'BIPM Ampere Mise en pratique', 'BIPM', 'ampere realization guidance', 'https://www.bipm.org/documents/20126/41489676/SI-App2-ampere.pdf'),
(3, 'NIST Fundamental Physical Constants', 'NIST', 'current constants listing', 'https://physics.nist.gov/cuu/pdf/all.pdf'),
(4, 'NIST SP 330', 'NIST', 'International System of Units reference', 'https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.330-2019.pdf'),
(5, 'MIT Physics II Electricity and Magnetism', 'MIT OpenCourseWare', 'electricity magnetism and Maxwell equations', 'https://ocw.mit.edu/courses/8-02-physics-ii-electricity-and-magnetism-spring-2019/'),
(6, 'MIT Electromagnetism II', 'MIT OpenCourseWare', 'advanced electromagnetism', 'https://ocw.mit.edu/courses/8-07-electromagnetism-ii-fall-2012/'),
(7, 'Maxwell 1865', 'Royal Society', 'electromagnetic field theory', 'https://royalsocietypublishing.org/doi/10.1098/rstl.1865.0008'),
(8, 'Faraday 1832', 'Internet Archive', 'experimental researches in electricity', 'https://archive.org/details/philtrans01461252');

INSERT INTO model_assumptions (
    assumption_id,
    model_name,
    assumption_text
) VALUES
(1, 'potential_field_superposition', 'Uses point-charge potentials with numerical softening near singular charge locations.'),
(2, 'laplace_boundary_solver', 'Uses a simple Jacobi relaxation method for an educational boundary-value problem.'),
(3, 'maxwell_wave_relations', 'Uses vacuum constants to check the electromagnetic wave-speed relation.'),
(4, 'point_charge_wire_fields', 'Uses idealized point-charge and long-straight-wire formulas.'),
(5, 'electromagnetism_schema', 'Stores educational metadata rather than a calibrated electromagnetic measurement database.');

INSERT INTO simulation_runs (
    run_id,
    article_slug,
    model_name,
    numerical_method,
    parameter_summary,
    output_summary,
    created_at
) VALUES
(1, 'electromagnetism-and-the-unification-of-fields', 'potential_field_superposition', 'grid_gradient', '2D grid, single charge and dipole-style pair', 'potential and field summaries', '2026-04-24'),
(2, 'electromagnetism-and-the-unification-of-fields', 'laplace_boundary_solver', 'finite_difference_relaxation', '80 by 80 grid and fixed boundary values', 'potential and field summary', '2026-04-24'),
(3, 'electromagnetism-and-the-unification-of-fields', 'maxwell_wave_relations', 'closed_form_table', 'selected electromagnetic frequencies', 'wavelength and wave-speed relation table', '2026-04-24'),
(4, 'electromagnetism-and-the-unification-of-fields', 'point_charge_wire_fields', 'closed_form_table', 'radii from 0.02 m to 1.00 m', 'field potential and wire magnetic field tables', '2026-04-24');

SELECT
    relation_name,
    equation_text,
    role
FROM maxwell_relations
ORDER BY relation_id;

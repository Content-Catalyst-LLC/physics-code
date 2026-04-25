-- Biophysics and the Physical Principles of Life Data Model
--
-- This SQL workflow is kept in the GitHub repository, not in the article body.
--
-- It stores constants, diffusion cases, binding cases, ion gradients,
-- enzyme kinetic cases, motor stepping cases, biomechanics cases,
-- physical relations, model metadata, source notes, assumptions, and simulation runs.
--
-- SQLite-compatible.

DROP TABLE IF EXISTS biophysical_constants;
DROP TABLE IF EXISTS diffusion_cases;
DROP TABLE IF EXISTS binding_cases;
DROP TABLE IF EXISTS ion_gradient_cases;
DROP TABLE IF EXISTS enzyme_kinetic_cases;
DROP TABLE IF EXISTS motor_step_cases;
DROP TABLE IF EXISTS biomechanics_cases;
DROP TABLE IF EXISTS physical_relations;
DROP TABLE IF EXISTS model_metadata;
DROP TABLE IF EXISTS source_notes;
DROP TABLE IF EXISTS model_assumptions;
DROP TABLE IF EXISTS simulation_runs;

CREATE TABLE biophysical_constants (
    constant_name TEXT PRIMARY KEY,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE diffusion_cases (
    case_id TEXT PRIMARY KEY,
    length_um REAL NOT NULL,
    diffusion_coefficient_um2_s REAL NOT NULL,
    dimension INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE binding_cases (
    case_id TEXT PRIMARY KEY,
    kd_m REAL NOT NULL,
    ligand_min_m REAL NOT NULL,
    ligand_max_m REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE ion_gradient_cases (
    case_id TEXT PRIMARY KEY,
    ion TEXT NOT NULL,
    z INTEGER NOT NULL,
    c_out_mM REAL NOT NULL,
    c_in_mM REAL NOT NULL,
    temperature_k REAL NOT NULL,
    notes TEXT
);

CREATE TABLE enzyme_kinetic_cases (
    case_id TEXT PRIMARY KEY,
    vmax_uM_s REAL NOT NULL,
    km_uM REAL NOT NULL,
    substrate_min_uM REAL NOT NULL,
    substrate_max_uM REAL NOT NULL,
    n_points INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE motor_step_cases (
    case_id TEXT PRIMARY KEY,
    step_size_nm REAL NOT NULL,
    forward_rate_s REAL NOT NULL,
    backward_rate_s REAL NOT NULL,
    n_steps INTEGER NOT NULL,
    time_step_s REAL NOT NULL,
    notes TEXT
);

CREATE TABLE biomechanics_cases (
    case_id TEXT PRIMARY KEY,
    force_n REAL NOT NULL,
    area_m2 REAL NOT NULL,
    delta_length_m REAL NOT NULL,
    original_length_m REAL NOT NULL,
    stiffness_n_m REAL NOT NULL,
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

INSERT INTO biophysical_constants VALUES
('boltzmann_constant', 1.380649e-23, 'J K^-1', 'exact SI value'),
('gas_constant', 8.314462618, 'J mol^-1 K^-1', 'molar gas constant'),
('avogadro_constant', 6.02214076e23, 'mol^-1', 'exact SI value'),
('faraday_constant', 96485.33212, 'C mol^-1', 'electric charge per mole of monovalent ions'),
('elementary_charge', 1.602176634e-19, 'C', 'exact SI value'),
('room_temperature', 298.15, 'K', 'room temperature reference'),
('body_temperature', 310.15, 'K', 'human body temperature approximate'),
('water_viscosity_25c', 0.00089, 'Pa s', 'approximate dynamic viscosity of water near 25 C');

INSERT INTO diffusion_cases VALUES
('small_molecule_cell', 10, 100, 3, 'small molecule across a cell-scale distance'),
('protein_cytoplasm', 10, 10, 3, 'protein-like diffusion across a cell'),
('membrane_protein', 1, 0.1, 2, 'slow lateral membrane diffusion'),
('organelle_like_particle', 10, 0.01, 3, 'large intracellular object'),
('tissue_scale', 1000, 10, 3, 'diffusion across one millimeter'),
('subcellular_fast', 1, 100, 3, 'small molecule across subcellular distance');

INSERT INTO binding_cases VALUES
('tight_binding', 1.0e-9, 1.0e-12, 1.0e-6, 121, 'nanomolar affinity'),
('moderate_binding', 1.0e-6, 1.0e-9, 1.0e-3, 121, 'micromolar affinity'),
('weak_binding', 1.0e-3, 1.0e-6, 1.0, 121, 'millimolar affinity');

INSERT INTO ion_gradient_cases VALUES
('potassium_neuron', 'K', 1, 5, 140, 310.15, 'typical potassium gradient direction'),
('sodium_neuron', 'Na', 1, 145, 12, 310.15, 'typical sodium gradient direction'),
('chloride_neuron', 'Cl', -1, 110, 10, 310.15, 'chloride gradient example'),
('calcium_cell', 'Ca', 2, 1.2, 0.0001, 310.15, 'strong calcium gradient example'),
('proton_mitochondrial', 'H', 1, 0.0001, 0.001, 310.15, 'illustrative proton gradient');

INSERT INTO enzyme_kinetic_cases VALUES
('high_affinity_enzyme', 100, 5, 0, 100, 101, 'low KM case'),
('moderate_affinity_enzyme', 100, 50, 0, 500, 101, 'moderate KM case'),
('low_affinity_enzyme', 100, 500, 0, 5000, 101, 'high KM case');

INSERT INTO motor_step_cases VALUES
('kinesin_like', 8, 100, 5, 10000, 0.001, 'illustrative kinesin-like stepping'),
('slow_motor', 8, 20, 2, 10000, 0.001, 'slower motor case'),
('high_load_motor', 8, 40, 20, 10000, 0.001, 'increased backward stepping under load');

INSERT INTO biomechanics_cases VALUES
('single_molecule', 1.0e-12, 1.0e-18, 1.0e-9, 1.0e-6, 1.0e-3, 'piconewton molecular force scale'),
('cell_adhesion', 1.0e-9, 1.0e-12, 1.0e-6, 1.0e-5, 1.0e-3, 'nanonewton cellular force scale'),
('soft_tissue', 1.0, 1.0e-4, 1.0e-3, 1.0e-2, 1000, 'macroscopic soft-tissue example');

INSERT INTO physical_relations VALUES
(1, 'thermal energy', 'kB T', 'kB,T', 'molecular thermal energy scale'),
(2, 'Boltzmann probability', 'P_i = exp(-E_i/(kB T))/Z', 'P_i,E_i,kB,T,Z', 'state probability in thermal equilibrium'),
(3, 'diffusion equation', 'partial c/partial t = D nabla^2 c', 'c,t,D', 'concentration spreading under diffusion'),
(4, 'mean squared displacement', '<r^2> = 2 d D t', 'r,d,D,t', 'diffusive displacement scaling'),
(5, 'Stokes-Einstein relation', 'D = kB T/(6 pi eta r)', 'D,kB,T,eta,r', 'diffusion coefficient for sphere in viscous fluid'),
(6, 'binding occupancy', 'theta = [L]/(KD + [L])', 'theta,L,KD', 'single-site equilibrium binding fraction'),
(7, 'Nernst equation', 'E = (RT/zF) ln(c_out/c_in)', 'E,R,T,z,F,c_out,c_in', 'single-ion equilibrium potential'),
(8, 'Michaelis-Menten kinetics', 'v = Vmax [S]/(KM + [S])', 'v,Vmax,S,KM', 'enzyme rate saturation relation'),
(9, 'Hooke law', 'F = kx', 'F,k,x', 'linear elastic force relation'),
(10, 'Poiseuille flow', 'Q = pi r^4 DeltaP/(8 eta L)', 'Q,r,DeltaP,eta,L', 'laminar tube flow relation'),
(11, 'Reynolds number', 'Re = rho v L/eta', 'Re,rho,v,L,eta', 'ratio of inertial to viscous effects'),
(12, 'membrane capacitance', 'C = epsilon A/d', 'C,epsilon,A,d', 'ideal membrane capacitor approximation');

INSERT INTO model_metadata VALUES
(1, 'diffusion_timescale', 'transport across biological distances', 't', 'scaling approximation without boundaries'),
(2, 'brownian_motion', 'stochastic molecular motion', 'MSD', 'ideal homogeneous diffusion model'),
(3, 'binding_occupancy', 'ligand receptor binding', 'theta', 'single-site equilibrium model'),
(4, 'nernst_potential', 'single-ion equilibrium voltage', 'E', 'ignores multiple ions and active transport'),
(5, 'michaelis_menten', 'enzyme rate saturation', 'v', 'standard assumptions and steady-state approximation'),
(6, 'motor_stepping', 'stochastic motor motion', 'position', 'toy model without force-velocity coupling'),
(7, 'biomechanics_summary', 'stress strain stiffness', 'sigma and epsilon', 'simple linearized mechanics'),
(8, 'membrane_capacitance', 'charge storage', 'C', 'ideal parallel-plate approximation');

INSERT INTO source_notes VALUES
(1, 'NIGMS Biophysics', 'National Institute of General Medical Sciences', 'biophysics program overview', 'https://www.nigms.nih.gov/about/overview/BBCB/Biophysics/Pages/biophysics'),
(2, 'Biophysical Society What Is Biophysics', 'Biophysical Society', 'field definition and public overview', 'https://www.biophysics.org/what-is-biophysics'),
(3, 'MIT Topics in Biophysics and Physical Biology', 'MIT OpenCourseWare', 'research literature and physical biology course', 'https://ocw.mit.edu/courses/20-416j-topics-in-biophysics-and-physical-biology-fall-2014/'),
(4, 'MIT Statistical Physics in Biology', 'MIT OpenCourseWare', 'statistical physics applied to biology', 'https://ocw.mit.edu/courses/8-592j-statistical-physics-in-biology-spring-2011/'),
(5, 'MIT Molecular Cellular and Tissue Biomechanics', 'MIT OpenCourseWare', 'biomechanics across molecular cellular and tissue scales', 'https://ocw.mit.edu/courses/20-310j-molecular-cellular-and-tissue-biomechanics-spring-2015/'),
(6, 'University of Michigan What Is Biophysics', 'University of Michigan', 'biophysics definition and scope', 'https://lsa.umich.edu/biophysics/about-us/what-is-biophysics.html'),
(7, 'Phillips Physical Biology of the Cell', 'Routledge', 'physical biology textbook', 'https://www.routledge.com/Physical-Biology-of-the-Cell/Phillips-Kondev-Theriot-Garcia/p/book/9780815344506'),
(8, 'Nelson Biological Physics', 'Macmillan Learning', 'biological physics textbook', 'https://www.macmillanlearning.com/college/us/product/Biological-Physics/p/1319038946');

INSERT INTO model_assumptions VALUES
(1, 'brownian_motion_msd', 'Uses ideal two-dimensional Brownian motion in a homogeneous medium with no boundaries or drift.'),
(2, 'diffusion_timescale_grid', 'Uses simple diffusion scaling and ignores geometry, reactions, binding, and crowding.'),
(3, 'nernst_potential', 'Computes single-ion equilibrium potentials and does not model multi-ion membrane voltage.'),
(4, 'binding_occupancy', 'Uses a one-site equilibrium binding model.'),
(5, 'michaelis_menten_kinetics', 'Uses standard Michaelis-Menten kinetics without product inhibition or allostery.'),
(6, 'molecular_motor_stepping', 'Uses a toy stochastic stepping model without explicit load or chemical-state cycle.'),
(7, 'biophysics_schema', 'Stores educational metadata rather than a production biological simulation database.');

INSERT INTO simulation_runs VALUES
(1, 'biophysics-and-the-physical-principles-of-life', 'brownian_motion_msd', 'stochastic_simulation', 'D=1 um2/s dt=0.01 s 500 trajectories', 'Brownian trajectories and MSD summary', '2026-04-25'),
(2, 'biophysics-and-the-physical-principles-of-life', 'diffusion_timescale_grid', 'closed_form_scaling', 'sample biological length and diffusion cases', 'diffusion time scale table', '2026-04-25'),
(3, 'biophysics-and-the-physical-principles-of-life', 'nernst_potential', 'closed_form_equilibrium_potential', 'sample ion gradients', 'Nernst potential table', '2026-04-25'),
(4, 'biophysics-and-the-physical-principles-of-life', 'binding_occupancy', 'equilibrium_binding_sweep', 'sample KD and ligand concentration cases', 'binding occupancy curves and summary', '2026-04-25'),
(5, 'biophysics-and-the-physical-principles-of-life', 'michaelis_menten_kinetics', 'enzyme_rate_sweep', 'sample Vmax KM and substrate cases', 'reaction rate curves', '2026-04-25'),
(6, 'biophysics-and-the-physical-principles-of-life', 'molecular_motor_stepping', 'stochastic_stepping_simulation', 'sample motor rates and step sizes', 'motor position trajectories and summary', '2026-04-25');

SELECT
    relation_name,
    equation_text,
    interpretation
FROM physical_relations
ORDER BY relation_id;

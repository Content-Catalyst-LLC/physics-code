// Topology CLI
//
// Labels SSH and two-band Chern-model scaffold regimes.

fn ssh_phase(t1: f64, t2: f64) -> &'static str {
    if t2.abs() > t1.abs() {
        "topological_scaffold"
    } else if (t2.abs() - t1.abs()).abs() < 1e-12 {
        "transition_scaffold"
    } else {
        "trivial_scaffold"
    }
}

fn chern_mass_region(mass: f64) -> &'static str {
    let eps = 1e-12;

    if (mass + 2.0).abs() < eps || mass.abs() < eps || (mass - 2.0).abs() < eps {
        "gap_closing_transition"
    } else if mass < -2.0 {
        "trivial_large_negative_mass"
    } else if mass > 2.0 {
        "trivial_large_positive_mass"
    } else if mass > -2.0 && mass < 0.0 {
        "nontrivial_chern_region"
    } else {
        "opposite_nontrivial_chern_region"
    }
}

fn main() {
    println!("model,param1,param2,label");

    let ssh_cases = [(1.0, 0.5), (1.0, 1.5), (1.0, 1.0), (0.3, 1.5), (1.5, 0.3)];

    for (t1, t2) in ssh_cases {
        println!("SSH,{:.6},{:.6},{}", t1, t2, ssh_phase(t1, t2));
    }

    let masses = [-3.0, -2.0, -1.0, -0.1, 0.0, 0.1, 1.0, 2.0, 3.0];

    for mass in masses {
        println!("chern_model,{:.6},0,{}", mass, chern_mass_region(mass));
    }
}

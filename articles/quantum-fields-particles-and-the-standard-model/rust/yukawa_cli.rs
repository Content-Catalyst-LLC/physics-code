// Yukawa Coupling CLI
//
// This Rust utility computes:
//
//     y_f = sqrt(2) * m_f / v
//
// for a small set of illustrative fermion masses.

fn yukawa_coupling(mass_gev: f64, higgs_vev_gev: f64) -> f64 {
    2.0_f64.sqrt() * mass_gev / higgs_vev_gev
}

fn main() {
    let higgs_vev_gev = 246.0_f64;

    let particles = [
        ("electron", 0.000511_f64),
        ("muon", 0.10566_f64),
        ("tau", 1.77686_f64),
        ("charm", 1.27_f64),
        ("bottom", 4.18_f64),
        ("top", 172.61_f64),
    ];

    println!("particle,mass_gev,yukawa_coupling");

    for (particle, mass_gev) in particles {
        println!(
            "{},{:.8},{:.8e}",
            particle,
            mass_gev,
            yukawa_coupling(mass_gev, higgs_vev_gev)
        );
    }
}

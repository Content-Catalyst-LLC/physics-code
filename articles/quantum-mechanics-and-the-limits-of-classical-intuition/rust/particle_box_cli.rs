// Particle-in-a-Box CLI
//
// This Rust utility computes:
//
//     E_n = n^2*pi^2*hbar^2 / (2*m*L^2)
//
// for an electron in a one-dimensional infinite square well.

fn particle_box_energy_j(n: u32, hbar_j_s: f64, mass_kg: f64, box_length_m: f64) -> f64 {
    let pi = std::f64::consts::PI;
    (n as f64).powi(2) * pi.powi(2) * hbar_j_s.powi(2)
        / (2.0 * mass_kg * box_length_m.powi(2))
}

fn main() {
    let hbar_j_s = 1.054_571_817e-34_f64;
    let electron_mass_kg = 9.109_383_7015e-31_f64;
    let joule_per_ev = 1.602_176_634e-19_f64;
    let box_length_m = 1.0e-9_f64;

    println!("n,energy_j,energy_ev");

    for n in 1..=10 {
        let energy_j = particle_box_energy_j(n, hbar_j_s, electron_mass_kg, box_length_m);
        println!("{},{:.12e},{:.8}", n, energy_j, energy_j / joule_per_ev);
    }
}

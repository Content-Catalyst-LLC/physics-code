// QFT CLI
//
// This Rust utility computes harmonic oscillator energies,
// Bose occupation values, and scalar-field dispersion in natural units.

fn oscillator_energy(hbar: f64, omega: f64, n: f64) -> f64 {
    hbar * omega * (n + 0.5)
}

fn bose_occupation(beta: f64, hbar: f64, omega: f64) -> f64 {
    1.0 / ((beta * hbar * omega).exp() - 1.0)
}

fn scalar_omega(k: f64, mass: f64) -> f64 {
    (k * k + mass * mass).sqrt()
}

fn main() {
    println!("quantity,value");
    println!("oscillator_E0,{:.12}", oscillator_energy(1.0, 2.0, 0.0));
    println!("oscillator_E1,{:.12}", oscillator_energy(1.0, 2.0, 1.0));
    println!("bose_occupation_beta1_omega2,{:.12}", bose_occupation(1.0, 1.0, 2.0));
    println!("scalar_omega_k3_m1,{:.12}", scalar_omega(3.0, 1.0));
}

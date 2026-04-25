// Mathematical Methods CLI
//
// This Rust utility computes harmonic oscillator frequency and kinetic energy.

fn main() {
    let mass_kg = 1.0_f64;
    let spring_constant_n_per_m = 25.0_f64;
    let omega0 = (spring_constant_n_per_m / mass_kg).sqrt();
    let frequency_hz = omega0 / (2.0 * std::f64::consts::PI);

    println!("quantity,value,unit");
    println!("omega0,{:.8},rad_per_s", omega0);
    println!("frequency,{:.8},Hz", frequency_hz);

    println!("\nvelocity_m_per_s,kinetic_energy_j");

    for velocity in [0.5_f64, 1.0, 1.5, 2.0, 3.0] {
        let kinetic_energy = 0.5 * mass_kg * velocity.powi(2);
        println!("{:.8},{:.8}", velocity, kinetic_energy);
    }
}

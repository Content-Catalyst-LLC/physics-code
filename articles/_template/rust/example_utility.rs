fn kinetic_energy(mass_kg: f64, velocity_m_per_s: f64) -> f64 {
    0.5 * mass_kg * velocity_m_per_s.powi(2)
}

fn main() {
    let mass_kg = 2.0;
    let velocity_m_per_s = 4.0;

    println!("KE = {:.3} J", kinetic_energy(mass_kg, velocity_m_per_s));
}

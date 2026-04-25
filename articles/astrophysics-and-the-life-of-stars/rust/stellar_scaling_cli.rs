// Stellar Scaling CLI
//
// This Rust utility computes simple main-sequence scaling values:
//
//     L = M^3.5
//     t = M / L
//
// where M, L, and t are in solar-normalized units.

fn luminosity_from_mass(mass_solar: f64) -> f64 {
    mass_solar.powf(3.5)
}

fn lifetime_relative(mass_solar: f64, luminosity_solar: f64) -> f64 {
    mass_solar / luminosity_solar
}

fn main() {
    let masses_solar = [0.2_f64, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0, 40.0];

    println!("mass_solar,luminosity_solar_scaling,lifetime_relative_to_sun");

    for mass_solar in masses_solar {
        let luminosity = luminosity_from_mass(mass_solar);
        let lifetime = lifetime_relative(mass_solar, luminosity);

        println!("{:.6},{:.6e},{:.6e}", mass_solar, luminosity, lifetime);
    }
}

// Black Hole Radius CLI
//
// This Rust utility computes the Schwarzschild radius:
//
//     r_s = 2GM / c^2
//
// for a set of black-hole masses in solar masses.

const G_SI: f64 = 6.67430e-11;
const C_M_PER_S: f64 = 299_792_458.0;
const M_SUN_KG: f64 = 1.98847e30;

fn schwarzschild_radius_km(mass_solar: f64) -> f64 {
    let mass_kg = mass_solar * M_SUN_KG;
    let radius_m = 2.0 * G_SI * mass_kg / (C_M_PER_S * C_M_PER_S);
    radius_m / 1000.0
}

fn main() {
    let masses_solar = [10.0_f64, 1.0e5, 4.0e6, 1.0e9, 6.5e9];

    println!("black_hole_mass_solar,schwarzschild_radius_km");

    for mass_solar in masses_solar {
        println!("{:.6e},{:.6e}", mass_solar, schwarzschild_radius_km(mass_solar));
    }
}

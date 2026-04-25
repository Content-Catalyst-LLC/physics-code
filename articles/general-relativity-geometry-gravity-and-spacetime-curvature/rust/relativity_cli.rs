// Relativity CLI
//
// This Rust utility computes Schwarzschild radius, compactness,
// and gravitational redshift.

fn schwarzschild_radius(mass_kg: f64) -> f64 {
    let g = 6.67430e-11_f64;
    let c = 299792458.0_f64;
    2.0 * g * mass_kg / (c * c)
}

fn compactness(mass_kg: f64, radius_m: f64) -> f64 {
    schwarzschild_radius(mass_kg) / radius_m
}

fn redshift_z(mass_kg: f64, radius_m: f64) -> f64 {
    let rs = schwarzschild_radius(mass_kg);

    if radius_m <= rs {
        return f64::NAN;
    }

    1.0 / (1.0 - rs / radius_m).sqrt() - 1.0
}

fn main() {
    let solar_mass = 1.98847e30_f64;
    let solar_radius = 6.957e8_f64;
    let earth_mass = 5.9722e24_f64;
    let earth_radius = 6.371e6_f64;

    println!("object,schwarzschild_radius_m,compactness,redshift_z");
    println!(
        "earth,{:.12e},{:.12e},{:.12e}",
        schwarzschild_radius(earth_mass),
        compactness(earth_mass, earth_radius),
        redshift_z(earth_mass, earth_radius)
    );
    println!(
        "sun,{:.12e},{:.12e},{:.12e}",
        schwarzschild_radius(solar_mass),
        compactness(solar_mass, solar_radius),
        redshift_z(solar_mass, solar_radius)
    );
}

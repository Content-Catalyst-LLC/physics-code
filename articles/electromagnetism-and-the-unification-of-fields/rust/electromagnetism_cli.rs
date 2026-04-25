// Electromagnetism CLI
//
// This Rust utility computes:
//
//     E(r) = q / (4*pi*epsilon0*r^2)
//     V(r) = q / (4*pi*epsilon0*r)
//     B(r) = mu0*I / (2*pi*r)
//
// for selected radii.

fn main() {
    let pi = std::f64::consts::PI;
    let epsilon0 = 8.854_187_8188e-12_f64;
    let mu0 = 1.256_637_06127e-6_f64;
    let charge_c = 1.0e-9_f64;
    let current_a = 2.0_f64;

    let radii_m = [0.02_f64, 0.05, 0.10, 0.20, 0.40, 0.80, 1.00];

    println!("radius_m,electric_field_n_per_c,electric_potential_v,wire_magnetic_field_t");

    for radius_m in radii_m {
        let electric_field = charge_c / (4.0 * pi * epsilon0 * radius_m.powi(2));
        let electric_potential = charge_c / (4.0 * pi * epsilon0 * radius_m);
        let magnetic_field = mu0 * current_a / (2.0 * pi * radius_m);

        println!(
            "{:.6},{:.8e},{:.8e},{:.8e}",
            radius_m,
            electric_field,
            electric_potential,
            magnetic_field
        );
    }
}

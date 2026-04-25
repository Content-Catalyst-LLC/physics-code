// Energy and Work CLI
//
// This Rust utility computes spring potential energy and predicted launch speed:
//
//     U = 1/2 k x^2
//     v = x sqrt(k/m)

fn main() {
    let mass_kg = 0.50_f64;
    let spring_constant_n_per_m = 20.0_f64;

    let compressions_m = [0.02_f64, 0.04, 0.06, 0.08, 0.10, 0.12];

    println!("mass_kg,spring_constant_n_per_m,compression_m,spring_energy_j,predicted_speed_m_per_s");

    for compression_m in compressions_m {
        let spring_energy_j = 0.5 * spring_constant_n_per_m * compression_m.powi(2);
        let predicted_speed_m_per_s =
            compression_m * (spring_constant_n_per_m / mass_kg).sqrt();

        println!(
            "{:.6},{:.6},{:.6},{:.8},{:.8}",
            mass_kg,
            spring_constant_n_per_m,
            compression_m,
            spring_energy_j,
            predicted_speed_m_per_s
        );
    }
}

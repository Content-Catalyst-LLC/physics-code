// Two-State Statistical Physics CLI
//
// This Rust utility computes:
//
//     Z = 1 + exp(-beta epsilon)
//     p_exc = exp(-beta epsilon) / Z
//     <E> = epsilon p_exc
//     F = -k_B T ln Z
//
// for selected temperatures.

fn main() {
    let k_b = 1.380_649e-23_f64;
    let epsilon_j = 2.0e-21_f64;

    let temperatures_k = [100.0_f64, 150.0, 300.0, 600.0, 1000.0];

    println!("temperature_k,beta_per_joule,partition_function,p_excited,mean_energy_j,free_energy_j");

    for temperature_k in temperatures_k {
        let beta = 1.0 / (k_b * temperature_k);
        let boltzmann_factor = (-beta * epsilon_j).exp();
        let z = 1.0 + boltzmann_factor;
        let p_excited = boltzmann_factor / z;
        let mean_energy_j = epsilon_j * p_excited;
        let free_energy_j = -k_b * temperature_k * z.ln();

        println!(
            "{:.3},{:.8e},{:.8},{:.8},{:.8e},{:.8e}",
            temperature_k,
            beta,
            z,
            p_excited,
            mean_energy_j,
            free_energy_j
        );
    }
}

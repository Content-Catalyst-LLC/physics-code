// Plasma CLI
//
// This Rust utility computes Debye length, plasma frequency,
// cyclotron frequency, and Larmor radius.

fn debye_length(ne: f64, te_ev: f64) -> f64 {
    let epsilon_0 = 8.8541878128e-12_f64;
    let e = 1.602176634e-19_f64;
    let te_j = te_ev * e;
    (epsilon_0 * te_j / (ne * e * e)).sqrt()
}

fn plasma_frequency_hz(ne: f64) -> f64 {
    let epsilon_0 = 8.8541878128e-12_f64;
    let e = 1.602176634e-19_f64;
    let me = 9.1093837015e-31_f64;
    let omega = (ne * e * e / (epsilon_0 * me)).sqrt();
    omega / (2.0 * std::f64::consts::PI)
}

fn cyclotron_frequency_hz(b: f64) -> f64 {
    let e = 1.602176634e-19_f64;
    let me = 9.1093837015e-31_f64;
    let omega = e * b / me;
    omega / (2.0 * std::f64::consts::PI)
}

fn larmor_radius(b: f64, vperp: f64) -> f64 {
    let e = 1.602176634e-19_f64;
    let me = 9.1093837015e-31_f64;
    me * vperp / (e * b)
}

fn main() {
    println!("density_m3,temperature_ev,B_t,debye_length_m,plasma_frequency_hz,cyclotron_frequency_hz,larmor_radius_m");

    for ne in [1.0e14_f64, 1.0e16, 1.0e18, 1.0e20] {
        for te in [1.0_f64, 10.0, 100.0] {
            for b in [0.01_f64, 0.1, 1.0] {
                println!(
                    "{:.6e},{:.4},{:.4},{:.8e},{:.8e},{:.8e},{:.8e}",
                    ne,
                    te,
                    b,
                    debye_length(ne, te),
                    plasma_frequency_hz(ne),
                    cyclotron_frequency_hz(b),
                    larmor_radius(b, 1.0e5)
                );
            }
        }
    }
}

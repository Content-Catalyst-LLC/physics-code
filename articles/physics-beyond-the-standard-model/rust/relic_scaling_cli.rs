// Relic Scaling CLI
//
// This Rust utility computes a schematic inverse relic-density-style scaling:
//
//     omega = normalization / sigma_v
//
// This is an educational toy model, not a full BSM calculation.

fn relic_density(sigma_v: f64, normalization: f64) -> f64 {
    if sigma_v <= 0.0 {
        panic!("sigma_v must be positive");
    }

    normalization / sigma_v
}

fn main() {
    let normalization = 1.0e-26_f64;
    let sigma_values = [1e-28_f64, 3e-28, 1e-27, 3e-27, 1e-26, 3e-26, 1e-25];

    println!("sigma_v_schematic,omega_chi_h2_schematic");

    for sigma_v in sigma_values {
        let omega = relic_density(sigma_v, normalization);
        println!("{:.6e},{:.6e}", sigma_v, omega);
    }
}

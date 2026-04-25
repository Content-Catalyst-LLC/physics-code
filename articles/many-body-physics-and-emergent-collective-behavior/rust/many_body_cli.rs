// Many-Body Physics CLI
//
// This Rust utility computes Hilbert-space dimensions and occupation values.

fn integer_power(base: u128, exponent: u32) -> u128 {
    let mut result = 1_u128;

    for _ in 0..exponent {
        result *= base;
    }

    result
}

fn fermi_occupation(energy: f64, mu: f64, temperature: f64, k_b: f64) -> f64 {
    1.0 / (((energy - mu) / (k_b * temperature)).exp() + 1.0)
}

fn bose_occupation(energy: f64, mu: f64, temperature: f64, k_b: f64) -> f64 {
    if energy <= mu {
        return f64::NAN;
    }

    1.0 / (((energy - mu) / (k_b * temperature)).exp() - 1.0)
}

fn main() {
    let k_b_ev_k = 8.617333262e-5_f64;

    println!("quantity,value");
    println!("spin_half_dimension_20,{}", integer_power(2, 20));
    println!("spin_half_dimension_30,{}", integer_power(2, 30));
    println!("spin_half_dimension_40,{}", integer_power(2, 40));
    println!(
        "fermi_E0_mu0_T300,{:.12}",
        fermi_occupation(0.0, 0.0, 300.0, k_b_ev_k)
    );
    println!(
        "bose_E0p01_mu0_T300,{:.12}",
        bose_occupation(0.01, 0.0, 300.0, k_b_ev_k)
    );
}

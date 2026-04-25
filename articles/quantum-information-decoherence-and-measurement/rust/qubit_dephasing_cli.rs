// Qubit Dephasing CLI
//
// This Rust utility computes dephasing diagnostics for a |+> state.

fn entropy_bits(lambda_plus: f64, lambda_minus: f64) -> f64 {
    let mut entropy = 0.0;

    if lambda_plus > 0.0 {
        entropy -= lambda_plus * lambda_plus.log2();
    }

    if lambda_minus > 0.0 {
        entropy -= lambda_minus * lambda_minus.log2();
    }

    entropy
}

fn main() {
    let t2 = 5.0e-6_f64;

    println!("time_microseconds,coherence_abs,purity,entropy_bits");

    for i in 0..=25 {
        let t = (i as f64) * 1.0e-6;
        let coherence = 0.5 * (-t / t2).exp();

        let lambda_plus = 0.5 + coherence;
        let lambda_minus = 0.5 - coherence;

        let purity = lambda_plus.powi(2) + lambda_minus.powi(2);
        let entropy = entropy_bits(lambda_plus, lambda_minus);

        println!(
            "{:.8},{:.10},{:.10},{:.10}",
            t * 1.0e6,
            coherence,
            purity,
            entropy
        );
    }
}

// Born Rule CLI
//
// This Rust utility computes Born-rule probabilities for a simple
// real-valued two-state vector.

fn normalize_state(mut state: Vec<f64>) -> Vec<f64> {
    let norm_squared: f64 = state.iter().map(|x| x * x).sum();
    let norm = norm_squared.sqrt();

    for value in state.iter_mut() {
        *value /= norm;
    }

    state
}

fn main() {
    let state = normalize_state(vec![1.0, 1.0]);

    println!("basis_index,amplitude,probability");

    for (index, amplitude) in state.iter().enumerate() {
        let probability = amplitude * amplitude;
        println!("{},{:.8},{:.8}", index, amplitude, probability);
    }
}

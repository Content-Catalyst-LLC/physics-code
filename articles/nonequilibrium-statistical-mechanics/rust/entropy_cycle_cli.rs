// Entropy Cycle CLI
//
// Computes current, affinity, and entropy production for a three-state
// Markov cycle with clockwise and counterclockwise rates.

fn entropy_production(k_plus: f64, k_minus: f64) -> (f64, f64, f64) {
    let current = (k_plus - k_minus) / 3.0;

    if k_plus <= 0.0 || k_minus <= 0.0 {
        return (current, f64::NAN, f64::NAN);
    }

    let affinity = 3.0 * (k_plus / k_minus).ln();
    let sdot = current * affinity;

    (current, affinity, sdot)
}

fn main() {
    let cases = [
        (1.0, 1.0),
        (1.5, 1.0),
        (3.0, 1.0),
        (10.0, 1.0),
        (1.0, 3.0),
    ];

    println!("k_plus,k_minus,cycle_current,affinity_kb_units,entropy_production_kb_units");

    for (k_plus, k_minus) in cases {
        let (current, affinity, sdot) = entropy_production(k_plus, k_minus);
        println!("{:.6},{:.6},{:.12},{:.12},{:.12}", k_plus, k_minus, current, affinity, sdot);
    }
}

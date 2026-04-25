// Half-Life CLI
//
// This Rust utility converts between decay constant and half-life:
//
//     t_1/2 = ln(2) / lambda
//
// It also computes N(t) for a simple exponential decay model.

fn half_life(lambda: f64) -> f64 {
    if lambda <= 0.0 {
        panic!("decay constant must be positive");
    }

    std::f64::consts::LN_2 / lambda
}

fn undecayed_nuclei(n0: f64, lambda: f64, time: f64) -> f64 {
    n0 * (-lambda * time).exp()
}

fn main() {
    let lambda = 0.22_f64;
    let n0 = 1000.0_f64;

    println!("time,undecayed_nuclei,half_life");

    for i in 0..=24 {
        let time = 0.5 * (i as f64);
        println!("{:.6},{:.6},{:.6}", time, undecayed_nuclei(n0, lambda, time), half_life(lambda));
    }
}

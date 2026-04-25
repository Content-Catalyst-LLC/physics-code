// Pendulum Period CLI Utility
//
// This Rust program computes ideal small-angle pendulum periods.
// Rust is useful for safe, fast utilities that support reproducible
// computational infrastructure.

fn ideal_pendulum_period(length_m: f64, gravity_m_per_s2: f64) -> f64 {
    2.0 * std::f64::consts::PI * (length_m / gravity_m_per_s2).sqrt()
}

fn main() {
    let gravity_m_per_s2 = 9.80665;
    let lengths_m = [0.50_f64, 0.75_f64, 1.00_f64, 1.25_f64, 1.50_f64];

    println!("length_m,gravity_m_per_s2,predicted_period_s");

    for length_m in lengths_m {
        let period_s = ideal_pendulum_period(length_m, gravity_m_per_s2);
        println!("{:.3},{:.5},{:.6}", length_m, gravity_m_per_s2, period_s);
    }
}

// Pendulum Measurement CLI
//
// This Rust utility computes:
//
//     T = 2*pi*sqrt(L/g)
//     g = 4*pi^2*L/T^2

fn small_angle_period(length_m: f64, gravity_m_per_s2: f64) -> f64 {
    2.0 * std::f64::consts::PI * (length_m / gravity_m_per_s2).sqrt()
}

fn estimate_gravity(length_m: f64, period_s: f64) -> f64 {
    4.0 * std::f64::consts::PI.powi(2) * length_m / period_s.powi(2)
}

fn main() {
    let gravity_m_per_s2 = 9.80665_f64;
    let lengths_m = [0.25_f64, 0.50, 0.75, 1.00, 1.50];

    println!("length_m,small_angle_period_s,g_estimate_from_period_m_per_s2");

    for length_m in lengths_m {
        let period_s = small_angle_period(length_m, gravity_m_per_s2);
        let g_estimate = estimate_gravity(length_m, period_s);

        println!("{:.6},{:.8},{:.8}", length_m, period_s, g_estimate);
    }
}

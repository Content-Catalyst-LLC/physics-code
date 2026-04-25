// Pendulum Uncertainty CLI
//
// This Rust utility computes:
//
//     g = 4*pi^2*L / T^2
//
// and first-order propagated uncertainty.

fn estimate_g(length_m: f64, period_s: f64) -> f64 {
    4.0 * std::f64::consts::PI.powi(2) * length_m / period_s.powi(2)
}

fn propagated_uncertainty(length_m: f64, u_length_m: f64, period_s: f64, u_period_s: f64) -> f64 {
    let dg_dlength = 4.0 * std::f64::consts::PI.powi(2) / period_s.powi(2);
    let dg_dperiod = -8.0 * std::f64::consts::PI.powi(2) * length_m / period_s.powi(3);

    ((dg_dlength * u_length_m).powi(2) + (dg_dperiod * u_period_s).powi(2)).sqrt()
}

fn main() {
    let length_m = 0.75_f64;
    let u_length_m = 0.001_f64;
    let period_s = 1.741_f64;
    let u_period_s = 0.005_f64;

    let g = estimate_g(length_m, period_s);
    let u_g = propagated_uncertainty(length_m, u_length_m, period_s, u_period_s);

    println!("length_m,u_length_m,period_s,u_period_s,g_estimate_m_s2,u_g_m_s2");
    println!("{:.6},{:.6},{:.6},{:.6},{:.8},{:.8}", length_m, u_length_m, period_s, u_period_s, g, u_g);
}

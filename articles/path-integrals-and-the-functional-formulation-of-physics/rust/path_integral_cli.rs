// Path Integral CLI
//
// This Rust utility computes discretized Euclidean harmonic oscillator actions.

fn euclidean_action(path: &[f64], mass: f64, omega: f64, delta_tau: f64) -> f64 {
    let n = path.len();
    let mut total = 0.0_f64;

    for i in 0..n {
        let next = (i + 1) % n;

        let kinetic = mass / (2.0 * delta_tau) * (path[next] - path[i]).powi(2);
        let potential = 0.5 * delta_tau * mass * omega.powi(2) * path[i].powi(2);

        total += kinetic + potential;
    }

    total
}

fn main() {
    let n_steps = 128_usize;
    let beta = 4.0_f64;
    let delta_tau = beta / n_steps as f64;

    println!("amplitude,euclidean_action,path_weight");

    let mut amplitude = 0.0_f64;

    while amplitude <= 2.0001 {
        let mut path = vec![0.0_f64; n_steps];

        for i in 0..n_steps {
            let tau = i as f64 * delta_tau;
            path[i] = amplitude * (2.0 * std::f64::consts::PI * tau / beta).sin();
        }

        let action = euclidean_action(&path, 1.0, 1.0, delta_tau);

        println!("{:.6},{:.12},{:.12}", amplitude, action, (-action).exp());

        amplitude += 0.25;
    }
}

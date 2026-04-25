// Hamiltonian Pendulum CLI
//
// This Rust utility computes the simple pendulum Hamiltonian:
//
//     H = p^2/(2 m l^2) + m g l(1 - cos(theta))

fn hamiltonian(theta: f64, p: f64, mass: f64, length: f64, g: f64) -> f64 {
    p.powi(2) / (2.0 * mass * length.powi(2)) + mass * g * length * (1.0 - theta.cos())
}

fn main() {
    let mass = 1.0_f64;
    let length = 1.0_f64;
    let g = 9.80665_f64;

    let theta_values = [
        -std::f64::consts::PI,
        -std::f64::consts::FRAC_PI_2,
        0.0,
        std::f64::consts::FRAC_PI_2,
        std::f64::consts::PI,
    ];

    let p_values = [-4.0_f64, -2.0, 0.0, 2.0, 4.0];

    println!("theta_rad,p_theta_kg_m2_per_s,hamiltonian_j");

    for theta in theta_values {
        for p in p_values {
            println!("{:.8},{:.8},{:.8}", theta, p, hamiltonian(theta, p, mass, length, g));
        }
    }
}

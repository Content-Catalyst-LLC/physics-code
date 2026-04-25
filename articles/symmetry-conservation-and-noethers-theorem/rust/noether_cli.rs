// Noether CLI
//
// This Rust utility computes energy and angular momentum for
// a two-dimensional central-force state.

fn energy(mu: f64, x: f64, y: f64, vx: f64, vy: f64) -> f64 {
    let r = (x * x + y * y).sqrt();
    let kinetic = 0.5 * (vx * vx + vy * vy);
    let potential = -mu / r;
    kinetic + potential
}

fn angular_momentum_z(x: f64, y: f64, vx: f64, vy: f64) -> f64 {
    x * vy - y * vx
}

fn main() {
    let mu = 1.0_f64;
    let states = [
        (1.0_f64, 0.0_f64, 0.0_f64, 0.8_f64),
        (1.0_f64, 0.0_f64, 0.0_f64, 1.0_f64),
        (2.0_f64, 0.0_f64, 0.0_f64, 0.5_f64),
        (1.0_f64, 1.0_f64, -0.3_f64, 0.7_f64),
    ];

    println!("case_id,x,y,vx,vy,energy,angular_momentum_z");

    for (index, state) in states.iter().enumerate() {
        let (x, y, vx, vy) = *state;
        println!(
            "case_{},{:.8},{:.8},{:.8},{:.8},{:.12},{:.12}",
            index + 1,
            x,
            y,
            vx,
            vy,
            energy(mu, x, y, vx, vy),
            angular_momentum_z(x, y, vx, vy)
        );
    }
}

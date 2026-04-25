// Numerics CLI
//
// Computes central-difference derivative errors and heat-equation stability numbers.

fn central_difference_sin(x: f64, dx: f64) -> f64 {
    ((x + dx).sin() - (x - dx).sin()) / (2.0 * dx)
}

fn heat_stability_number(diffusion: f64, dt: f64, dx: f64) -> f64 {
    diffusion * dt / (dx * dx)
}

fn main() {
    let x = 1.0_f64;
    let exact = x.cos();

    println!("kind,param1,param2,param3,value");

    for power in -2..=-16 {
        let dx = 2.0_f64.powi(power);
        let numeric = central_difference_sin(x, dx);
        let error = (numeric - exact).abs();

        println!("derivative_error,{:.12},{:.12},{:.12},{:.12}", dx, numeric, exact, error);
    }

    let diffusion = 1.0_f64;
    let domain_length = 1.0_f64;
    let n_grid = 101.0_f64;
    let dx = domain_length / (n_grid - 1.0);

    for dt in [0.00004_f64, 0.00005, 0.00008] {
        let r = heat_stability_number(diffusion, dt, dx);
        println!("heat_stability,{:.12},{:.12},{:.12},{:.12}", diffusion, dt, dx, r);
    }
}

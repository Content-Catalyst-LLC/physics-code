// Double-Well Minima CLI
//
// This Rust utility scans a simple double-well potential:
//
//     V(x) = -a*x^2 + b*x^4
//
// The potential is symmetric under x -> -x and has nonzero minima.

fn double_well_potential(x: f64, a: f64, b: f64) -> f64 {
    -a * x * x + b * x.powi(4)
}

fn main() {
    let a = 1.0_f64;
    let b = 0.25_f64;

    let mut min_x = 0.0_f64;
    let mut min_v = f64::INFINITY;

    println!("x,potential");

    for i in 0..=600 {
        let x = -3.0 + (i as f64) * 0.01;
        let v = double_well_potential(x, a, b);

        if v < min_v {
            min_v = v;
            min_x = x;
        }

        if i % 50 == 0 {
            println!("{:.6},{:.6}", x, v);
        }
    }

    println!("\napproximate_minimum_x,minimum_potential");
    println!("{:.6},{:.6}", min_x, min_v);
}

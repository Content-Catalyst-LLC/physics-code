// Logistic Map CLI
//
// This Rust utility iterates:
//
//     x_{n+1} = r x_n (1 - x_n)

fn logistic_step(r: f64, x: f64) -> f64 {
    r * x * (1.0 - x)
}

fn main() {
    let r_values = [2.8_f64, 3.2, 3.5, 3.9];
    let n_iter = 60;

    println!("r,iteration,x");

    for r in r_values {
        let mut x = 0.2_f64;

        for iteration in 1..=n_iter {
            println!("{:.8},{},{}", r, iteration, x);
            x = logistic_step(r, x);
        }
    }
}

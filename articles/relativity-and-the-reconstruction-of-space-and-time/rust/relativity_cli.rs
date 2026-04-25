// Relativity CLI
//
// This Rust utility computes:
//
//     gamma = 1 / sqrt(1 - beta^2)
//
// and collinear velocity composition:
//
//     beta_prime = (beta_u - beta_v) / (1 - beta_u beta_v)

fn lorentz_factor(beta: f64) -> f64 {
    if beta.abs() >= 1.0 {
        panic!("beta must satisfy |beta| < 1");
    }

    1.0 / (1.0 - beta * beta).sqrt()
}

fn compose_beta(beta_u: f64, beta_v: f64) -> f64 {
    if beta_u.abs() >= 1.0 || beta_v.abs() >= 1.0 {
        panic!("all beta values must satisfy |beta| < 1");
    }

    (beta_u - beta_v) / (1.0 - beta_u * beta_v)
}

fn main() {
    let betas = [0.0_f64, 0.1, 0.3, 0.5, 0.8, 0.9, 0.99];

    println!("beta,gamma,relativistic_ke_scaled,newtonian_ke_scaled");

    for beta in betas {
        let gamma = lorentz_factor(beta);
        let relativistic_ke_scaled = gamma - 1.0;
        let newtonian_ke_scaled = 0.5 * beta * beta;

        println!(
            "{:.6},{:.8},{:.8},{:.8}",
            beta,
            gamma,
            relativistic_ke_scaled,
            newtonian_ke_scaled
        );
    }

    println!("\nbeta_u,beta_v,beta_prime");

    for beta_u in [0.3_f64, 0.5, 0.8] {
        for beta_v in [0.1_f64, 0.3, 0.5] {
            println!("{:.6},{:.6},{:.8}", beta_u, beta_v, compose_beta(beta_u, beta_v));
        }
    }
}

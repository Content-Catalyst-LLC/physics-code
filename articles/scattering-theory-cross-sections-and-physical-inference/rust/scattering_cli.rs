// Scattering CLI
//
// Computes analytic total cross sections and event counts for simple cases.

fn total_cross_section(sigma0: f64, alpha: f64) -> f64 {
    4.0 * std::f64::consts::PI * sigma0 * (1.0 + alpha / 3.0)
}

fn expected_events(l_int: f64, sigma: f64, efficiency: f64, acceptance: f64, background: f64) -> f64 {
    l_int * sigma * efficiency * acceptance + background
}

fn main() {
    println!("kind,param1,param2,param3,param4,param5,value");

    for alpha in [0.0_f64, 0.5, 1.0, 1.5, 2.0] {
        println!(
            "total_cross_section,1.0,{:.6},0,0,0,{:.12}",
            alpha,
            total_cross_section(1.0, alpha)
        );
    }

    println!(
        "expected_events,100.0,0.5,0.7,0.6,12.0,{:.12}",
        expected_events(100.0, 0.5, 0.7, 0.6, 12.0)
    );
}

// Redshift to Scale Factor CLI
//
// This Rust utility converts redshift to scale factor using:
//
//     a = 1 / (1 + z)
//
// The present scale factor is normalized to 1.

fn scale_factor(redshift: f64) -> f64 {
    if redshift < 0.0 {
        panic!("redshift must be nonnegative for this example");
    }

    1.0 / (1.0 + redshift)
}

fn main() {
    let redshifts = [0.0_f64, 0.5, 1.0, 2.0, 3.0, 10.0, 100.0, 1100.0];

    println!("redshift,scale_factor");

    for z in redshifts {
        println!("{:.4},{:.8}", z, scale_factor(z));
    }
}

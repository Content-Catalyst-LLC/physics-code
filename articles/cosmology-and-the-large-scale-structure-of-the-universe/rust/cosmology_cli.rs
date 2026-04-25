// Cosmology CLI
//
// This Rust utility computes E(z), H(z), scale factor, and a simple
// flat Lambda-CDM expansion table.

fn e_z(z: f64, omega_m: f64, omega_lambda: f64) -> f64 {
    (omega_m * (1.0 + z).powi(3) + omega_lambda).sqrt()
}

fn main() {
    let h0 = 67.4_f64;
    let omega_m = 0.315_f64;
    let omega_lambda = 0.685_f64;
    let redshifts = [0.0_f64, 0.1, 0.5, 1.0, 2.0, 3.0, 6.0];

    println!("redshift,scale_factor,E_z,H_z_km_s_mpc");

    for z in redshifts {
        let ez = e_z(z, omega_m, omega_lambda);
        println!("{:.6},{:.12},{:.12},{:.12}", z, 1.0 / (1.0 + z), ez, h0 * ez);
    }
}

// Photon Transition CLI
//
// This Rust utility computes hydrogen spectral wavelengths and photon energies.

fn wavelength_nm(n_lower: i32, n_upper: i32) -> f64 {
    let rydberg_hydrogen = 1.096775834e7_f64;
    let inverse_wavelength_m = rydberg_hydrogen
        * (1.0 / (n_lower as f64).powi(2) - 1.0 / (n_upper as f64).powi(2));

    (1.0 / inverse_wavelength_m) * 1.0e9
}

fn photon_energy_ev(lambda_nm: f64) -> f64 {
    let hc_ev_nm = 1239.841984_f64;
    hc_ev_nm / lambda_nm
}

fn main() {
    println!("n_lower,n_upper,wavelength_nm,photon_energy_ev");

    for n_lower in 1..=3 {
        for n_upper in (n_lower + 1)..=(n_lower + 7) {
            let lambda = wavelength_nm(n_lower, n_upper);
            let energy = photon_energy_ev(lambda);

            println!("{},{},{:.8},{:.8}", n_lower, n_upper, lambda, energy);
        }
    }
}

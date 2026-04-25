// Photon Energy CLI
//
// This Rust utility computes:
//
//     E = h*c/lambda
//
// for selected spectral wavelengths.

fn photon_energy_ev(wavelength_nm: f64) -> f64 {
    let h = 6.626_070_15e-34_f64;
    let c = 299_792_458.0_f64;
    let joule_per_ev = 1.602_176_634e-19_f64;
    let wavelength_m = wavelength_nm * 1.0e-9;

    h * c / wavelength_m / joule_per_ev
}

fn main() {
    let lines = [
        ("H_alpha", 656.3_f64),
        ("H_beta", 486.1_f64),
        ("H_gamma", 434.0_f64),
        ("H_delta", 410.2_f64),
    ];

    println!("line,wavelength_nm,energy_ev");

    for (line, wavelength_nm) in lines {
        println!("{},{:.4},{:.8}", line, wavelength_nm, photon_energy_ev(wavelength_nm));
    }
}

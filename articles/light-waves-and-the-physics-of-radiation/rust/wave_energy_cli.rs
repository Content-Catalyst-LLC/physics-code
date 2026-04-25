// Wave Energy CLI
//
// This Rust utility computes:
//
//     f = c / lambda
//     E = h f = h c / lambda
//
// for selected wavelengths.

fn main() {
    let c = 299_792_458.0_f64;
    let h = 6.626_070_15e-34_f64;
    let joule_per_ev = 1.602_176_634e-19_f64;

    let wavelengths_m = [
        1000.0e-9_f64,
        700.0e-9_f64,
        550.0e-9_f64,
        400.0e-9_f64,
        100.0e-9_f64,
        1.0e-9_f64,
    ];

    println!("wavelength_m,frequency_hz,photon_energy_j,photon_energy_ev");

    for wavelength_m in wavelengths_m {
        let frequency_hz = c / wavelength_m;
        let energy_j = h * frequency_hz;
        let energy_ev = energy_j / joule_per_ev;

        println!(
            "{:.8e},{:.8e},{:.8e},{:.8}",
            wavelength_m,
            frequency_hz,
            energy_j,
            energy_ev
        );
    }
}

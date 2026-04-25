// Experimental Physics CLI
//
// This Rust utility computes combined uncertainty, expanded uncertainty,
// signal-to-noise ratio, and resistance uncertainty.

fn combined_uncertainty(components: &[f64]) -> f64 {
    components.iter().map(|x| x * x).sum::<f64>().sqrt()
}

fn expanded_uncertainty(combined: f64, coverage_factor: f64) -> f64 {
    coverage_factor * combined
}

fn snr_db(signal_rms: f64, noise_rms: f64) -> f64 {
    20.0 * (signal_rms / noise_rms).log10()
}

fn resistance_uncertainty(voltage: f64, u_voltage: f64, current: f64, u_current: f64) -> (f64, f64) {
    let resistance = voltage / current;
    let relative = ((u_voltage / voltage).powi(2) + (u_current / current).powi(2)).sqrt();
    (resistance, resistance * relative)
}

fn main() {
    let components = [0.02_f64, 0.01_f64, 0.005_f64];
    let uc = combined_uncertainty(&components);
    let (resistance, u_resistance) = resistance_uncertainty(10.0, 0.02, 2.0, 0.005);

    println!("quantity,value");
    println!("combined_uncertainty,{:.12}", uc);
    println!("expanded_uncertainty_k2,{:.12}", expanded_uncertainty(uc, 2.0));
    println!("snr_db,{:.12}", snr_db(1.414213562, 0.25));
    println!("resistance_ohm,{:.12}", resistance);
    println!("resistance_uncertainty_ohm,{:.12}", u_resistance);
}

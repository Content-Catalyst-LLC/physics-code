// Biophysics CLI
//
// This Rust utility computes diffusion time, binding occupancy,
// Nernst potential, and Michaelis-Menten rate.

fn diffusion_time(length_um: f64, diffusion_um2_s: f64, dimension: f64) -> f64 {
    length_um.powi(2) / (2.0 * dimension * diffusion_um2_s)
}

fn binding_occupancy(ligand_m: f64, kd_m: f64) -> f64 {
    ligand_m / (kd_m + ligand_m)
}

fn nernst_potential(cout_m_m: f64, cin_m_m: f64, z: f64, temperature_k: f64) -> f64 {
    let gas_constant = 8.314462618_f64;
    let faraday_constant = 96485.33212_f64;
    (gas_constant * temperature_k / (z * faraday_constant)) * (cout_m_m / cin_m_m).ln()
}

fn michaelis_menten(substrate: f64, vmax: f64, km: f64) -> f64 {
    vmax * substrate / (km + substrate)
}

fn main() {
    println!("quantity,value,unit");
    println!("diffusion_time_cell,{:.8},s", diffusion_time(10.0, 10.0, 1.0));
    println!("binding_occupancy_at_KD,{:.8},dimensionless", binding_occupancy(1.0e-6, 1.0e-6));
    println!("potassium_nernst_310K,{:.8},V", nernst_potential(5.0, 140.0, 1.0, 310.15));
    println!("enzyme_rate_at_KM,{:.8},uM/s", michaelis_menten(50.0, 100.0, 50.0));
}

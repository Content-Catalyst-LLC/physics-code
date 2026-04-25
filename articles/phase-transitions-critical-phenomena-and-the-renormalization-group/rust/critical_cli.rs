// Critical Phenomena CLI
//
// This Rust utility computes Landau free energy, order-parameter scaling,
// susceptibility scaling, and RG toy-flow updates.

fn landau_free_energy(m: f64, temperature: f64, critical_temperature: f64, a: f64, b: f64) -> f64 {
    a * (temperature - critical_temperature) * m.powi(2) + b * m.powi(4)
}

fn order_parameter_scale(reduced_temperature: f64, beta_exponent: f64) -> f64 {
    if reduced_temperature >= 0.0 {
        return f64::NAN;
    }
    reduced_temperature.abs().powf(beta_exponent)
}

fn susceptibility_scale(reduced_temperature: f64, gamma_exponent: f64) -> f64 {
    reduced_temperature.abs().powf(-gamma_exponent)
}

fn rg_update(u: f64, scale_factor: f64, y_exponent: f64) -> f64 {
    scale_factor.powf(y_exponent) * u
}

fn main() {
    println!("quantity,value");
    println!(
        "landau_f_m0p5_T0p8,{:.12}",
        landau_free_energy(0.5, 0.8, 1.0, 1.0, 1.0)
    );
    println!(
        "mean_field_m_t_minus_0p1,{:.12}",
        order_parameter_scale(-0.1, 0.5)
    );
    println!(
        "mean_field_chi_t_0p1,{:.12}",
        susceptibility_scale(0.1, 1.0)
    );
    println!(
        "rg_relevant_update,{:.12}",
        rg_update(0.01, 2.0, 1.0)
    );
}

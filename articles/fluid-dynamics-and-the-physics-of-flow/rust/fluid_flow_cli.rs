// Fluid Flow CLI
//
// This Rust utility computes Reynolds number:
//
//     Re = rho * v * L / mu

fn classify_reynolds(re: f64) -> &'static str {
    if re < 2300.0 {
        "laminar"
    } else if re <= 4000.0 {
        "transitional"
    } else {
        "turbulent"
    }
}

fn main() {
    let cases = [
        ("slow_water_small_pipe", 1000.0, 0.02, 0.01, 1.0e-3),
        ("moderate_water_pipe", 1000.0, 0.50, 0.05, 1.0e-3),
        ("fast_water_pipe", 1000.0, 2.00, 0.10, 1.0e-3),
        ("viscous_oil_pipe", 850.0, 0.20, 0.04, 0.20),
        ("microfluidic_channel", 1000.0, 0.001, 0.0001, 1.0e-3),
        ("air_duct", 1.204, 5.0, 0.20, 1.81e-5),
    ];

    println!("case_id,density_kg_per_m3,velocity_m_per_s,length_m,viscosity_pa_s,reynolds_number,flow_regime");

    for (case_id, rho, velocity, length, viscosity) in cases {
        let re = rho * velocity * length / viscosity;

        println!(
            "{},{:.8},{:.8},{:.10},{:.10},{:.8},{}",
            case_id,
            rho,
            velocity,
            length,
            viscosity,
            re,
            classify_reynolds(re)
        );
    }
}

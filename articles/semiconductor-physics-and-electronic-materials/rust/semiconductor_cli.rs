// Semiconductor CLI
//
// This Rust utility computes thermal voltage, intrinsic carrier concentration,
// conductivity, and ideal diode current.

fn thermal_voltage(temperature_k: f64) -> f64 {
    let q = 1.602176634e-19_f64;
    let kb = 1.380649e-23_f64;
    kb * temperature_k / q
}

fn intrinsic_carrier_cm3(eg_ev: f64, nc_cm3: f64, nv_cm3: f64, temperature_k: f64) -> f64 {
    let kb_ev_k = 8.617333262145e-5_f64;
    (nc_cm3 * nv_cm3).sqrt() * (-eg_ev / (2.0 * kb_ev_k * temperature_k)).exp()
}

fn conductivity_s_m(n_cm3: f64, mobility_cm2_v_s: f64) -> f64 {
    let q = 1.602176634e-19_f64;
    let n_m3 = n_cm3 * 1.0e6;
    let mobility_m2_v_s = mobility_cm2_v_s * 1.0e-4;
    q * n_m3 * mobility_m2_v_s
}

fn diode_current(voltage_v: f64, is_a: f64, ideality: f64, temperature_k: f64) -> f64 {
    let vt = thermal_voltage(temperature_k);
    is_a * ((voltage_v / (ideality * vt)).exp() - 1.0)
}

fn main() {
    println!("quantity,value,unit");
    println!("thermal_voltage_300K,{:.10},V", thermal_voltage(300.0));
    println!(
        "silicon_like_ni_300K,{:.6e},cm^-3",
        intrinsic_carrier_cm3(1.12, 2.8e19, 1.04e19, 300.0)
    );
    println!(
        "conductivity_1e16_1000,{:.10},S/m",
        conductivity_s_m(1.0e16, 1000.0)
    );

    println!("voltage_v,current_a");
    for i in -2..=8 {
        let voltage = (i as f64) * 0.1;
        println!("{:.4},{:.8e}", voltage, diode_current(voltage, 1.0e-12, 1.0, 300.0));
    }
}

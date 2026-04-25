// Wave and Oscillator CLI
//
// This Rust utility computes:
//   omega0 = sqrt(k/m)
//   f = omega0/(2*pi)
//   f_n = n v/(2L)

fn main() {
    let mass_kg = 1.0_f64;
    let spring_constant_n_per_m = 25.0_f64;

    let omega0 = (spring_constant_n_per_m / mass_kg).sqrt();
    let frequency_hz = omega0 / (2.0 * std::f64::consts::PI);

    println!("oscillator,mass_kg,spring_constant_n_per_m,omega0_rad_per_s,frequency_hz");
    println!(
        "base,{:.6},{:.6},{:.8},{:.8}",
        mass_kg,
        spring_constant_n_per_m,
        omega0,
        frequency_hz
    );

    let wave_speed_m_per_s = 120.0_f64;
    let length_m = 0.65_f64;

    println!("\nmode,wave_speed_m_per_s,length_m,standing_wave_frequency_hz");

    for n in 1..=8 {
        let mode = n as f64;
        let standing_frequency = mode * wave_speed_m_per_s / (2.0 * length_m);

        println!(
            "{},{:.6},{:.6},{:.8}",
            n,
            wave_speed_m_per_s,
            length_m,
            standing_frequency
        );
    }
}

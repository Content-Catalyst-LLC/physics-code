// Climate Balance CLI
//
// This Rust utility computes:
//   ASR = S0(1-alpha)/4
//   Te = (ASR/sigma)^(1/4)
//   DeltaF = 5.35 ln(C/C0)

fn main() {
    let solar_constant = 1361.0_f64;
    let sigma_sb = 5.670374419e-8_f64;
    let co2_reference = 280.0_f64;

    println!("albedo,co2_ppm,asr_w_m2,te_k,co2_forcing_w_m2");

    for albedo in [0.25_f64, 0.30, 0.35] {
        let asr = solar_constant * (1.0 - albedo) / 4.0;
        let te = (asr / sigma_sb).powf(0.25);

        for co2 in [280.0_f64, 420.0, 560.0, 700.0] {
            let forcing = 5.35 * (co2 / co2_reference).ln();

            println!(
                "{:.4},{:.4},{:.8},{:.8},{:.8}",
                albedo,
                co2,
                asr,
                te,
                forcing
            );
        }
    }
}

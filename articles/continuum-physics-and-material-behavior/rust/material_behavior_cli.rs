// Material Behavior CLI
//
// This Rust utility computes stress from strain and von Mises stress from
// principal stresses.

fn von_mises_principal(s1: f64, s2: f64, s3: f64) -> f64 {
    (0.5 * ((s1 - s2).powi(2) + (s2 - s3).powi(2) + (s3 - s1).powi(2))).sqrt()
}

fn main() {
    let youngs_modulus_gpa = 200.0_f64;
    let youngs_modulus_mpa = youngs_modulus_gpa * 1000.0;

    println!("strain,stress_mpa,elastic_energy_density_mj_per_m3");

    for strain in [0.0_f64, 0.0005, 0.0010, 0.0015, 0.0020, 0.0025] {
        let stress_mpa = youngs_modulus_mpa * strain;
        let energy_density_mj_per_m3 = 0.5 * stress_mpa * strain;

        println!(
            "{:.8},{:.8},{:.8}",
            strain,
            stress_mpa,
            energy_density_mj_per_m3
        );
    }

    let vm = von_mises_principal(180.0, 60.0, 0.0);
    println!("\ncase,von_mises_mpa");
    println!("plane_stress_example,{:.8}", vm);
}

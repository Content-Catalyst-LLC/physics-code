// Thermodynamics CLI
//
// This Rust utility computes reversible isothermal ideal-gas work:
//
//     W = n R T ln(V2/V1)
//
// and entropy change:
//
//     Delta S = n R ln(V2/V1)

fn main() {
    let r = 8.314_462_618_f64;
    let n = 1.0_f64;
    let temperature_k = 300.0_f64;
    let v1 = 0.02_f64;

    let final_volumes = [0.03_f64, 0.04, 0.06, 0.08, 0.10];

    println!("v1_m3,v2_m3,isothermal_work_j,entropy_change_j_per_k");

    for v2 in final_volumes {
        let work_j = n * r * temperature_k * (v2 / v1).ln();
        let entropy_change_j_per_k = n * r * (v2 / v1).ln();

        println!(
            "{:.6},{:.6},{:.8},{:.8}",
            v1,
            v2,
            work_j,
            entropy_change_j_per_k
        );
    }
}

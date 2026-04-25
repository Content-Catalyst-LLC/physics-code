// Kepler Scaling CLI
//
// This Rust utility computes normalized Kepler-style orbital periods.
//
// Relation:
//     T = a^(3/2)
//
// where:
//     a = semi-major axis in normalized units
//     T = orbital period in normalized units

fn kepler_period(semi_major_axis: f64) -> f64 {
    semi_major_axis.powf(1.5)
}

fn main() {
    let semi_major_axes = [0.5_f64, 1.0, 1.5, 2.0, 5.0, 10.0];

    println!("semi_major_axis_normalized,orbital_period_normalized");

    for axis in semi_major_axes {
        let period = kepler_period(axis);
        println!("{:.4},{:.6}", axis, period);
    }
}

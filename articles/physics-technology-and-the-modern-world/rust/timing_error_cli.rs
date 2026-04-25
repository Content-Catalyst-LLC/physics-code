// Timing Error CLI
//
// This Rust utility converts timing uncertainty in nanoseconds
// into position uncertainty in meters using:
//
//     delta_d = c * delta_t

const SPEED_OF_LIGHT_M_PER_S: f64 = 299_792_458.0;

fn position_error_m(timing_error_ns: f64) -> f64 {
    let timing_error_s = timing_error_ns * 1e-9;
    SPEED_OF_LIGHT_M_PER_S * timing_error_s
}

fn main() {
    let timing_errors_ns = [1.0_f64, 5.0, 10.0, 25.0, 50.0, 100.0];

    println!("timing_error_ns,position_error_m");

    for timing_error_ns in timing_errors_ns {
        println!("{:.3},{:.6}", timing_error_ns, position_error_m(timing_error_ns));
    }
}

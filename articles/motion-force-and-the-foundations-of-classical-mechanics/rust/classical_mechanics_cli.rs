// Classical Mechanics CLI
//
// This Rust utility computes ideal projectile time of flight, range, and
// maximum height:
//
//     T = 2 v0 sin(theta) / g
//     R = v0^2 sin(2 theta) / g
//     H = v0^2 sin^2(theta) / (2g)

fn main() {
    let g = 9.80665_f64;
    let v0 = 12.0_f64;
    let angles_deg = [20.0_f64, 30.0, 45.0, 60.0, 70.0];

    println!("initial_speed_m_per_s,launch_angle_deg,time_of_flight_s,range_m,max_height_m");

    for angle_deg in angles_deg {
        let theta = angle_deg.to_radians();
        let time_of_flight = 2.0 * v0 * theta.sin() / g;
        let range_m = v0.powi(2) * (2.0 * theta).sin() / g;
        let max_height = v0.powi(2) * theta.sin().powi(2) / (2.0 * g);

        println!(
            "{:.6},{:.6},{:.8},{:.8},{:.8}",
            v0,
            angle_deg,
            time_of_flight,
            range_m,
            max_height
        );
    }
}

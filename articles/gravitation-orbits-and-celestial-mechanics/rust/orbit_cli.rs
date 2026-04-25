// Orbit CLI
//
// This Rust utility computes circular speed, escape speed, and orbital period:
//
//     v_circ = sqrt(mu/r)
//     v_esc  = sqrt(2mu/r)
//     T      = 2*pi*sqrt(r^3/mu)

fn main() {
    let mu_earth = 3.986_004_418e14_f64;
    let earth_radius_m = 6.371e6_f64;

    let altitudes_m = [400e3_f64, 700e3, 20200e3, 35786e3, 60000e3];

    println!("altitude_m,orbital_radius_m,circular_speed_m_per_s,escape_speed_m_per_s,period_hours");

    for altitude_m in altitudes_m {
        let r = earth_radius_m + altitude_m;
        let circular_speed = (mu_earth / r).sqrt();
        let escape_speed = (2.0 * mu_earth / r).sqrt();
        let period_hours = 2.0 * std::f64::consts::PI * (r.powi(3) / mu_earth).sqrt() / 3600.0;

        println!(
            "{:.3},{:.3},{:.8},{:.8},{:.8}",
            altitude_m,
            r,
            circular_speed,
            escape_speed,
            period_hours
        );
    }
}

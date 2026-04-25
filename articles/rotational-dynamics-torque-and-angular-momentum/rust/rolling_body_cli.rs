// Rolling Body CLI
//
// This Rust utility computes ideal rolling acceleration and final speed:
//
//     a = g sin(theta) / (1 + beta)
//     v = sqrt(2 g h / (1 + beta))

fn main() {
    let g = 9.80665_f64;
    let incline_angle_rad = 20.0_f64.to_radians();
    let height_drop_m = 1.0_f64;

    let bodies = [
        ("hoop", 1.0_f64),
        ("solid_disk", 0.5_f64),
        ("solid_sphere", 0.4_f64),
        ("thin_spherical_shell", 2.0_f64 / 3.0_f64),
        ("sliding_point_mass", 0.0_f64),
    ];

    println!("object,beta,acceleration_m_per_s2,final_speed_m_per_s,rotational_energy_fraction");

    for (name, beta) in bodies {
        let acceleration = g * incline_angle_rad.sin() / (1.0 + beta);
        let final_speed = (2.0 * g * height_drop_m / (1.0 + beta)).sqrt();
        let rotational_energy_fraction = beta / (1.0 + beta);

        println!(
            "{},{:.8},{:.8},{:.8},{:.8}",
            name,
            beta,
            acceleration,
            final_speed,
            rotational_energy_fraction
        );
    }
}

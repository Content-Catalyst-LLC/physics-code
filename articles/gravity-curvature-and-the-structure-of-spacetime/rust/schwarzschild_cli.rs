// Schwarzschild CLI
//
// This Rust utility computes:
//
//     r_s = 2GM/c^2
//     d_tau/dt = sqrt(1 - r_s/r)
//
// for selected masses and radius multiples.

fn schwarzschild_radius(mass_kg: f64) -> f64 {
    let g = 6.67430e-11_f64;
    let c = 299_792_458.0_f64;

    2.0 * g * mass_kg / c.powi(2)
}

fn clock_factor(radius_m: f64, rs_m: f64) -> f64 {
    if radius_m <= rs_m {
        panic!("radius must be outside Schwarzschild radius");
    }

    (1.0 - rs_m / radius_m).sqrt()
}

fn main() {
    let objects = [
        ("Earth", 5.972e24_f64),
        ("Sun", 1.98847e30_f64),
        ("Ten solar masses", 1.98847e31_f64),
    ];

    let radius_multiples = [1.05_f64, 1.5, 2.0, 3.0, 5.0, 10.0, 20.0];

    println!("object,mass_kg,schwarzschild_radius_m,radius_over_rs,clock_factor");

    for (name, mass_kg) in objects {
        let rs = schwarzschild_radius(mass_kg);

        for multiple in radius_multiples {
            let radius = multiple * rs;
            println!(
                "{},{:.8e},{:.8e},{:.4},{:.8}",
                name,
                mass_kg,
                rs,
                multiple,
                clock_factor(radius, rs)
            );
        }
    }
}

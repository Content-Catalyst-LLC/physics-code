// Simulation Diagnostics CLI
//
// This Rust utility computes the explicit diffusion stability number:
//
//     s = D dt / dx^2

fn main() {
    let length_m = 1.0_f64;
    let n_grid = 201.0_f64;
    let diffusivity = 0.001_f64;
    let dt = 0.0002_f64;

    let dx = length_m / (n_grid - 1.0);
    let stability_number = diffusivity * dt / dx.powi(2);

    println!("quantity,value,unit_or_status");
    println!("dx,{:.10},m", dx);
    println!("time_step,{:.10},s", dt);
    println!("diffusivity,{:.10},m2_per_s", diffusivity);
    println!("stability_number,{:.10},dimensionless", stability_number);
    println!(
        "explicit_diffusion_stability,{},status",
        if stability_number <= 0.5 { "stable" } else { "unstable" }
    );
}

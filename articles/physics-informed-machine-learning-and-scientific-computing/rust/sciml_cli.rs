// SciML CLI
//
// Computes analytic heat-equation residuals for:
// u(x,t) = exp(-D*pi^2*t) sin(pi*x)

fn main() {
    let diffusion = 0.1_f64;
    let pi = std::f64::consts::PI;

    println!("x,t,u,residual");

    let xs = [0.1_f64, 0.3, 0.5, 0.7, 0.9];
    let ts = [0.0_f64, 0.25, 0.5, 0.75, 1.0];

    for x in xs {
        for t in ts {
            let common = (-diffusion * pi * pi * t).exp() * (pi * x).sin();
            let u = common;
            let u_t = -diffusion * pi * pi * common;
            let u_xx = -pi * pi * common;
            let residual = u_t - diffusion * u_xx;

            println!("{:.6},{:.6},{:.12},{:.12}", x, t, u, residual);
        }
    }
}

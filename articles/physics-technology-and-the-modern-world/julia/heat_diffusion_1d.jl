# One-Dimensional Heat Diffusion Scaffold
#
# This Julia workflow simulates a simple explicit finite-difference
# heat diffusion model.
#
# Equation:
#   dT/dt = alpha * d2T/dx2
#
# This is relevant to thermal management in electronics, energy systems,
# materials, sensors, and instrument design.

function simulate_heat_diffusion()
    alpha_m2_per_s = 1.0e-5
    length_m = 0.10
    n_points = 51
    dx_m = length_m / (n_points - 1)
    dt_s = 0.2 * dx_m^2 / alpha_m2_per_s
    n_steps = 300

    temperature_c = fill(20.0, n_points)
    temperature_c[Int(round(n_points / 2))] = 100.0

    println("step,position_m,temperature_c")

    for step in 0:n_steps
        if step % 25 == 0
            for i in 1:n_points
                position_m = (i - 1) * dx_m
                println("$(step),$(round(position_m, digits=6)),$(round(temperature_c[i], digits=6))")
            end
        end

        next_temperature_c = copy(temperature_c)

        for i in 2:(n_points - 1)
            next_temperature_c[i] =
                temperature_c[i] +
                alpha_m2_per_s * dt_s / dx_m^2 *
                (temperature_c[i + 1] - 2.0 * temperature_c[i] + temperature_c[i - 1])
        end

        temperature_c = next_temperature_c
    end
end

simulate_heat_diffusion()

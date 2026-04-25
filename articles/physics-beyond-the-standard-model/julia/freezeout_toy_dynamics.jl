# Freeze-Out Toy Dynamics
#
# This Julia workflow provides a simplified dynamical model for abundance
# decreasing with interaction strength.
#
# This is not a full Boltzmann solver. It is a transparent scaffold for
# thinking about how abundance evolution can be represented numerically.

function evolve_abundance(; sigma_v=1.0, initial_abundance=1.0, dt=0.01, total_time=10.0)
    n_steps = Int(round(total_time / dt))
    abundance = initial_abundance

    println("time,abundance,sigma_v")

    for step in 0:n_steps
        time = step * dt

        if step % 50 == 0
            println("$(round(time, digits=4)),$(round(abundance, digits=8)),$(sigma_v)")
        end

        # Toy depletion relation:
        # dY/dt = -sigma_v * Y^2
        derivative = -sigma_v * abundance^2
        abundance = max(abundance + derivative * dt, 0.0)
    end
end

evolve_abundance(sigma_v=0.5, initial_abundance=1.0, dt=0.01, total_time=10.0)

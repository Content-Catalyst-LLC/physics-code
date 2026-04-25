# Two-Body Orbit RK4 Simulation
#
# This Julia script simulates a simplified two-body orbital problem
# using dimensionless units.
#
# Equation:
#   r'' = -mu * r / |r|^3
#
# where:
#   r is the position vector
#   mu is the gravitational parameter

function acceleration(x, y, mu)
    radius = sqrt(x^2 + y^2)
    ax = -mu * x / radius^3
    ay = -mu * y / radius^3
    return ax, ay
end

function derivatives(state, mu)
    x, y, vx, vy = state
    ax, ay = acceleration(x, y, mu)
    return [vx, vy, ax, ay]
end

function rk4_step(state, dt, mu)
    k1 = derivatives(state, mu)
    k2 = derivatives(state .+ 0.5 .* dt .* k1, mu)
    k3 = derivatives(state .+ 0.5 .* dt .* k2, mu)
    k4 = derivatives(state .+ dt .* k3, mu)

    return state .+ (dt / 6.0) .* (k1 .+ 2.0 .* k2 .+ 2.0 .* k3 .+ k4)
end

function simulate()
    mu = 1.0
    dt = 0.001
    total_time = 10.0
    n_steps = Int(round(total_time / dt))

    state = [1.0, 0.0, 0.0, 1.0]

    println("time,x,y,vx,vy")

    for step in 0:n_steps
        time = step * dt

        if step % 100 == 0
            println("$(round(time, digits=5)),$(round(state[1], digits=8)),$(round(state[2], digits=8)),$(round(state[3], digits=8)),$(round(state[4], digits=8))")
        end

        state = rk4_step(state, dt, mu)
    end
end

simulate()

# Diffusion Scaffold
#
# This Julia workflow solves a one-dimensional diffusion equation with an
# explicit finite-difference method.

function main()
    length_m = 1.0
    n_grid = 201
    diffusivity = 0.001
    dt = 0.0002
    n_steps = 1200

    x = range(0.0, length_m, length=n_grid)
    dx = step(x)
    s = diffusivity * dt / dx^2

    if s > 0.5
        error("Explicit diffusion stability condition violated.")
    end

    field = [exp(-((xi - 0.5)^2) / (2.0 * 0.04^2)) for xi in x]

    println("step,time_s,total_integral,max_field,stability_number")

    for step_index in 0:n_steps
        if step_index % 300 == 0
            total_integral = sum(field) * dx
            println("$(step_index),$(step_index * dt),$(total_integral),$(maximum(field)),$(s)")
        end

        next_field = copy(field)

        for i in 2:(n_grid - 1)
            next_field[i] = field[i] + s * (field[i + 1] - 2.0 * field[i] + field[i - 1])
        end

        next_field[1] = 0.0
        next_field[end] = 0.0

        field = next_field
    end
end

main()

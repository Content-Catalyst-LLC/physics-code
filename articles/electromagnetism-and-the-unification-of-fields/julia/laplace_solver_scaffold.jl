# Laplace Solver Scaffold
#
# This Julia workflow solves a simple 2D Laplace equation problem:
#
#   del^2 V = 0
#
# by Jacobi relaxation with fixed boundary values.

function solve_laplace(n_grid::Int, n_iterations::Int)
    potential = zeros(Float64, n_grid, n_grid)

    potential[1, :] .= 1.0
    potential[end, :] .= 0.0
    potential[:, 1] .= 0.0
    potential[:, end] .= 0.0

    for _ in 1:n_iterations
        updated = copy(potential)

        for i in 2:(n_grid - 1)
            for j in 2:(n_grid - 1)
                updated[i, j] = 0.25 * (
                    potential[i - 1, j] +
                    potential[i + 1, j] +
                    potential[i, j - 1] +
                    potential[i, j + 1]
                )
            end
        end

        potential = updated
        potential[1, :] .= 1.0
        potential[end, :] .= 0.0
        potential[:, 1] .= 0.0
        potential[:, end] .= 0.0
    end

    return potential
end

function main()
    potential = solve_laplace(80, 4000)

    println("n_grid,potential_min,potential_max,potential_mean")
    println("$(size(potential, 1)),$(minimum(potential)),$(maximum(potential)),$(mean(potential))")
end

main()

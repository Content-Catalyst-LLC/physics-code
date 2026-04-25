# Ising-Style Lattice Scaffold
#
# This Julia workflow implements a compact 2D Ising-style Metropolis scaffold.
# It is a teaching model for order parameters and collective behavior.

using Random
using Statistics

function total_energy(spins, coupling_j)
    n_rows, n_cols = size(spins)
    energy = 0.0

    for i in 1:n_rows
        for j in 1:n_cols
            right = spins[i, mod1(j + 1, n_cols)]
            down = spins[mod1(i + 1, n_rows), j]
            energy += -coupling_j * spins[i, j] * (right + down)
        end
    end

    return energy
end

function metropolis_sweep!(spins, beta, coupling_j)
    n_rows, n_cols = size(spins)

    for _ in 1:(n_rows * n_cols)
        i = rand(1:n_rows)
        j = rand(1:n_cols)

        spin = spins[i, j]

        neighbor_sum =
            spins[mod1(i + 1, n_rows), j] +
            spins[mod1(i - 1, n_rows), j] +
            spins[i, mod1(j + 1, n_cols)] +
            spins[i, mod1(j - 1, n_cols)]

        delta_energy = 2.0 * coupling_j * spin * neighbor_sum

        if delta_energy <= 0.0 || rand() < exp(-beta * delta_energy)
            spins[i, j] = -spin
        end
    end
end

function main()
    Random.seed!(42)

    lattice_size = 32
    coupling_j = 1.0

    println("lattice_size,beta,magnetization,absolute_magnetization,energy_per_spin")

    for beta in [0.2, 0.4, 0.6, 0.8]
        spins = rand([-1, 1], lattice_size, lattice_size)

        for _ in 1:500
            metropolis_sweep!(spins, beta, coupling_j)
        end

        magnetization = mean(spins)
        energy_per_spin = total_energy(spins, coupling_j) / length(spins)

        println("$(lattice_size),$(beta),$(magnetization),$(abs(magnetization)),$(energy_per_spin)")
    end
end

main()

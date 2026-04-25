# Finite-Difference Hamiltonian Scaffold
#
# This Julia workflow constructs a tridiagonal Hamiltonian for a
# one-dimensional infinite square well and prints the first few eigenvalues.
#
# H = -hbar^2/(2m) d^2/dx^2

using LinearAlgebra

const HBAR_J_S = 1.054571817e-34
const ELECTRON_MASS_KG = 9.1093837015e-31
const JOULE_PER_EV = 1.602176634e-19

function analytic_energy_j(n, mass_kg, box_length_m)
    return n^2 * pi^2 * HBAR_J_S^2 / (2.0 * mass_kg * box_length_m^2)
end

function main()
    box_length_m = 1.0e-9
    interior_points = 250
    dx_m = box_length_m / (interior_points + 1)

    coefficient = HBAR_J_S^2 / (2.0 * ELECTRON_MASS_KG * dx_m^2)

    diagonal = fill(2.0 * coefficient, interior_points)
    off_diagonal = fill(-coefficient, interior_points - 1)

    hamiltonian = SymTridiagonal(diagonal, off_diagonal)
    eigenvalues_j = eigvals(hamiltonian)

    println("n,numerical_energy_ev,analytic_energy_ev,relative_error")

    for n in 1:5
        numerical_j = eigenvalues_j[n]
        analytic_j = analytic_energy_j(n, ELECTRON_MASS_KG, box_length_m)
        relative_error = (numerical_j - analytic_j) / analytic_j

        println("$(n),$(numerical_j / JOULE_PER_EV),$(analytic_j / JOULE_PER_EV),$(relative_error)")
    end
end

main()

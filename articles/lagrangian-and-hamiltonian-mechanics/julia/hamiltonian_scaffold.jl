# Hamiltonian Mechanics Scaffold
#
# This Julia workflow computes a simple pendulum Hamiltonian over a small
# phase-space grid.

const MASS_KG = 1.0
const LENGTH_M = 1.0
const G = 9.80665

function hamiltonian(theta, p)
    kinetic = p^2 / (2.0 * MASS_KG * LENGTH_M^2)
    potential = MASS_KG * G * LENGTH_M * (1.0 - cos(theta))
    return kinetic + potential
end

function main()
    println("theta_rad,p_theta_kg_m2_per_s,hamiltonian_j")

    theta_values = range(-pi, pi, length=9)
    p_values = range(-4.0, 4.0, length=9)

    for theta in theta_values
        for p in p_values
            println("$(theta),$(p),$(hamiltonian(theta,p))")
        end
    end
end

main()

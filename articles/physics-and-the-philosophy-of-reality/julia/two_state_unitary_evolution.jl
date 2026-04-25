# Two-State Unitary Evolution
#
# This Julia example evolves a two-state vector under a simple
# unitary-like rotation.
#
# Philosophical point:
# Formal state evolution can be mathematically precise while still
# permitting multiple ontological interpretations.

using LinearAlgebra

function rotation_matrix(theta)
    return [
        cos(theta) -sin(theta);
        sin(theta)  cos(theta)
    ]
end

function norm_squared(state)
    return sum(abs2, state)
end

function simulate()
    psi = [1.0, 0.0]

    println("theta,state_1,state_2,norm_squared")

    for theta in range(0, stop=2*pi, length=21)
        transformed = rotation_matrix(theta) * psi
        println("$(round(theta, digits=6)),$(round(transformed[1], digits=8)),$(round(transformed[2], digits=8)),$(round(norm_squared(transformed), digits=8))")
    end
end

simulate()

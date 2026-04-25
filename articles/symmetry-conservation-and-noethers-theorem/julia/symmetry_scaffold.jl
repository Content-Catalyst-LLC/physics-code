# Symmetry Scaffold
#
# This Julia workflow computes basic conserved quantities
# for a two-dimensional central-force state.

function energy(mu, position, velocity)
    r = sqrt(position[1]^2 + position[2]^2)
    kinetic = 0.5 * (velocity[1]^2 + velocity[2]^2)
    potential = -mu / r
    return kinetic + potential
end

function angular_momentum_z(position, velocity)
    return position[1] * velocity[2] - position[2] * velocity[1]
end

function main()
    mu = 1.0
    position = [1.0, 0.0]
    velocity = [0.0, 0.8]

    println("quantity,value")
    println("energy,$(energy(mu, position, velocity))")
    println("angular_momentum_z,$(angular_momentum_z(position, velocity))")
end

main()

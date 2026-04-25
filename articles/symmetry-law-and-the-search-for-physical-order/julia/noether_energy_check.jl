# Noether-Style Energy Conservation Check
#
# This Julia workflow evaluates an ideal harmonic oscillator:
#
#   x(t) = A cos(omega t)
#   v(t) = -A omega sin(omega t)
#   E = 0.5*m*v^2 + 0.5*k*x^2
#
# The total energy remains constant in the ideal analytic solution.

function harmonic_energy(mass, spring_constant, amplitude, time)
    omega = sqrt(spring_constant / mass)
    position = amplitude * cos(omega * time)
    velocity = -amplitude * omega * sin(omega * time)

    kinetic_energy = 0.5 * mass * velocity^2
    potential_energy = 0.5 * spring_constant * position^2
    total_energy = kinetic_energy + potential_energy

    return position, velocity, kinetic_energy, potential_energy, total_energy
end

function main()
    mass = 1.0
    spring_constant = 4.0
    amplitude = 1.0

    println("time,position,velocity,kinetic_energy,potential_energy,total_energy")

    for time in range(0.0, stop=10.0, length=51)
        position, velocity, kinetic, potential, total = harmonic_energy(
            mass,
            spring_constant,
            amplitude,
            time
        )

        println("$(round(time, digits=5)),$(round(position, digits=8)),$(round(velocity, digits=8)),$(round(kinetic, digits=8)),$(round(potential, digits=8)),$(round(total, digits=8))")
    end
end

main()

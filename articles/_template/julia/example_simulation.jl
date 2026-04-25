function kinetic_energy(mass_kg, velocity_m_per_s)
    return 0.5 * mass_kg * velocity_m_per_s^2
end

masses = [1.0, 2.0, 5.0]
velocities = [3.0, 4.0, 5.0]

for i in eachindex(masses)
    println("KE = ", kinetic_energy(masses[i], velocities[i]), " J")
end

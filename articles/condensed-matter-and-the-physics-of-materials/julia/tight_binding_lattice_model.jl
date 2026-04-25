# Tight-Binding Lattice Model
#
# This Julia workflow evaluates a one-dimensional tight-binding band:
#
#   E(k) = -2t cos(ka)
#
# and a simple phonon-style dispersion:
#
#   omega(k) = 2 sqrt(K/M) |sin(ka/2)|

function tight_binding_energy(k; hopping=1.0, lattice_spacing=1.0)
    return -2.0 * hopping * cos(k * lattice_spacing)
end

function phonon_frequency(k; spring_constant=1.0, mass=1.0, lattice_spacing=1.0)
    return 2.0 * sqrt(spring_constant / mass) * abs(sin(k * lattice_spacing / 2.0))
end

function main()
    println("k,tight_binding_energy,phonon_frequency")

    for k in range(-pi, stop=pi, length=101)
        energy = tight_binding_energy(k)
        omega = phonon_frequency(k)

        println("$(round(k, digits=8)),$(round(energy, digits=8)),$(round(omega, digits=8))")
    end
end

main()

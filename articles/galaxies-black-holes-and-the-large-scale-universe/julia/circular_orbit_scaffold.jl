# Circular Orbit Scaffold
#
# This Julia workflow computes enclosed mass for a set of circular
# velocities and radii using:
#
#   M(r) = v(r)^2 r / G
#
# It is educational scaffolding for galaxy-dynamics intuition.

const G_SI = 6.67430e-11
const M_SUN_KG = 1.98847e30
const KPC_TO_M = 3.085677581491367e19

function enclosed_mass_solar(radius_kpc, velocity_km_s)
    radius_m = radius_kpc * KPC_TO_M
    velocity_m_s = velocity_km_s * 1000.0
    mass_kg = velocity_m_s^2 * radius_m / G_SI
    return mass_kg / M_SUN_KG
end

function main()
    radii_kpc = [2.0, 5.0, 10.0, 15.0, 20.0, 30.0]
    velocity_km_s = 220.0

    println("radius_kpc,velocity_km_s,enclosed_mass_solar")

    for radius_kpc in radii_kpc
        mass = enclosed_mass_solar(radius_kpc, velocity_km_s)
        println("$(radius_kpc),$(velocity_km_s),$(round(mass, digits=4))")
    end
end

main()

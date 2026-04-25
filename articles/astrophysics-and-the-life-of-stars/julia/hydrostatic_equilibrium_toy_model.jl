# Hydrostatic Equilibrium Toy Model
#
# This Julia workflow evaluates the hydrostatic-equilibrium pressure gradient:
#
#   dP/dr = -G M(r) rho(r) / r^2
#
# for a simplified stellar interior profile.
#
# This is educational scaffolding, not a full stellar-structure solver.

const G_SI = 6.67430e-11
const M_SUN_KG = 1.98847e30
const R_SUN_M = 6.957e8

function enclosed_mass(radius_fraction)
    # Simple illustrative profile:
    # M(r) = M_sun * (r / R_sun)^3
    # This corresponds to constant average density, used only as a toy model.
    return M_SUN_KG * radius_fraction^3
end

function density_profile(radius_fraction)
    # Simple declining density profile in kg/m^3.
    # The values are schematic and not solar calibrated.
    central_density = 1.5e5
    return central_density * max(1.0 - radius_fraction^2, 0.01)
end

function pressure_gradient(radius_fraction)
    radius_m = radius_fraction * R_SUN_M
    mass_kg = enclosed_mass(radius_fraction)
    density = density_profile(radius_fraction)

    return -G_SI * mass_kg * density / radius_m^2
end

function main()
    println("radius_fraction,enclosed_mass_kg,density_kg_m3,dP_dr_pa_per_m")

    for radius_fraction in range(0.05, stop=1.0, length=20)
        mass_kg = enclosed_mass(radius_fraction)
        density = density_profile(radius_fraction)
        dpdr = pressure_gradient(radius_fraction)

        println("$(round(radius_fraction, digits=5)),$(mass_kg),$(round(density, digits=5)),$(dpdr)")
    end
end

main()

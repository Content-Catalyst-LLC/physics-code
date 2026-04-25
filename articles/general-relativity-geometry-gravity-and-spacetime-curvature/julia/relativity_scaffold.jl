# Relativity Scaffold
#
# This Julia workflow computes Schwarzschild radius, compactness,
# and gravitational redshift.

const G = 6.67430e-11
const C = 299792458.0

function schwarzschild_radius(mass_kg)
    return 2.0 * G * mass_kg / C^2
end

function compactness(mass_kg, radius_m)
    return schwarzschild_radius(mass_kg) / radius_m
end

function redshift_z(mass_kg, radius_m)
    rs = schwarzschild_radius(mass_kg)
    if radius_m <= rs
        return NaN
    end
    return 1.0 / sqrt(1.0 - rs / radius_m) - 1.0
end

function main()
    solar_mass = 1.98847e30
    solar_radius = 6.957e8

    println("quantity,value,unit")
    println("solar_schwarzschild_radius,$(schwarzschild_radius(solar_mass)),m")
    println("solar_compactness,$(compactness(solar_mass, solar_radius)),dimensionless")
    println("solar_surface_redshift,$(redshift_z(solar_mass, solar_radius)),dimensionless")
end

main()

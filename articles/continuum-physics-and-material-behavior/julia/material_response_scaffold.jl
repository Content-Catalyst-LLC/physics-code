# Material Response Scaffold
#
# This Julia workflow computes isotropic elastic property conversions.

function shear_modulus(E, nu)
    return E / (2.0 * (1.0 + nu))
end

function bulk_modulus(E, nu)
    return E / (3.0 * (1.0 - 2.0 * nu))
end

function main()
    materials = [
        ("structural_steel", 200.0, 0.30),
        ("aluminum_6061_t6", 69.0, 0.33),
        ("titanium_ti64", 114.0, 0.34),
        ("glass_soda_lime", 70.0, 0.22),
        ("rubber_like", 0.01, 0.49)
    ]

    println("material,E_gpa,nu,G_gpa,K_gpa")

    for (name, E, nu) in materials
        println("$(name),$(E),$(nu),$(shear_modulus(E, nu)),$(bulk_modulus(E, nu))")
    end
end

main()

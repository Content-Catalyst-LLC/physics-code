# Plasma Scaffold
#
# This Julia workflow computes Debye length, plasma frequency,
# cyclotron frequency, and Larmor radius for selected values.

const EPSILON_0 = 8.8541878128e-12
const E_CHARGE = 1.602176634e-19
const ELECTRON_MASS = 9.1093837015e-31

function debye_length(ne, te_ev)
    te_j = te_ev * E_CHARGE
    return sqrt(EPSILON_0 * te_j / (ne * E_CHARGE^2))
end

function plasma_frequency_hz(ne)
    omega = sqrt(ne * E_CHARGE^2 / (EPSILON_0 * ELECTRON_MASS))
    return omega / (2.0 * pi)
end

function cyclotron_frequency_hz(B)
    omega = E_CHARGE * B / ELECTRON_MASS
    return omega / (2.0 * pi)
end

function larmor_radius(B, vperp)
    return ELECTRON_MASS * vperp / (E_CHARGE * B)
end

function main()
    println("density_m3,temperature_ev,B_t,debye_length_m,plasma_frequency_hz,cyclotron_frequency_hz,larmor_radius_m")

    for ne in [1.0e14, 1.0e16, 1.0e18, 1.0e20]
        for te in [1.0, 10.0, 100.0]
            for B in [0.01, 0.1, 1.0]
                println("$(ne),$(te),$(B),$(debye_length(ne, te)),$(plasma_frequency_hz(ne)),$(cyclotron_frequency_hz(B)),$(larmor_radius(B, 1.0e5))")
            end
        end
    end
end

main()

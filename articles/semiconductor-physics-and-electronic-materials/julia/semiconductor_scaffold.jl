# Semiconductor Scaffold
#
# This Julia workflow computes thermal voltage, intrinsic carrier concentration,
# conductivity, and ideal diode current for selected values.

const Q = 1.602176634e-19
const KB = 1.380649e-23
const KB_EV_K = 8.617333262145e-5

function thermal_voltage(T)
    return KB * T / Q
end

function intrinsic_carrier(Eg_eV, Nc_cm3, Nv_cm3, T)
    return sqrt(Nc_cm3 * Nv_cm3) * exp(-Eg_eV / (2.0 * KB_EV_K * T))
end

function conductivity(n_cm3, mu_cm2_v_s)
    n_m3 = n_cm3 * 1.0e6
    mu_m2_v_s = mu_cm2_v_s * 1.0e-4
    return Q * n_m3 * mu_m2_v_s
end

function diode_current(V, Is, n, T)
    Vt = thermal_voltage(T)
    return Is * (exp(V / (n * Vt)) - 1.0)
end

function main()
    println("quantity,value,unit")
    println("thermal_voltage_300K,$(thermal_voltage(300.0)),V")
    println("silicon_like_ni_300K,$(intrinsic_carrier(1.12, 2.8e19, 1.04e19, 300.0)),cm^-3")
    println("conductivity_1e16_1000,$(conductivity(1.0e16, 1000.0)),S/m")

    println("voltage_v,current_a")
    for V in -0.2:0.1:0.8
        println("$(V),$(diode_current(V, 1.0e-12, 1.0, 300.0))")
    end
end

main()

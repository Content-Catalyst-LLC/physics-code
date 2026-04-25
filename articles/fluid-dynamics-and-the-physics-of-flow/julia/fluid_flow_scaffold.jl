# Fluid Flow Scaffold
#
# This Julia workflow computes Reynolds number and kinematic viscosity.

function reynolds_number(rho, v, l, mu)
    return rho * v * l / mu
end

function classify_reynolds(re)
    if re < 2300.0
        return "laminar"
    elseif re <= 4000.0
        return "transitional"
    else
        return "turbulent"
    end
end

function main()
    cases = [
        ("slow_water_small_pipe", 1000.0, 0.02, 0.01, 1.0e-3),
        ("moderate_water_pipe", 1000.0, 0.50, 0.05, 1.0e-3),
        ("fast_water_pipe", 1000.0, 2.00, 0.10, 1.0e-3),
        ("viscous_oil_pipe", 850.0, 0.20, 0.04, 0.20),
        ("microfluidic_channel", 1000.0, 0.001, 0.0001, 1.0e-3)
    ]

    println("case_id,density_kg_per_m3,velocity_m_per_s,length_m,viscosity_pa_s,reynolds_number,flow_regime")

    for (case_id, rho, v, l, mu) in cases
        re = reynolds_number(rho, v, l, mu)
        println("$(case_id),$(rho),$(v),$(l),$(mu),$(re),$(classify_reynolds(re))")
    end
end

main()

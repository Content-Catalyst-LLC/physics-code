# Critical Phenomena Scaffold
#
# This Julia workflow computes Landau free energy and simple scaling laws.

function landau_free_energy(m, temperature, critical_temperature, a, b)
    return a * (temperature - critical_temperature) * m^2 + b * m^4
end

function order_parameter_scale(reduced_temperature, beta_exponent)
    if reduced_temperature >= 0
        return NaN
    end
    return abs(reduced_temperature)^beta_exponent
end

function susceptibility_scale(reduced_temperature, gamma_exponent)
    return abs(reduced_temperature)^(-gamma_exponent)
end

function correlation_length_scale(reduced_temperature, nu_exponent)
    return abs(reduced_temperature)^(-nu_exponent)
end

function main()
    println("quantity,value")
    println("landau_f_m0p5_T0p8,$(landau_free_energy(0.5, 0.8, 1.0, 1.0, 1.0))")
    println("mean_field_m_t_minus_0p1,$(order_parameter_scale(-0.1, 0.5))")
    println("mean_field_chi_t_0p1,$(susceptibility_scale(0.1, 1.0))")
    println("mean_field_xi_t_0p1,$(correlation_length_scale(0.1, 0.5))")
end

main()

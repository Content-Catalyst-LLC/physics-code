# Measurement Model Uncertainty Scaffold
#
# This Julia workflow evaluates a pendulum measurement model:
#
#   g = 4*pi^2*L / T^2
#
# and computes first-order propagated uncertainty.

function estimate_g(length_m, period_s)
    return 4.0 * pi^2 * length_m / period_s^2
end

function propagated_uncertainty(length_m, u_length_m, period_s, u_period_s)
    dg_dlength = 4.0 * pi^2 / period_s^2
    dg_dperiod = -8.0 * pi^2 * length_m / period_s^3

    return sqrt((dg_dlength * u_length_m)^2 + (dg_dperiod * u_period_s)^2)
end

function main()
    length_m = 0.75
    u_length_m = 0.001
    period_s = 1.741
    u_period_s = 0.005

    g_estimate = estimate_g(length_m, period_s)
    u_g = propagated_uncertainty(length_m, u_length_m, period_s, u_period_s)

    println("length_m,u_length_m,period_s,u_period_s,g_estimate_m_s2,u_g_m_s2")
    println("$(length_m),$(u_length_m),$(period_s),$(u_period_s),$(g_estimate),$(u_g)")
end

main()

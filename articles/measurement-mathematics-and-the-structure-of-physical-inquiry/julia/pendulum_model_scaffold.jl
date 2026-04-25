# Pendulum Model Scaffold
#
# This Julia workflow estimates gravitational acceleration from a pendulum:
#
#   g = 4*pi^2*L / T^2
#
# and compares small-angle periods across lengths.

function small_angle_period(length_m, gravity_m_per_s2)
    return 2.0 * pi * sqrt(length_m / gravity_m_per_s2)
end

function estimate_gravity(length_m, period_s)
    return 4.0 * pi^2 * length_m / period_s^2
end

function main()
    gravity = 9.80665
    lengths = [0.25, 0.50, 0.75, 1.00, 1.50]

    println("length_m,small_angle_period_s")

    for length_m in lengths
        println("$(length_m),$(small_angle_period(length_m, gravity))")
    end

    println("\nlength_m,period_s,g_estimate_m_per_s2")
    println("0.75,1.7405,$(estimate_gravity(0.75, 1.7405))")
end

main()

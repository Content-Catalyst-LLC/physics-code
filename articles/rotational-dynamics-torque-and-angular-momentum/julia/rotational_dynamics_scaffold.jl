# Rotational Dynamics Scaffold
#
# This Julia workflow compares rolling accelerations and final speeds for
# common rolling-body inertia factors.

const G = 9.80665

function rolling_acceleration(beta, incline_angle_rad)
    return G * sin(incline_angle_rad) / (1.0 + beta)
end

function rolling_final_speed(beta, height_drop_m)
    return sqrt(2.0 * G * height_drop_m / (1.0 + beta))
end

function main()
    bodies = [
        ("hoop", 1.0),
        ("solid_disk", 0.5),
        ("solid_sphere", 0.4),
        ("thin_spherical_shell", 2.0 / 3.0),
        ("sliding_point_mass", 0.0)
    ]

    incline_angle_rad = 20.0 * pi / 180.0
    height_drop_m = 1.0

    println("object,beta,acceleration_m_per_s2,final_speed_m_per_s")

    for (name, beta) in bodies
        a = rolling_acceleration(beta, incline_angle_rad)
        v = rolling_final_speed(beta, height_drop_m)
        println("$(name),$(beta),$(a),$(v)")
    end
end

main()

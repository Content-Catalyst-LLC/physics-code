# Projectile Force Scaffold
#
# This Julia workflow computes ideal projectile range, flight time, and
# maximum height for selected launch angles.

const G = 9.80665

function projectile_summary(v0, theta_rad)
    time_of_flight = 2.0 * v0 * sin(theta_rad) / G
    range_m = v0^2 * sin(2.0 * theta_rad) / G
    max_height = v0^2 * sin(theta_rad)^2 / (2.0 * G)

    return time_of_flight, range_m, max_height
end

function main()
    v0 = 12.0

    println("initial_speed_m_per_s,launch_angle_deg,time_of_flight_s,range_m,max_height_m")

    for angle_deg in [20.0, 30.0, 45.0, 60.0, 70.0]
        theta_rad = angle_deg * pi / 180.0
        time_of_flight, range_m, max_height = projectile_summary(v0, theta_rad)

        println("$(v0),$(angle_deg),$(time_of_flight),$(range_m),$(max_height)")
    end
end

main()

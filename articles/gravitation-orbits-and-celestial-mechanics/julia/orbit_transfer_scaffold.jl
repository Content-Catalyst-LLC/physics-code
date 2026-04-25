# Orbit Transfer Scaffold
#
# This Julia workflow computes circular speed, escape speed, and orbital period
# for selected Earth-orbit radii.

const MU_EARTH = 3.986004418e14
const EARTH_RADIUS = 6.371e6

function circular_speed(mu, r)
    return sqrt(mu / r)
end

function escape_speed(mu, r)
    return sqrt(2.0 * mu / r)
end

function orbital_period(mu, r)
    return 2.0 * pi * sqrt(r^3 / mu)
end

function main()
    altitudes = [400e3, 700e3, 20200e3, 35786e3, 60000e3]

    println("altitude_m,orbital_radius_m,circular_speed_m_per_s,escape_speed_m_per_s,period_hours")

    for altitude in altitudes
        r = EARTH_RADIUS + altitude
        vc = circular_speed(MU_EARTH, r)
        ve = escape_speed(MU_EARTH, r)
        period_hours = orbital_period(MU_EARTH, r) / 3600.0

        println("$(altitude),$(r),$(vc),$(ve),$(period_hours)")
    end
end

main()

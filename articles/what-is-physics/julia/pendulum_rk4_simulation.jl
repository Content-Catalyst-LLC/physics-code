# Pendulum RK4 Simulation
#
# This Julia workflow simulates a small-angle pendulum using a fourth-order
# Runge-Kutta method.
#
# State variables:
#   theta_rad = angular displacement in radians
#   omega_rad_per_s = angular velocity in radians per second
#
# Governing equations:
#   dtheta/dt = omega
#   domega/dt = -(g / L) * theta

function derivatives(theta_rad, omega_rad_per_s, gravity_m_per_s2, length_m)
    dtheta_dt = omega_rad_per_s
    domega_dt = -(gravity_m_per_s2 / length_m) * theta_rad
    return dtheta_dt, domega_dt
end

function rk4_step(theta_rad, omega_rad_per_s, dt_s, gravity_m_per_s2, length_m)
    k1_theta, k1_omega = derivatives(theta_rad, omega_rad_per_s, gravity_m_per_s2, length_m)

    k2_theta, k2_omega = derivatives(
        theta_rad + 0.5 * dt_s * k1_theta,
        omega_rad_per_s + 0.5 * dt_s * k1_omega,
        gravity_m_per_s2,
        length_m
    )

    k3_theta, k3_omega = derivatives(
        theta_rad + 0.5 * dt_s * k2_theta,
        omega_rad_per_s + 0.5 * dt_s * k2_omega,
        gravity_m_per_s2,
        length_m
    )

    k4_theta, k4_omega = derivatives(
        theta_rad + dt_s * k3_theta,
        omega_rad_per_s + dt_s * k3_omega,
        gravity_m_per_s2,
        length_m
    )

    next_theta = theta_rad + (dt_s / 6.0) * (k1_theta + 2.0 * k2_theta + 2.0 * k3_theta + k4_theta)
    next_omega = omega_rad_per_s + (dt_s / 6.0) * (k1_omega + 2.0 * k2_omega + 2.0 * k3_omega + k4_omega)

    return next_theta, next_omega
end

function simulate_pendulum()
    gravity_m_per_s2 = 9.80665
    length_m = 1.0
    dt_s = 0.01
    total_time_s = 10.0
    n_steps = Int(round(total_time_s / dt_s))

    theta_rad = 0.10
    omega_rad_per_s = 0.0

    println("time_s,theta_rad,omega_rad_per_s")

    for step in 0:n_steps
        time_s = step * dt_s

        if step % 10 == 0
            println("$(round(time_s, digits=4)),$(round(theta_rad, digits=8)),$(round(omega_rad_per_s, digits=8))")
        end

        theta_rad, omega_rad_per_s = rk4_step(
            theta_rad,
            omega_rad_per_s,
            dt_s,
            gravity_m_per_s2,
            length_m
        )
    end
end

simulate_pendulum()

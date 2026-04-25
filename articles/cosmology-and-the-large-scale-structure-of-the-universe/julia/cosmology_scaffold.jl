# Cosmology Scaffold
#
# This Julia workflow computes E(z), H(z), and a simple trapezoid
# comoving distance for flat Lambda-CDM.

function e_z(z, omega_m, omega_lambda)
    return sqrt(omega_m * (1.0 + z)^3 + omega_lambda)
end

function comoving_distance(zmax, h0, omega_m, omega_lambda)
    if zmax == 0.0
        return 0.0
    end

    c_km_s = 299792.458
    n_grid = 5000
    dz = zmax / (n_grid - 1)
    total = 0.0

    for i in 1:n_grid
        z = dz * (i - 1)
        weight = (i == 1 || i == n_grid) ? 0.5 : 1.0
        total += weight / e_z(z, omega_m, omega_lambda)
    end

    return (c_km_s / h0) * dz * total
end

function main()
    h0 = 67.4
    omega_m = 0.315
    omega_lambda = 0.685

    println("redshift,E_z,H_z_km_s_mpc,comoving_distance_mpc")

    for z in [0.0, 0.1, 0.5, 1.0, 2.0, 3.0, 6.0]
        ez = e_z(z, omega_m, omega_lambda)
        hz = h0 * ez
        chi = comoving_distance(z, h0, omega_m, omega_lambda)
        println("$z,$ez,$hz,$chi")
    end
end

main()

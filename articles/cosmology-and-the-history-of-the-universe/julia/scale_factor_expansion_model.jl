# Scale Factor and Expansion-Rate Scaffold
#
# This Julia workflow evaluates a simplified ΛCDM-style expansion function.
#
# H(z) = H0 * sqrt(Omega_m(1+z)^3 + Omega_r(1+z)^4 + Omega_lambda)
#
# This is educational scaffolding rather than precision cosmology.

function hubble_parameter(redshift; h0=70.0, omega_m=0.315, omega_r=0.00009, omega_lambda=0.685)
    zp1 = 1.0 + redshift
    return h0 * sqrt(omega_m * zp1^3 + omega_r * zp1^4 + omega_lambda)
end

function scale_factor(redshift)
    return 1.0 / (1.0 + redshift)
end

function main()
    redshifts = [0.0, 0.5, 1.0, 2.0, 3.0, 10.0, 100.0, 1100.0]

    println("redshift,scale_factor,hubble_parameter_km_s_mpc")

    for z in redshifts
        println("$(z),$(round(scale_factor(z), digits=8)),$(round(hubble_parameter(z), digits=6))")
    end
end

main()

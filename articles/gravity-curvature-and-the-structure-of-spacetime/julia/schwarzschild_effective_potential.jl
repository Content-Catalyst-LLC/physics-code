# Schwarzschild Effective Potential Scaffold
#
# This Julia workflow evaluates a dimensionless educational scaffold for
# timelike Schwarzschild effective potential behavior:
#
#   V_eff(r) = (1 - r_s/r) * (1 + L^2/r^2)
#
# with r measured in units of r_s.
#
# This is not a full geodesic solver.

function effective_potential(radius_over_rs; angular_momentum=4.0)
    return (1.0 - 1.0 / radius_over_rs) * (1.0 + angular_momentum^2 / radius_over_rs^2)
end

function main()
    println("radius_over_rs,effective_potential")

    for radius_over_rs in range(1.05, stop=30.0, length=200)
        println("$(radius_over_rs),$(effective_potential(radius_over_rs))")
    end
end

main()

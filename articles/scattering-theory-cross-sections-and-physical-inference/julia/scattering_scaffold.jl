# Scattering Scaffold
#
# Computes the analytic total cross section for:
#
# d sigma / d Omega = sigma0 * (1 + alpha cos^2 theta)

function total_cross_section(sigma0, alpha)
    return 4.0 * pi * sigma0 * (1.0 + alpha / 3.0)
end

function main()
    cases = [
        (1.0, 0.0),
        (1.0, 0.5),
        (1.0, 1.0),
        (2.0, 1.0),
        (0.5, 2.0)
    ]

    println("sigma0,alpha,total_cross_section")

    for (sigma0, alpha) in cases
        println("$sigma0,$alpha,$(total_cross_section(sigma0, alpha))")
    end
end

main()

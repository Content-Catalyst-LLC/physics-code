# Scientific Machine Learning Scaffold
#
# Computes heat-equation residual for a manufactured solution:
#
# u(x,t) = exp(-D*pi^2*t) sin(pi*x)
#
# using analytic derivatives.

function heat_solution(x, t, D)
    return exp(-D * pi^2 * t) * sin(pi * x)
end

function residual_analytic(x, t, D)
    u_t = -D * pi^2 * exp(-D * pi^2 * t) * sin(pi * x)
    u_xx = -pi^2 * exp(-D * pi^2 * t) * sin(pi * x)
    return u_t - D * u_xx
end

function main()
    D = 0.1

    println("x,t,u,residual")

    for x in 0.1:0.2:0.9
        for t in 0.0:0.25:1.0
            u = heat_solution(x, t, D)
            r = residual_analytic(x, t, D)
            println("$x,$t,$u,$r")
        end
    end
end

main()

# Nonlinear Dynamics Scaffold
#
# This Julia workflow iterates the logistic map for selected r values.

function logistic_step(r, x)
    return r * x * (1.0 - x)
end

function main()
    r_values = [2.8, 3.2, 3.5, 3.9]
    n_iter = 50

    println("r,iteration,x")

    for r in r_values
        x = 0.2

        for iteration in 1:n_iter
            println("$(r),$(iteration),$(x)")
            x = logistic_step(r, x)
        end
    end
end

main()

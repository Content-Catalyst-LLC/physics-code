# Numerical Methods Scaffold
#
# Computes central-difference derivative error for sin(x).

function central_difference_sin(x, dx)
    return (sin(x + dx) - sin(x - dx)) / (2.0 * dx)
end

function main()
    x = 1.0
    exact = cos(x)

    println("dx,numeric_derivative,exact_derivative,absolute_error")

    for power in -2:-1:-16
        dx = 2.0^power
        numeric = central_difference_sin(x, dx)
        error = abs(numeric - exact)
        println("$dx,$numeric,$exact,$error")
    end
end

main()

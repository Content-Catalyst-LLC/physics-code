# Energy Landscape Scaffold
#
# This Julia workflow evaluates a one-dimensional potential-energy landscape:
#
#   U(x) = 1/2 k x^2 + a x^4
#
# and identifies accessible regions where:
#
#   E >= U(x)

function potential_energy(x, k, a)
    return 0.5 * k * x^2 + a * x^4
end

function main()
    k = 5.0
    a = 20.0
    total_energy = 0.40

    positions = range(-0.5, stop=0.5, length=1000)

    accessible_positions = Float64[]

    for x in positions
        u = potential_energy(x, k, a)

        if total_energy >= u
            push!(accessible_positions, x)
        end
    end

    println("total_energy_j,min_accessible_position_m,max_accessible_position_m,n_accessible_points")
    println("$(total_energy),$(minimum(accessible_positions)),$(maximum(accessible_positions)),$(length(accessible_positions))")
end

main()

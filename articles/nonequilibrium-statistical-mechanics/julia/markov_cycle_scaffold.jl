# Markov Cycle Scaffold
#
# Computes entropy production for a three-state cycle.

function entropy_production(k_plus, k_minus)
    current = (k_plus - k_minus) / 3.0

    if k_plus <= 0 || k_minus <= 0
        return (current, NaN, NaN)
    end

    affinity = 3.0 * log(k_plus / k_minus)
    sdot = current * affinity

    return (current, affinity, sdot)
end

function main()
    cases = [
        (1.0, 1.0),
        (1.5, 1.0),
        (3.0, 1.0),
        (10.0, 1.0),
        (1.0, 3.0)
    ]

    println("k_plus,k_minus,cycle_current,affinity_kb_units,entropy_production_kb_units")

    for (k_plus, k_minus) in cases
        current, affinity, sdot = entropy_production(k_plus, k_minus)
        println("$k_plus,$k_minus,$current,$affinity,$sdot")
    end
end

main()

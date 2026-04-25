# Topological Band Scaffold
#
# Computes the expected SSH phase label from t1 and t2.

function ssh_phase(t1, t2)
    if abs(t2) > abs(t1)
        return "topological_scaffold"
    elseif abs(t2) == abs(t1)
        return "transition_scaffold"
    else
        return "trivial_scaffold"
    end
end

function main()
    cases = [
        (1.0, 0.5),
        (1.0, 1.5),
        (1.0, 1.0),
        (0.3, 1.5),
        (1.5, 0.3)
    ]

    println("t1,t2,phase_label")

    for (t1, t2) in cases
        println("$t1,$t2,$(ssh_phase(t1, t2))")
    end
end

main()

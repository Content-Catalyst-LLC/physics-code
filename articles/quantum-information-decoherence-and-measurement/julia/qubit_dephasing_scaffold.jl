# Qubit Dephasing Scaffold
#
# This Julia workflow computes coherence decay:
#
#   rho_01(t) = rho_01(0) exp(-t/T2)

function binary_entropy(p)
    if p <= 0.0 || p >= 1.0
        return 0.0
    end
    return -p * log2(p) - (1.0 - p) * log2(1.0 - p)
end

function main()
    t2 = 5.0e-6

    println("time_microseconds,coherence_abs,purity_approx,binary_entropy_bits")

    for i in 0:25
        t = i * 1.0e-6
        coherence = 0.5 * exp(-t / t2)

        # For dephased |+>, eigenvalues are 1/2 +/- coherence.
        lambda_plus = 0.5 + coherence
        lambda_minus = 0.5 - coherence
        entropy = 0.0

        if lambda_plus > 0
            entropy -= lambda_plus * log2(lambda_plus)
        end

        if lambda_minus > 0
            entropy -= lambda_minus * log2(lambda_minus)
        end

        purity = lambda_plus^2 + lambda_minus^2

        println("$(t * 1.0e6),$(coherence),$(purity),$(entropy)")
    end
end

main()

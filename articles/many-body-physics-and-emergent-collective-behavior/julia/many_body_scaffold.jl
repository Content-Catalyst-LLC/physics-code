# Many-Body Physics Scaffold
#
# This Julia workflow computes Hilbert-space dimensions and occupation values.

function hilbert_dimension(local_dimension, n_sites)
    return local_dimension^n_sites
end

function fermi_occupation(energy, mu, temperature, k_b)
    return 1.0 / (exp((energy - mu) / (k_b * temperature)) + 1.0)
end

function bose_occupation(energy, mu, temperature, k_b)
    if energy <= mu
        return NaN
    end
    return 1.0 / (exp((energy - mu) / (k_b * temperature)) - 1.0)
end

function main()
    k_b_ev_k = 8.617333262e-5

    println("quantity,value")
    println("spin_half_dimension_20,$(hilbert_dimension(2, 20))")
    println("spin_half_dimension_30,$(hilbert_dimension(2, 30))")
    println("fermi_E0_mu0_T300,$(fermi_occupation(0.0, 0.0, 300.0, k_b_ev_k))")
    println("bose_E0p01_mu0_T300,$(bose_occupation(0.01, 0.0, 300.0, k_b_ev_k))")
end

main()

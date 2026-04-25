# Rapidity and Boost Composition
#
# This Julia workflow illustrates:
#
#   beta = tanh(eta)
#   gamma = cosh(eta)
#
# and collinear boost composition by rapidity addition.

function gamma_from_beta(beta)
    if abs(beta) >= 1.0
        error("beta must satisfy |beta| < 1")
    end

    return 1.0 / sqrt(1.0 - beta^2)
end

function rapidity_from_beta(beta)
    if abs(beta) >= 1.0
        error("beta must satisfy |beta| < 1")
    end

    return atanh(beta)
end

function beta_from_rapidity(eta)
    return tanh(eta)
end

function main()
    println("beta,rapidity,gamma,beta_recovered")

    for beta in [0.0, 0.1, 0.3, 0.5, 0.8, 0.9, 0.99]
        eta = rapidity_from_beta(beta)
        gamma = gamma_from_beta(beta)
        beta_recovered = beta_from_rapidity(eta)

        println("$(beta),$(eta),$(gamma),$(beta_recovered)")
    end

    println("\nbeta_a,beta_b,eta_sum,beta_composed")

    for beta_a in [0.3, 0.5, 0.8]
        for beta_b in [0.1, 0.3, 0.5]
            eta_sum = rapidity_from_beta(beta_a) + rapidity_from_beta(beta_b)
            beta_composed = beta_from_rapidity(eta_sum)

            println("$(beta_a),$(beta_b),$(eta_sum),$(beta_composed)")
        end
    end
end

main()

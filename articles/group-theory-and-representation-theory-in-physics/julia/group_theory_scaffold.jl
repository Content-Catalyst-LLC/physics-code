# Group Theory Scaffold
#
# This Julia workflow computes SU(2) spin dimensions and
# C3 character inner products.

function spin_dimension(j)
    return Int(2*j + 1)
end

function c3_inner_product(character_a, character_b)
    total = 0.0 + 0.0im

    for i in eachindex(character_a)
        total += conj(character_a[i]) * character_b[i]
    end

    return total / length(character_a)
end

function main()
    omega = exp(2im * pi / 3)

    chi0 = [1.0 + 0im, 1.0 + 0im, 1.0 + 0im]
    chi1 = [1.0 + 0im, omega, omega^2]
    chi2 = [1.0 + 0im, omega^2, omega]

    println("quantity,value")
    println("spin_half_dimension,$(spin_dimension(0.5))")
    println("spin_one_dimension,$(spin_dimension(1.0))")
    println("spin_two_dimension,$(spin_dimension(2.0))")
    println("c3_inner_chi0_chi0,$(c3_inner_product(chi0, chi0))")
    println("c3_inner_chi0_chi1,$(c3_inner_product(chi0, chi1))")
    println("c3_inner_chi1_chi2,$(c3_inner_product(chi1, chi2))")
end

main()

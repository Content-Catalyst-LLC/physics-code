# QFT Scaffold
#
# This Julia workflow computes harmonic oscillator energies,
# Bose occupation, and scalar-field dispersion in natural units.

function oscillator_energy(hbar, omega, n)
    return hbar * omega * (n + 0.5)
end

function bose_occupation(beta, hbar, omega)
    return 1.0 / (exp(beta * hbar * omega) - 1.0)
end

function scalar_omega(k, mass)
    return sqrt(k^2 + mass^2)
end

function main()
    println("quantity,value")
    println("oscillator_E0,$(oscillator_energy(1.0, 2.0, 0))")
    println("oscillator_E1,$(oscillator_energy(1.0, 2.0, 1))")
    println("bose_occupation_beta1_omega2,$(bose_occupation(1.0, 1.0, 2.0))")
    println("scalar_omega_k3_m1,$(scalar_omega(3.0, 1.0))")
end

main()

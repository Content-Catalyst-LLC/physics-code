# Isotope Binding and Decay Scaffold
#
# This Julia workflow computes:
#
#   t_1/2 = ln(2) / lambda
#   N(t) = N0 exp(-lambda t)
#   B = delta_m_u * 931.49410242
#
# It is educational scaffolding for nuclear decay and binding-energy
# intuition.

const U_TO_MEV = 931.49410242

function half_life(lambda)
    return log(2.0) / lambda
end

function undecayed_nuclei(n0, lambda, time)
    return n0 * exp(-lambda * time)
end

function helium4_binding_energy()
    proton_mass_u = 1.007276466621
    neutron_mass_u = 1.00866491595
    helium4_nuclear_mass_u = 4.001506179127

    free_mass = 2.0 * proton_mass_u + 2.0 * neutron_mass_u
    delta_m = free_mass - helium4_nuclear_mass_u
    binding_energy = delta_m * U_TO_MEV

    return delta_m, binding_energy, binding_energy / 4.0
end

function main()
    lambda = 0.22
    n0 = 1000.0

    println("time,undecayed_nuclei,half_life")

    for time in range(0.0, stop=12.0, length=25)
        println("$(round(time, digits=6)),$(round(undecayed_nuclei(n0, lambda, time), digits=6)),$(round(half_life(lambda), digits=6))")
    end

    delta_m, binding, binding_per_nucleon = helium4_binding_energy()

    println("\nhelium4_mass_defect_u,binding_energy_mev,binding_energy_per_nucleon_mev")
    println("$(round(delta_m, digits=8)),$(round(binding, digits=8)),$(round(binding_per_nucleon, digits=8))")
end

main()

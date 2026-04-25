# Higgs and Yukawa Scaffold
#
# This Julia workflow computes:
#
#   y_f = sqrt(2) m_f / v
#
# and evaluates a schematic one-dimensional Higgs-like potential:
#
#   V(phi) = mu2 * phi^2 + lambda * phi^4
#
# This is an educational scaffold, not a full Standard Model calculation.

function yukawa_coupling(mass_gev; higgs_vev_gev=246.0)
    return sqrt(2.0) * mass_gev / higgs_vev_gev
end

function higgs_like_potential(phi; mu2=-1.0, lambda=0.5)
    return mu2 * phi^2 + lambda * phi^4
end

function main()
    particles = [
        ("electron", 0.000511),
        ("muon", 0.10566),
        ("tau", 1.77686),
        ("charm", 1.27),
        ("bottom", 4.18),
        ("top", 172.61)
    ]

    println("particle,mass_gev,yukawa_coupling")

    for (particle, mass) in particles
        println("$(particle),$(mass),$(yukawa_coupling(mass))")
    end

    println("\nphi,potential")

    for phi in range(-3.0, stop=3.0, length=61)
        println("$(round(phi, digits=6)),$(round(higgs_like_potential(phi), digits=8))")
    end
end

main()

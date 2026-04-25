# Photon Energy and Bohr Levels
#
# This Julia workflow computes:
#
#   E = h*c/lambda
#   E_n = -13.6/n^2
#
# for introductory atomic spectroscopy and hydrogen-like energy levels.

const H = 6.62607015e-34
const C = 299792458.0
const JOULE_PER_EV = 1.602176634e-19

function photon_energy_ev(wavelength_nm)
    wavelength_m = wavelength_nm * 1.0e-9
    energy_j = H * C / wavelength_m
    return energy_j / JOULE_PER_EV
end

function bohr_energy_ev(n)
    return -13.6 / (n^2)
end

function main()
    println("line,wavelength_nm,energy_ev")

    lines = [
        ("H_alpha", 656.3),
        ("H_beta", 486.1),
        ("H_gamma", 434.0),
        ("H_delta", 410.2)
    ]

    for (line, wavelength_nm) in lines
        println("$(line),$(wavelength_nm),$(round(photon_energy_ev(wavelength_nm), digits=8))")
    end

    println("\nn,bohr_energy_ev")

    for n in 1:8
        println("$(n),$(round(bohr_energy_ev(n), digits=8))")
    end
end

main()

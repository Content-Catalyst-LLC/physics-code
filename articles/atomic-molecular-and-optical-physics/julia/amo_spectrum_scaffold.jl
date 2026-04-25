# AMO Spectrum Scaffold
#
# This Julia workflow computes selected hydrogen transition wavelengths.

const RYDBERG_HYDROGEN = 1.096775834e7
const HC_EV_NM = 1239.841984

function wavelength_nm(n_lower, n_upper)
    inverse_wavelength_m = RYDBERG_HYDROGEN * (1.0 / n_lower^2 - 1.0 / n_upper^2)
    return (1.0 / inverse_wavelength_m) * 1.0e9
end

function photon_energy_ev(lambda_nm)
    return HC_EV_NM / lambda_nm
end

function main()
    println("series,n_lower,n_upper,wavelength_nm,photon_energy_ev")

    series = Dict("Lyman" => 1, "Balmer" => 2, "Paschen" => 3)

    for (name, n_lower) in series
        for n_upper in (n_lower + 1):(n_lower + 6)
            lambda_nm = wavelength_nm(n_lower, n_upper)
            energy_ev = photon_energy_ev(lambda_nm)

            println("$(name),$(n_lower),$(n_upper),$(lambda_nm),$(energy_ev)")
        end
    end
end

main()

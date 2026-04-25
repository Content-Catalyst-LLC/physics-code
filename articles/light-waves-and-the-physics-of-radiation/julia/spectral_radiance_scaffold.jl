# Spectral Radiance Scaffold
#
# This Julia workflow evaluates Planck spectral radiance:
#
#   B_lambda(T) = (2 h c^2 / lambda^5) / [exp(h c / (lambda k_B T)) - 1]
#
# and estimates Wien peak wavelength:
#
#   lambda_max = b / T

const H = 6.62607015e-34
const C = 299792458.0
const KB = 1.380649e-23
const WIEN_B = 2.897771955e-3
const SIGMA = 5.670374419e-8

function planck_lambda(wavelength_m, temperature_k)
    numerator = 2.0 * H * C^2
    exponent = H * C / (wavelength_m * KB * temperature_k)
    denominator = wavelength_m^5 * (exp(exponent) - 1.0)

    return numerator / denominator
end

function main()
    println("temperature_k,wien_peak_nm,stefan_boltzmann_exitance_w_m2")

    for temperature_k in [3000.0, 4500.0, 5800.0, 6000.0, 10000.0]
        peak_nm = WIEN_B / temperature_k * 1.0e9
        exitance = SIGMA * temperature_k^4

        println("$(temperature_k),$(peak_nm),$(exitance)")
    end

    println("\nwavelength_nm,temperature_k,spectral_radiance")

    for wavelength_nm in range(100.0, stop=3000.0, length=30)
        wavelength_m = wavelength_nm * 1.0e-9
        println("$(wavelength_nm),5800.0,$(planck_lambda(wavelength_m, 5800.0))")
    end
end

main()

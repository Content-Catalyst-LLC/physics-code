# Climate Response Scaffold
#
# This Julia workflow computes absorbed shortwave radiation, effective
# emission temperature, approximate CO2 forcing, and equilibrium warming.

const SOLAR_CONSTANT = 1361.0
const SIGMA_SB = 5.670374419e-8
const CO2_REFERENCE = 280.0

function absorbed_shortwave(albedo)
    return SOLAR_CONSTANT * (1.0 - albedo) / 4.0
end

function emission_temperature(albedo)
    return (absorbed_shortwave(albedo) / SIGMA_SB)^(1.0 / 4.0)
end

function co2_forcing(co2_ppm)
    return 5.35 * log(co2_ppm / CO2_REFERENCE)
end

function main()
    println("albedo,feedback_w_m2_k,co2_ppm,asr_w_m2,te_k,forcing_w_m2,equilibrium_warming_k")

    for albedo in [0.25, 0.30, 0.35]
        for feedback in [0.8, 1.2, 1.6]
            for co2 in [280.0, 420.0, 560.0, 700.0]
                forcing = co2_forcing(co2)
                warming = forcing / feedback
                println("$(albedo),$(feedback),$(co2),$(absorbed_shortwave(albedo)),$(emission_temperature(albedo)),$(forcing),$(warming)")
            end
        end
    end
end

main()

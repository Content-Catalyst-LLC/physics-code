# Order Parameter Scaffold
#
# Computes uniform Ginzburg-Landau equilibrium amplitude below Tc.

function equilibrium_amplitude(temperature, critical_temperature, alpha0, beta)
    alpha = alpha0 * (temperature - critical_temperature)

    if alpha < 0
        return sqrt(-alpha / beta)
    else
        return 0.0
    end
end

function main()
    critical_temperature = 9.2
    alpha0 = 1.0
    beta = 1.0

    println("temperature_k,equilibrium_amplitude")

    for temperature in 2.0:0.5:14.0
        amp = equilibrium_amplitude(temperature, critical_temperature, alpha0, beta)
        println("$temperature,$amp")
    end
end

main()

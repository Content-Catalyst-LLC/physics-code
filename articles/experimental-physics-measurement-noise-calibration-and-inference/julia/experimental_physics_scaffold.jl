# Experimental Physics Scaffold
#
# This Julia workflow computes combined uncertainty, expanded uncertainty,
# signal-to-noise ratio, and resistance uncertainty.

function combined_uncertainty(components)
    return sqrt(sum(x -> x^2, components))
end

function expanded_uncertainty(uc, k)
    return k * uc
end

function snr_db(signal_rms, noise_rms)
    return 20.0 * log10(signal_rms / noise_rms)
end

function resistance_uncertainty(voltage, u_voltage, current, u_current)
    resistance = voltage / current
    relative = sqrt((u_voltage / voltage)^2 + (u_current / current)^2)
    return resistance, resistance * relative
end

function main()
    resistance, u_resistance = resistance_uncertainty(10.0, 0.02, 2.0, 0.005)

    println("quantity,value")
    println("combined_uncertainty_example,$(combined_uncertainty([0.02, 0.01, 0.005]))")
    println("expanded_uncertainty_k2_example,$(expanded_uncertainty(0.02, 2.0))")
    println("snr_db_example,$(snr_db(1.414213562, 0.25))")
    println("resistance_ohm,$resistance")
    println("resistance_uncertainty_ohm,$u_resistance")
end

main()

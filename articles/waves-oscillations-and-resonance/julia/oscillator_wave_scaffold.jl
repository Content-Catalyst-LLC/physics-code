# Oscillator and Wave Scaffold
#
# This Julia workflow computes oscillator natural frequency and standing-wave
# frequencies for a fixed string.

function natural_angular_frequency(k, m)
    return sqrt(k / m)
end

function standing_wave_frequency(n, wave_speed, length)
    return n * wave_speed / (2.0 * length)
end

function main()
    mass_kg = 1.0
    spring_constant = 25.0
    omega0 = natural_angular_frequency(spring_constant, mass_kg)

    println("oscillator,mass_kg,spring_constant_n_per_m,omega0_rad_per_s,frequency_hz")
    println("base,$(mass_kg),$(spring_constant),$(omega0),$(omega0/(2*pi))")

    wave_speed = 120.0
    length = 0.65

    println("\nmode,wave_speed_m_per_s,length_m,frequency_hz")

    for n in 1:8
        println("$(n),$(wave_speed),$(length),$(standing_wave_frequency(n, wave_speed, length))")
    end
end

main()

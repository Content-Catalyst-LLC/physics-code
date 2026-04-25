# Numerical Methods Scaffold
#
# This Julia workflow computes harmonic oscillator scaling and a simple
# explicit Euler table.

const MASS_KG = 1.0
const SPRING_CONSTANT = 25.0
const OMEGA0 = sqrt(SPRING_CONSTANT / MASS_KG)
const DT = 0.01

function main()
    x = 1.0
    v = 0.0

    println("step,time_s,displacement_m,velocity_m_per_s,total_energy_j")

    for step in 0:100
        time = step * DT
        energy = 0.5 * MASS_KG * v^2 + 0.5 * SPRING_CONSTANT * x^2

        println("$(step),$(time),$(x),$(v),$(energy)")

        a = -OMEGA0^2 * x
        x = x + DT * v
        v = v + DT * a
    end
end

main()

# Reversible Cycle Scaffold
#
# This Julia workflow computes Carnot efficiency and ideal-gas isothermal
# work for selected reservoir temperatures and volume ratios.

const R = 8.314462618

function carnot_efficiency(th, tc)
    if th <= tc
        error("Hot reservoir temperature must exceed cold reservoir temperature")
    end

    return 1.0 - tc / th
end

function isothermal_work(n, temperature_k, v1, v2)
    return n * R * temperature_k * log(v2 / v1)
end

function main()
    println("hot_temperature_k,cold_temperature_k,carnot_efficiency")

    for th in [500.0, 700.0, 900.0, 1200.0]
        for tc in [250.0, 300.0, 350.0]
            if th > tc
                println("$(th),$(tc),$(carnot_efficiency(th, tc))")
            end
        end
    end

    println("\namount_mol,temperature_k,v1_m3,v2_m3,isothermal_work_j")

    for ratio in [1.5, 2.0, 4.0]
        v1 = 0.02
        v2 = ratio * v1
        println("1.0,300.0,$(v1),$(v2),$(isothermal_work(1.0, 300.0, v1, v2))")
    end
end

main()

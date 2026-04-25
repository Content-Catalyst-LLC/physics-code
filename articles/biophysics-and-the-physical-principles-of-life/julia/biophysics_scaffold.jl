# Biophysics Scaffold
#
# This Julia workflow computes diffusion time, binding occupancy,
# Nernst potential, and Michaelis-Menten rate.

const R = 8.314462618
const F = 96485.33212

function diffusion_time(length_um, diffusion_um2_s, dimension)
    return length_um^2 / (2.0 * dimension * diffusion_um2_s)
end

function binding_occupancy(ligand_m, kd_m)
    return ligand_m / (kd_m + ligand_m)
end

function nernst_potential(cout_mM, cin_mM, z, temperature_k)
    return (R * temperature_k / (z * F)) * log(cout_mM / cin_mM)
end

function michaelis_menten(substrate, vmax, km)
    return vmax * substrate / (km + substrate)
end

function main()
    println("quantity,value,unit")
    println("diffusion_time_cell,$(diffusion_time(10.0, 10.0, 1)),s")
    println("binding_occupancy_at_KD,$(binding_occupancy(1.0e-6, 1.0e-6)),dimensionless")
    println("potassium_nernst_310K,$(nernst_potential(5.0, 140.0, 1, 310.15)),V")
    println("enzyme_rate_at_KM,$(michaelis_menten(50.0, 100.0, 50.0)),uM/s")
end

main()

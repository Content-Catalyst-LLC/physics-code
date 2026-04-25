program example_simulation
  implicit none

  real :: mass_kg
  real :: velocity_m_per_s
  real :: kinetic_energy_j

  mass_kg = 2.0
  velocity_m_per_s = 4.0
  kinetic_energy_j = 0.5 * mass_kg * velocity_m_per_s**2

  print *, "KE =", kinetic_energy_j, "J"
end program example_simulation

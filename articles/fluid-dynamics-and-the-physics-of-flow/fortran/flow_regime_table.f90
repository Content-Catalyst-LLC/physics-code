! Flow Regime Table
!
! This Fortran workflow computes:
!
!   Re = rho v L / mu

program flow_regime_table
  implicit none

  integer :: i
  character(len=28), dimension(5) :: case_names
  real(8), dimension(5) :: rho_values
  real(8), dimension(5) :: velocity_values
  real(8), dimension(5) :: length_values
  real(8), dimension(5) :: viscosity_values
  real(8) :: re

  case_names = (/ "slow_water_small_pipe     ", "moderate_water_pipe      ", &
                  "fast_water_pipe          ", "viscous_oil_pipe         ", &
                  "microfluidic_channel     " /)

  rho_values = (/1000.0d0, 1000.0d0, 1000.0d0, 850.0d0, 1000.0d0/)
  velocity_values = (/0.02d0, 0.50d0, 2.00d0, 0.20d0, 0.001d0/)
  length_values = (/0.01d0, 0.05d0, 0.10d0, 0.04d0, 0.0001d0/)
  viscosity_values = (/1.0d-3, 1.0d-3, 1.0d-3, 0.20d0, 1.0d-3/)

  print *, "case_id,density_kg_per_m3,velocity_m_per_s,length_m,viscosity_pa_s,reynolds_number"

  do i = 1, size(rho_values)
     re = rho_values(i) * velocity_values(i) * length_values(i) / viscosity_values(i)

     print '(A,A,F12.4,A,F12.6,A,F12.8,A,ES14.6,A,F14.6)', &
       trim(case_names(i)), ",", rho_values(i), ",", velocity_values(i), ",", &
       length_values(i), ",", viscosity_values(i), ",", re
  end do

end program flow_regime_table

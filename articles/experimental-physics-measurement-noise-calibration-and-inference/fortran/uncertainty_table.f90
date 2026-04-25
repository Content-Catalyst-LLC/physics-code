! Uncertainty Table
!
! This Fortran workflow computes root-sum-square uncertainty
! and resistance uncertainty for R = V/I.

program uncertainty_table
  implicit none

  real(8) :: components(3)
  real(8) :: combined
  real(8) :: voltage
  real(8) :: u_voltage
  real(8) :: current
  real(8) :: u_current
  real(8) :: resistance
  real(8) :: relative_uncertainty
  real(8) :: u_resistance

  components = (/0.02d0, 0.01d0, 0.005d0/)
  combined = sqrt(sum(components**2))

  voltage = 10.0d0
  u_voltage = 0.02d0
  current = 2.0d0
  u_current = 0.005d0

  resistance = voltage / current
  relative_uncertainty = sqrt((u_voltage / voltage)**2 + (u_current / current)**2)
  u_resistance = resistance * relative_uncertainty

  print *, "quantity,value"
  print '(A,F14.8)', "combined_uncertainty,", combined
  print '(A,F14.8)', "expanded_uncertainty_k2,", 2.0d0 * combined
  print '(A,F14.8)', "resistance_ohm,", resistance
  print '(A,F14.8)', "resistance_uncertainty_ohm,", u_resistance

end program uncertainty_table

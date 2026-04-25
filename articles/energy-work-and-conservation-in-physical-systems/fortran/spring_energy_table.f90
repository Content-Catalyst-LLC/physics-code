! Spring Energy Table
!
! This Fortran workflow computes:
!
!   U = 1/2 k x^2
!   v = x sqrt(k/m)

program spring_energy_table
  implicit none

  integer :: i
  real(8), parameter :: mass_kg = 0.50d0
  real(8), parameter :: spring_constant_n_per_m = 20.0d0
  real(8), dimension(6) :: compressions_m
  real(8) :: x
  real(8) :: spring_energy_j
  real(8) :: predicted_speed_m_per_s

  compressions_m = (/0.02d0, 0.04d0, 0.06d0, 0.08d0, 0.10d0, 0.12d0/)

  print *, "mass_kg,spring_constant_n_per_m,compression_m,spring_energy_j,predicted_speed_m_per_s"

  do i = 1, size(compressions_m)
     x = compressions_m(i)
     spring_energy_j = 0.5d0 * spring_constant_n_per_m * x**2
     predicted_speed_m_per_s = x * sqrt(spring_constant_n_per_m / mass_kg)

     print '(F10.5,A,F10.5,A,F10.5,A,ES14.6,A,F14.8)', &
       mass_kg, ",", spring_constant_n_per_m, ",", x, ",", spring_energy_j, ",", predicted_speed_m_per_s
  end do

end program spring_energy_table

! Stress-Strain Table
!
! This Fortran workflow computes:
!
!   sigma = E epsilon
!   w = 1/2 sigma epsilon

program stress_strain_table
  implicit none

  integer :: i
  real(8), parameter :: youngs_modulus_pa = 200.0d9
  real(8), dimension(6) :: strain_values
  real(8) :: stress_pa
  real(8) :: energy_density

  strain_values = (/0.0000d0, 0.0005d0, 0.0010d0, 0.0015d0, 0.0020d0, 0.0025d0/)

  print *, "strain,stress_mpa,elastic_energy_density_j_per_m3"

  do i = 1, size(strain_values)
     stress_pa = youngs_modulus_pa * strain_values(i)
     energy_density = 0.5d0 * stress_pa * strain_values(i)

     print '(F12.8,A,F14.6,A,F18.6)', &
       strain_values(i), ",", stress_pa / 1.0d6, ",", energy_density
  end do

end program stress_strain_table

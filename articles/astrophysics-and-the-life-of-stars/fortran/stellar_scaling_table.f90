! Stellar Scaling Table
!
! This Fortran workflow generates a simple main-sequence scaling table:
!
!   L = M^3.5
!   t = M / L
!
! It is a classic scientific-computing style table generator.

program stellar_scaling_table
  implicit none

  integer :: i
  real(8), dimension(8) :: masses_solar
  real(8) :: mass_solar
  real(8) :: luminosity_solar
  real(8) :: lifetime_relative

  masses_solar = (/0.2d0, 0.5d0, 1.0d0, 2.0d0, 5.0d0, 10.0d0, 20.0d0, 40.0d0/)

  print *, "mass_solar,luminosity_solar_scaling,lifetime_relative_to_sun"

  do i = 1, 8
     mass_solar = masses_solar(i)
     luminosity_solar = mass_solar**3.5d0
     lifetime_relative = mass_solar / luminosity_solar

     print '(F10.4,A,ES14.6,A,ES14.6)', mass_solar, ",", luminosity_solar, ",", lifetime_relative
  end do

end program stellar_scaling_table

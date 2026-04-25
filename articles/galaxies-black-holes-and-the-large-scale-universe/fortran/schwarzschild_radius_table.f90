! Schwarzschild Radius Table
!
! This Fortran workflow computes:
!
!   r_s = 2GM / c^2
!
! for a set of black-hole masses.
!
! It is a classic scientific-computing style table generator.

program schwarzschild_radius_table
  implicit none

  integer :: i
  real(8), parameter :: G_SI = 6.67430d-11
  real(8), parameter :: C_M_PER_S = 299792458.0d0
  real(8), parameter :: M_SUN_KG = 1.98847d30
  real(8), dimension(5) :: masses_solar
  real(8) :: mass_kg
  real(8) :: radius_km

  masses_solar = (/10.0d0, 1.0d5, 4.0d6, 1.0d9, 6.5d9/)

  print *, "black_hole_mass_solar,schwarzschild_radius_km"

  do i = 1, 5
     mass_kg = masses_solar(i) * M_SUN_KG
     radius_km = (2.0d0 * G_SI * mass_kg / C_M_PER_S**2) / 1000.0d0

     print '(ES14.6,A,ES14.6)', masses_solar(i), ",", radius_km
  end do

end program schwarzschild_radius_table

! Electric Field Table
!
! This Fortran workflow computes:
!
!   E(r) = q / (4 pi epsilon0 r^2)
!   V(r) = q / (4 pi epsilon0 r)

program electric_field_table
  implicit none

  integer :: i
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: epsilon0 = 8.8541878188d-12
  real(8), parameter :: charge_c = 1.0d-9
  real(8), dimension(7) :: radii_m
  real(8) :: r
  real(8) :: electric_field
  real(8) :: electric_potential

  radii_m = (/0.02d0, 0.05d0, 0.10d0, 0.20d0, 0.40d0, 0.80d0, 1.00d0/)

  print *, "radius_m,electric_field_n_per_c,electric_potential_v"

  do i = 1, size(radii_m)
     r = radii_m(i)
     electric_field = charge_c / (4.0d0 * pi_value * epsilon0 * r**2)
     electric_potential = charge_c / (4.0d0 * pi_value * epsilon0 * r)

     print '(F10.5,A,ES18.10,A,ES18.10)', r, ",", electric_field, ",", electric_potential
  end do

end program electric_field_table

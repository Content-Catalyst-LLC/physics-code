! Schwarzschild Radius Table
!
! This Fortran workflow computes:
!
!   r_s = 2 G M / c^2
!
! for selected masses.

program schwarzschild_radius_table
  implicit none

  integer :: i
  real(8), parameter :: G = 6.67430d-11
  real(8), parameter :: c = 299792458.0d0
  real(8), dimension(3) :: masses
  character(len=20), dimension(3) :: names
  real(8) :: rs

  names = (/ "Earth              ", "Sun                ", "Ten solar masses   " /)
  masses = (/ 5.972d24, 1.98847d30, 1.98847d31 /)

  print *, "object,mass_kg,schwarzschild_radius_m,schwarzschild_radius_km"

  do i = 1, 3
     rs = 2.0d0 * G * masses(i) / (c**2)
     print '(A,A,ES18.10,A,ES18.10,A,ES18.10)', trim(names(i)), ",", masses(i), ",", rs, ",", rs / 1000.0d0
  end do

end program schwarzschild_radius_table

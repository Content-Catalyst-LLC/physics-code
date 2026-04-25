! Schwarzschild Table
!
! This Fortran workflow computes Schwarzschild radii for sample masses.

program schwarzschild_table
  implicit none

  integer :: i
  real(8), parameter :: gravitational_constant = 6.67430d-11
  real(8), parameter :: speed_of_light = 299792458.0d0
  real(8), dimension(4) :: masses
  character(len=32), dimension(4) :: names
  real(8) :: rs

  names = (/ "earth                         ", &
             "sun                           ", &
             "neutron_star_like             ", &
             "ten_solar_mass_black_hole     " /)

  masses = (/5.9722d24, 1.98847d30, 2.783858d30, 1.98847d31/)

  print *, "object,mass_kg,schwarzschild_radius_m,schwarzschild_radius_km"

  do i = 1, size(masses)
     rs = 2.0d0 * gravitational_constant * masses(i) / speed_of_light**2
     print '(A,A,E16.8,A,E16.8,A,E16.8)', trim(names(i)), ",", masses(i), ",", rs, ",", rs/1000.0d0
  end do

end program schwarzschild_table

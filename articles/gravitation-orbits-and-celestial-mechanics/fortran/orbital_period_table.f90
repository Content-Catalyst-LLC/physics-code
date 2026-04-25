! Orbital Period Table
!
! This Fortran workflow computes:
!
!   v_circ = sqrt(mu/r)
!   v_esc  = sqrt(2mu/r)
!   T      = 2*pi*sqrt(r^3/mu)

program orbital_period_table
  implicit none

  integer :: i
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: mu_earth = 3.986004418d14
  real(8), parameter :: earth_radius_m = 6.371d6
  real(8), dimension(5) :: altitudes_m
  real(8) :: altitude_m
  real(8) :: radius_m
  real(8) :: circular_speed
  real(8) :: escape_speed
  real(8) :: period_hours

  altitudes_m = (/400.0d3, 700.0d3, 20200.0d3, 35786.0d3, 60000.0d3/)

  print *, "altitude_m,orbital_radius_m,circular_speed_m_per_s,escape_speed_m_per_s,period_hours"

  do i = 1, size(altitudes_m)
     altitude_m = altitudes_m(i)
     radius_m = earth_radius_m + altitude_m
     circular_speed = sqrt(mu_earth / radius_m)
     escape_speed = sqrt(2.0d0 * mu_earth / radius_m)
     period_hours = 2.0d0 * pi_value * sqrt(radius_m**3 / mu_earth) / 3600.0d0

     print '(F14.3,A,F14.3,A,F14.6,A,F14.6,A,F14.6)', &
       altitude_m, ",", radius_m, ",", circular_speed, ",", escape_speed, ",", period_hours
  end do

end program orbital_period_table

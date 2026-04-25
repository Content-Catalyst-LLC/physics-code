! Pendulum Measurement Table
!
! This Fortran workflow computes:
!
!   T = 2*pi*sqrt(L/g)
!   g = 4*pi^2*L/T^2

program pendulum_measurement_table
  implicit none

  integer :: i
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: gravity = 9.80665d0
  real(8), dimension(5) :: lengths_m
  real(8) :: length_m
  real(8) :: period_s
  real(8) :: g_estimate

  lengths_m = (/0.25d0, 0.50d0, 0.75d0, 1.00d0, 1.50d0/)

  print *, "length_m,small_angle_period_s,g_estimate_from_period_m_per_s2"

  do i = 1, size(lengths_m)
     length_m = lengths_m(i)
     period_s = 2.0d0 * pi_value * sqrt(length_m / gravity)
     g_estimate = 4.0d0 * pi_value**2 * length_m / period_s**2

     print '(F10.5,A,F14.8,A,F14.8)', length_m, ",", period_s, ",", g_estimate
  end do

end program pendulum_measurement_table

! Pendulum Uncertainty Table
!
! This Fortran workflow computes:
!
!   g = 4*pi^2*L / T^2
!
! and first-order propagated uncertainty for a range of period
! uncertainties.

program uncertainty_table
  implicit none

  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: length_m = 0.75d0
  real(8), parameter :: u_length_m = 0.001d0
  real(8), parameter :: period_s = 1.741d0

  integer :: i
  real(8), dimension(5) :: u_period_values
  real(8) :: g_estimate
  real(8) :: dg_dlength
  real(8) :: dg_dperiod
  real(8) :: u_g

  u_period_values = (/0.001d0, 0.002d0, 0.005d0, 0.010d0, 0.020d0/)

  g_estimate = 4.0d0 * pi_value**2 * length_m / period_s**2
  dg_dlength = 4.0d0 * pi_value**2 / period_s**2
  dg_dperiod = -8.0d0 * pi_value**2 * length_m / period_s**3

  print *, "length_m,period_s,u_period_s,g_estimate_m_s2,u_g_m_s2"

  do i = 1, 5
     u_g = sqrt((dg_dlength * u_length_m)**2 + (dg_dperiod * u_period_values(i))**2)

     print '(F10.5,A,F10.5,A,F10.5,A,F14.8,A,F14.8)', &
       length_m, ",", period_s, ",", u_period_values(i), ",", g_estimate, ",", u_g
  end do

end program uncertainty_table

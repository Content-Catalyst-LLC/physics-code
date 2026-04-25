! Kinematics Table
!
! This Fortran workflow computes constant-acceleration kinematics:
!
!   v(t) = v0 + a t
!   x(t) = x0 + v0 t + 1/2 a t^2

program kinematics_table
  implicit none

  integer :: i
  real(8), parameter :: x0 = 0.0d0
  real(8), parameter :: v0 = 12.0d0
  real(8), parameter :: a = -9.80665d0
  real(8) :: t
  real(8) :: x
  real(8) :: v

  print *, "time_s,position_m,velocity_m_per_s,acceleration_m_per_s2"

  do i = 0, 20
     t = 0.1d0 * i
     x = x0 + v0 * t + 0.5d0 * a * t**2
     v = v0 + a * t

     print '(F10.4,A,F14.6,A,F14.6,A,F14.6)', t, ",", x, ",", v, ",", a
  end do

end program kinematics_table

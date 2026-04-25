! Galilean Free-Fall Table
!
! This Fortran workflow generates a simple free-fall table using:
!
!   s = 0.5 * g * t^2
!
! Fortran remains historically important in scientific computing,
! high-performance numerical physics, and legacy simulation systems.

program free_fall_table
  implicit none

  integer :: i
  real(8), parameter :: gravity_m_per_s2 = 9.80665d0
  real(8) :: time_s
  real(8) :: distance_m

  print *, "time_s,distance_m,gravity_m_per_s2"

  do i = 0, 10
     time_s = dble(i)
     distance_m = 0.5d0 * gravity_m_per_s2 * time_s**2

     print '(F8.3,A,F14.6,A,F10.5)', time_s, ",", distance_m, ",", gravity_m_per_s2
  end do

end program free_fall_table

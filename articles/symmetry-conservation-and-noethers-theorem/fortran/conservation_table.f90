! Conservation Table
!
! This Fortran workflow computes energy and angular momentum for
! sample central-force states.

program conservation_table
  implicit none

  integer :: i
  real(8), parameter :: mu = 1.0d0
  real(8), dimension(4) :: x_values
  real(8), dimension(4) :: y_values
  real(8), dimension(4) :: vx_values
  real(8), dimension(4) :: vy_values
  real(8) :: r
  real(8) :: energy
  real(8) :: angular_momentum

  x_values = (/1.0d0, 1.0d0, 2.0d0, 1.0d0/)
  y_values = (/0.0d0, 0.0d0, 0.0d0, 1.0d0/)
  vx_values = (/0.0d0, 0.0d0, 0.0d0, -0.3d0/)
  vy_values = (/0.8d0, 1.0d0, 0.5d0, 0.7d0/)

  print *, "case_id,x,y,vx,vy,energy,angular_momentum_z"

  do i = 1, 4
     r = sqrt(x_values(i)**2 + y_values(i)**2)
     energy = 0.5d0 * (vx_values(i)**2 + vy_values(i)**2) - mu / r
     angular_momentum = x_values(i) * vy_values(i) - y_values(i) * vx_values(i)

     print '(I4,A,F10.5,A,F10.5,A,F10.5,A,F10.5,A,F12.8,A,F12.8)', &
       i, ",", x_values(i), ",", y_values(i), ",", vx_values(i), ",", &
       vy_values(i), ",", energy, ",", angular_momentum
  end do

end program conservation_table

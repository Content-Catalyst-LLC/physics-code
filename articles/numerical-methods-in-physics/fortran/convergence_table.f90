! Convergence Table
!
! Computes central-difference derivative error for sin(x).

program convergence_table
  implicit none

  integer :: power
  real(8) :: x
  real(8) :: dx
  real(8) :: numeric
  real(8) :: exact
  real(8) :: error

  x = 1.0d0
  exact = cos(x)

  print *, "dx,numeric_derivative,exact_derivative,absolute_error"

  do power = -2, -20, -1
     dx = 2.0d0 ** power
     numeric = (sin(x + dx) - sin(x - dx)) / (2.0d0 * dx)
     error = abs(numeric - exact)

     print '(ES18.10,A,ES18.10,A,ES18.10,A,ES18.10)', dx, ",", numeric, ",", exact, ",", error
  end do

end program convergence_table

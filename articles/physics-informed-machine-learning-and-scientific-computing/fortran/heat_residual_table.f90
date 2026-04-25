! Heat Equation Residual Table
!
! Computes analytic residual for:
!
! u(x,t) = exp(-D*pi^2*t) sin(pi*x)

program heat_residual_table
  implicit none

  real(8), parameter :: D = 0.1d0
  real(8), parameter :: pi = 4.0d0 * atan(1.0d0)

  real(8) :: x
  real(8) :: t
  real(8) :: common
  real(8) :: u
  real(8) :: u_t
  real(8) :: u_xx
  real(8) :: residual

  print *, "x,t,u,residual"

  x = 0.1d0

  do while (x <= 0.9001d0)
     t = 0.0d0

     do while (t <= 1.0001d0)
        common = exp(-D * pi * pi * t) * sin(pi * x)
        u = common
        u_t = -D * pi * pi * common
        u_xx = -pi * pi * common
        residual = u_t - D * u_xx

        print '(F8.4,A,F8.4,A,ES16.8,A,ES16.8)', x, ",", t, ",", u, ",", residual

        t = t + 0.25d0
     end do

     x = x + 0.2d0
  end do

end program heat_residual_table

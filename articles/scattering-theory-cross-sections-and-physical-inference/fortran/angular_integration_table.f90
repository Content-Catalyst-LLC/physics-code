! Angular Integration Table
!
! Computes the analytic total cross section:
!
! sigma_total = 4 pi sigma0 (1 + alpha/3)

program angular_integration_table
  implicit none

  real(8), parameter :: pi = 4.0d0 * atan(1.0d0)
  real(8), parameter :: sigma0 = 1.0d0
  real(8) :: alpha
  real(8) :: sigma_total

  print *, "sigma0,alpha,total_cross_section"

  alpha = 0.0d0

  do while (alpha <= 2.0001d0)
     sigma_total = 4.0d0 * pi * sigma0 * (1.0d0 + alpha / 3.0d0)

     print '(F8.3,A,F8.3,A,F14.8)', sigma0, ",", alpha, ",", sigma_total

     alpha = alpha + 0.5d0
  end do

end program angular_integration_table

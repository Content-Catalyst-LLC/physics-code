! Landau and Finite-Size Table
!
! This Fortran workflow computes Landau order-parameter scaling
! and finite-size scaling estimates.

program landau_finite_size_table
  implicit none

  integer :: i
  real(8), dimension(5) :: reduced_temperatures
  real(8), dimension(5) :: sizes
  real(8) :: beta_exp
  real(8) :: gamma_exp
  real(8) :: nu_exp

  reduced_temperatures = (/-0.5d0, -0.25d0, -0.1d0, -0.05d0, -0.02d0/)
  sizes = (/8.0d0, 16.0d0, 32.0d0, 64.0d0, 128.0d0/)

  beta_exp = 0.5d0
  gamma_exp = 1.0d0
  nu_exp = 0.5d0

  print *, "section,parameter,value"

  do i = 1, size(reduced_temperatures)
     print '(A,F10.5,A,F14.8)', "order_parameter,t_", reduced_temperatures(i), ",", &
       abs(reduced_temperatures(i))**beta_exp
  end do

  do i = 1, size(sizes)
     print '(A,F10.2,A,F14.8)', "finite_size_magnetization,L_", sizes(i), ",", &
       sizes(i)**(-beta_exp/nu_exp)
     print '(A,F10.2,A,F14.8)', "finite_size_susceptibility,L_", sizes(i), ",", &
       sizes(i)**(gamma_exp/nu_exp)
  end do

end program landau_finite_size_table

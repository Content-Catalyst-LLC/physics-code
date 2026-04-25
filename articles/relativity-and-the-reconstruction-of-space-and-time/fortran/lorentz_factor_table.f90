! Lorentz Factor Table
!
! This Fortran workflow computes:
!
!   gamma = 1 / sqrt(1 - beta^2)
!
! and scaled kinetic energy:
!
!   K / (mc^2) = gamma - 1

program lorentz_factor_table
  implicit none

  integer :: i
  real(8), dimension(7) :: betas
  real(8) :: beta
  real(8) :: gamma
  real(8) :: relativistic_ke_scaled
  real(8) :: newtonian_ke_scaled

  betas = (/0.0d0, 0.1d0, 0.3d0, 0.5d0, 0.8d0, 0.9d0, 0.99d0/)

  print *, "beta,gamma,relativistic_ke_scaled,newtonian_ke_scaled"

  do i = 1, size(betas)
     beta = betas(i)
     gamma = 1.0d0 / sqrt(1.0d0 - beta**2)
     relativistic_ke_scaled = gamma - 1.0d0
     newtonian_ke_scaled = 0.5d0 * beta**2

     print '(F10.6,A,F14.8,A,F14.8,A,F14.8)', beta, ",", gamma, ",", relativistic_ke_scaled, ",", newtonian_ke_scaled
  end do

end program lorentz_factor_table

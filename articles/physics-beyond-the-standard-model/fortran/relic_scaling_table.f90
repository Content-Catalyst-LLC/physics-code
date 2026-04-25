! Relic Scaling Table
!
! This Fortran workflow generates a simple inverse relic-density-style table:
!
!   Omega ~ normalization / sigma_v
!
! It is a classic scientific-computing style table generator.

program relic_scaling_table
  implicit none

  integer :: i
  real(8), parameter :: normalization = 1.0d-26
  real(8) :: sigma_v
  real(8) :: omega

  print *, "index,sigma_v_schematic,omega_chi_h2_schematic"

  do i = 0, 8
     sigma_v = 10.0d0 ** (-28.0d0 + 0.5d0 * dble(i))
     omega = normalization / sigma_v

     print '(I4,A,ES14.6,A,ES14.6)', i, ",", sigma_v, ",", omega
  end do

end program relic_scaling_table

! Expansion Table
!
! This Fortran workflow computes E(z) and H(z) for flat Lambda-CDM.

program expansion_table
  implicit none

  real(8), parameter :: h0 = 67.4d0
  real(8), parameter :: omega_m = 0.315d0
  real(8), parameter :: omega_lambda = 0.685d0
  real(8), dimension(7) :: redshifts
  integer :: i
  real(8) :: z
  real(8) :: ez

  redshifts = (/0.0d0, 0.1d0, 0.5d0, 1.0d0, 2.0d0, 3.0d0, 6.0d0/)

  print *, "redshift,E_z,H_z_km_s_mpc,scale_factor"

  do i = 1, size(redshifts)
     z = redshifts(i)
     ez = sqrt(omega_m * (1.0d0 + z)**3 + omega_lambda)

     print '(F8.3,A,F14.8,A,F14.8,A,F14.8)', z, ",", ez, ",", h0 * ez, ",", 1.0d0 / (1.0d0 + z)
  end do

end program expansion_table

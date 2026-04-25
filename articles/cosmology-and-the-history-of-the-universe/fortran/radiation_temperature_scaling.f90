! Radiation Temperature Scaling
!
! This Fortran workflow generates a simple table for:
!
!   T(z) = T0 * (1 + z)
!
! where T0 is the present CMB temperature.
!
! This is a classic scientific-computing style table generator.

program radiation_temperature_scaling
  implicit none

  integer :: i
  real(8), parameter :: cmb_temperature_k = 2.7255d0
  real(8), dimension(8) :: redshifts
  real(8) :: z
  real(8) :: scale_factor
  real(8) :: temperature_k

  redshifts = (/0.0d0, 0.5d0, 1.0d0, 2.0d0, 3.0d0, 10.0d0, 100.0d0, 1100.0d0/)

  print *, "redshift,scale_factor,radiation_temperature_k"

  do i = 1, 8
     z = redshifts(i)
     scale_factor = 1.0d0 / (1.0d0 + z)
     temperature_k = cmb_temperature_k * (1.0d0 + z)

     print '(F12.4,A,F14.8,A,F14.6)', z, ",", scale_factor, ",", temperature_k
  end do

end program radiation_temperature_scaling

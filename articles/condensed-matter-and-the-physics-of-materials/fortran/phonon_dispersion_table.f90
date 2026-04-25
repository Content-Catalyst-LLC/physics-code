! Phonon Dispersion Table
!
! This Fortran workflow computes:
!
!   omega(k) = 2 sqrt(K/M) |sin(ka/2)|
!
! for a one-dimensional lattice model.

program phonon_dispersion_table
  implicit none

  integer :: i
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: spring_constant = 1.0d0
  real(8), parameter :: mass = 1.0d0
  real(8), parameter :: lattice_spacing = 1.0d0
  real(8) :: k
  real(8) :: omega

  print *, "k,omega"

  do i = 0, 100
     k = -pi_value + (2.0d0 * pi_value * dble(i) / 100.0d0)
     omega = 2.0d0 * sqrt(spring_constant / mass) * abs(sin(k * lattice_spacing / 2.0d0))

     print '(F14.8,A,F14.8)', k, ",", omega
  end do

end program phonon_dispersion_table

! Particle-in-a-Box Energy Table
!
! This Fortran workflow computes:
!
!   E_n = n^2*pi^2*hbar^2 / (2*m*L^2)
!
! for an electron in a one-dimensional infinite square well.

program particle_box_energy_table
  implicit none

  integer :: n
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: hbar_j_s = 1.054571817d-34
  real(8), parameter :: electron_mass_kg = 9.1093837015d-31
  real(8), parameter :: joule_per_ev = 1.602176634d-19
  real(8), parameter :: box_length_m = 1.0d-9
  real(8) :: energy_j
  real(8) :: energy_ev

  print *, "n,energy_j,energy_ev"

  do n = 1, 10
     energy_j = (dble(n*n) * pi_value**2 * hbar_j_s**2) / &
                (2.0d0 * electron_mass_kg * box_length_m**2)

     energy_ev = energy_j / joule_per_ev

     print '(I4,A,ES18.10,A,F14.8)', n, ",", energy_j, ",", energy_ev
  end do

end program particle_box_energy_table

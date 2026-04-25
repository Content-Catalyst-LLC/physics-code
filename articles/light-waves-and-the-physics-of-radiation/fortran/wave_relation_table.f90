! Wave Relation Table
!
! This Fortran workflow computes:
!
!   f = c / lambda
!   E = h f
!
! for selected wavelengths.

program wave_relation_table
  implicit none

  integer :: i
  real(8), parameter :: c = 299792458.0d0
  real(8), parameter :: h = 6.62607015d-34
  real(8), parameter :: joule_per_ev = 1.602176634d-19
  real(8), dimension(6) :: wavelengths_m
  real(8) :: frequency_hz
  real(8) :: energy_j
  real(8) :: energy_ev

  wavelengths_m = (/ 1000.0d-9, 700.0d-9, 550.0d-9, 400.0d-9, 100.0d-9, 1.0d-9 /)

  print *, "wavelength_m,frequency_hz,photon_energy_j,photon_energy_ev"

  do i = 1, size(wavelengths_m)
     frequency_hz = c / wavelengths_m(i)
     energy_j = h * frequency_hz
     energy_ev = energy_j / joule_per_ev

     print '(ES14.6,A,ES14.6,A,ES14.6,A,F14.8)', wavelengths_m(i), ",", frequency_hz, ",", energy_j, ",", energy_ev
  end do

end program wave_relation_table

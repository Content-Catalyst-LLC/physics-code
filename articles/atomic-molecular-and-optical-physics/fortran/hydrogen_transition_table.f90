! Hydrogen Transition Table
!
! This Fortran workflow computes selected hydrogen spectral wavelengths.

program hydrogen_transition_table
  implicit none

  integer :: n_lower, n_upper
  real(8), parameter :: rydberg_h = 1.096775834d7
  real(8), parameter :: hc_ev_nm = 1239.841984d0
  real(8) :: inverse_wavelength_m
  real(8) :: wavelength_nm
  real(8) :: photon_energy_ev

  print *, "n_lower,n_upper,wavelength_nm,photon_energy_ev"

  do n_lower = 1, 3
     do n_upper = n_lower + 1, n_lower + 7
        inverse_wavelength_m = rydberg_h * &
          (1.0d0 / real(n_lower * n_lower, 8) - &
           1.0d0 / real(n_upper * n_upper, 8))

        wavelength_nm = (1.0d0 / inverse_wavelength_m) * 1.0d9
        photon_energy_ev = hc_ev_nm / wavelength_nm

        print '(I8,A,I8,A,F16.8,A,F16.8)', &
          n_lower, ",", n_upper, ",", wavelength_nm, ",", photon_energy_ev
     end do
  end do

end program hydrogen_transition_table

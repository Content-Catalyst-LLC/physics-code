! Plasma Frequency Table
!
! This Fortran workflow computes Debye length and electron plasma frequency.

program plasma_frequency_table
  implicit none

  integer :: i, j
  real(8), parameter :: epsilon_0 = 8.8541878128d-12
  real(8), parameter :: e = 1.602176634d-19
  real(8), parameter :: me = 9.1093837015d-31
  real(8), parameter :: pi_value = 3.14159265358979323846d0
  real(8), dimension(4) :: densities
  real(8), dimension(3) :: temperatures_ev
  real(8) :: ne
  real(8) :: te_ev
  real(8) :: te_j
  real(8) :: lambda_d
  real(8) :: omega_pe
  real(8) :: fpe

  densities = (/1.0d14, 1.0d16, 1.0d18, 1.0d20/)
  temperatures_ev = (/1.0d0, 10.0d0, 100.0d0/)

  print *, "density_m3,temperature_ev,debye_length_m,plasma_frequency_hz"

  do i = 1, size(densities)
     do j = 1, size(temperatures_ev)
        ne = densities(i)
        te_ev = temperatures_ev(j)
        te_j = te_ev * e

        lambda_d = sqrt(epsilon_0 * te_j / (ne * e * e))
        omega_pe = sqrt(ne * e * e / (epsilon_0 * me))
        fpe = omega_pe / (2.0d0 * pi_value)

        print '(E16.8,A,F10.4,A,E16.8,A,E16.8)', &
          ne, ",", te_ev, ",", lambda_d, ",", fpe
     end do
  end do

end program plasma_frequency_table

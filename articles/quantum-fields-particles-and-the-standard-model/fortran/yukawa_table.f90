! Yukawa Coupling Table
!
! This Fortran workflow computes:
!
!   y_f = sqrt(2) m_f / v
!
! for a small set of illustrative fermion masses.

program yukawa_table
  implicit none

  integer :: i
  real(8), parameter :: higgs_vev_gev = 246.0d0
  real(8), dimension(6) :: masses
  character(len=20), dimension(6) :: particles
  real(8) :: yukawa

  particles = (/ "electron            ", "muon                ", "tau                 ", &
                 "charm               ", "bottom              ", "top                 " /)

  masses = (/0.000511d0, 0.10566d0, 1.77686d0, 1.27d0, 4.18d0, 172.61d0/)

  print *, "particle,mass_gev,yukawa_coupling"

  do i = 1, 6
     yukawa = sqrt(2.0d0) * masses(i) / higgs_vev_gev
     print '(A,A,F14.8,A,ES14.6)', trim(particles(i)), ",", masses(i), ",", yukawa
  end do

end program yukawa_table

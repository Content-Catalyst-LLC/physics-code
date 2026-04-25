! Bohr Energy Table
!
! This Fortran workflow computes:
!
!   E_n = -13.6 / n^2
!
! for introductory hydrogen-like atomic levels.

program bohr_energy_table
  implicit none

  integer :: n
  real(8) :: energy_ev

  print *, "n,energy_ev"

  do n = 1, 12
     energy_ev = -13.6d0 / dble(n * n)
     print '(I4,A,F14.8)', n, ",", energy_ev
  end do

end program bohr_energy_table

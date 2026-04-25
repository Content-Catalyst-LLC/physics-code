! Radioactive Decay Table
!
! This Fortran workflow computes:
!
!   N(t) = N0 exp(-lambda t)
!   t_1/2 = ln(2) / lambda
!
! It is a classic scientific-computing table generator.

program radioactive_decay_table
  implicit none

  integer :: i
  real(8), parameter :: n0 = 1000.0d0
  real(8), parameter :: lambda = 0.22d0
  real(8) :: time
  real(8) :: nuclei
  real(8) :: half_life

  half_life = log(2.0d0) / lambda

  print *, "time,undecayed_nuclei,half_life"

  do i = 0, 24
     time = 0.5d0 * dble(i)
     nuclei = n0 * exp(-lambda * time)

     print '(F10.4,A,F14.6,A,F14.6)', time, ",", nuclei, ",", half_life
  end do

end program radioactive_decay_table

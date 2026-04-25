! Mode Occupation Table
!
! This Fortran workflow computes Bose occupation values for sample
! dimensionless beta hbar omega values.

program mode_occupation_table
  implicit none

  integer :: i
  real(8), dimension(6) :: x_values
  real(8) :: occupation

  x_values = (/0.1d0, 0.5d0, 1.0d0, 2.0d0, 5.0d0, 10.0d0/)

  print *, "dimensionless_energy,bose_occupation"

  do i = 1, size(x_values)
     occupation = 1.0d0 / (exp(x_values(i)) - 1.0d0)
     print '(F12.6,A,E16.8)', x_values(i), ",", occupation
  end do

end program mode_occupation_table

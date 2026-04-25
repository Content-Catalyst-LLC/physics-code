! Normalize State Vector
!
! This Fortran example normalizes a simple real-valued two-state vector.
!
! Philosophical point:
! Formal normalization is a mathematical constraint. Its ontological
! interpretation depends on the theory and interpretation.

program normalize_state_vector
  implicit none

  real(8) :: state(2)
  real(8) :: norm
  integer :: i

  state(1) = 1.0d0
  state(2) = 1.0d0

  norm = sqrt(sum(state**2))

  do i = 1, 2
     state(i) = state(i) / norm
  end do

  print *, "basis_index,amplitude,probability"

  do i = 1, 2
     print '(I1,A,F12.8,A,F12.8)', i, ",", state(i), ",", state(i)**2
  end do

end program normalize_state_vector

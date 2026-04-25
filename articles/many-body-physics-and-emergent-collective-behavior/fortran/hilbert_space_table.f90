! Hilbert Space Table
!
! This Fortran workflow computes spin-1/2 Hilbert-space dimensions.

program hilbert_space_table
  implicit none

  integer :: n_sites
  integer(8) :: dimension

  print *, "n_sites,hilbert_dimension_spin_half"

  dimension = 1_8

  do n_sites = 1, 40
     dimension = dimension * 2_8
     print '(I4,A,I20)', n_sites, ",", dimension
  end do

end program hilbert_space_table

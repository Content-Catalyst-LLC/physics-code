! Density Matrix Dephasing Table
!
! This Fortran workflow computes coherence, purity, and entropy for a
! dephased |+> state.

program density_matrix_dephasing_table
  implicit none

  integer :: i
  real(8), parameter :: t2 = 5.0d-6
  real(8) :: t
  real(8) :: coherence
  real(8) :: lambda_plus
  real(8) :: lambda_minus
  real(8) :: purity
  real(8) :: entropy

  print *, "time_microseconds,coherence_abs,purity,entropy_bits"

  do i = 0, 25
     t = real(i, 8) * 1.0d-6
     coherence = 0.5d0 * exp(-t / t2)

     lambda_plus = 0.5d0 + coherence
     lambda_minus = 0.5d0 - coherence

     purity = lambda_plus**2 + lambda_minus**2
     entropy = 0.0d0

     if (lambda_plus > 0.0d0) then
        entropy = entropy - lambda_plus * log(lambda_plus) / log(2.0d0)
     end if

     if (lambda_minus > 0.0d0) then
        entropy = entropy - lambda_minus * log(lambda_minus) / log(2.0d0)
     end if

     print '(F16.8,A,F16.10,A,F16.10,A,F16.10)', &
       t * 1.0d6, ",", coherence, ",", purity, ",", entropy
  end do

end program density_matrix_dephasing_table

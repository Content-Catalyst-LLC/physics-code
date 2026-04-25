! SSH Winding Table
!
! This Fortran scaffold labels SSH parameter cases using |t2| > |t1|.

program ssh_winding_table
  implicit none

  real(8), dimension(5) :: t1_values
  real(8), dimension(5) :: t2_values
  integer :: i

  t1_values = (/1.0d0, 1.0d0, 1.0d0, 0.3d0, 1.5d0/)
  t2_values = (/0.5d0, 1.5d0, 1.0d0, 1.5d0, 0.3d0/)

  print *, "t1,t2,phase_label"

  do i = 1, 5
     if (abs(t2_values(i)) > abs(t1_values(i))) then
        print '(F8.3,A,F8.3,A,A)', t1_values(i), ",", t2_values(i), ",", "topological_scaffold"
     else if (abs(t2_values(i)) == abs(t1_values(i))) then
        print '(F8.3,A,F8.3,A,A)', t1_values(i), ",", t2_values(i), ",", "transition_scaffold"
     else
        print '(F8.3,A,F8.3,A,A)', t1_values(i), ",", t2_values(i), ",", "trivial_scaffold"
     end if
  end do

end program ssh_winding_table

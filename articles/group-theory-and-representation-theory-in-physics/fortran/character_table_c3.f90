! Character Table C3
!
! This Fortran workflow prints the real and imaginary parts
! of the C3 complex character table.

program character_table_c3
  implicit none

  real(8) :: pi
  complex(8) :: omega
  complex(8), dimension(3,3) :: chars
  integer :: i, j

  pi = 4.0d0 * atan(1.0d0)
  omega = cmplx(cos(2.0d0 * pi / 3.0d0), sin(2.0d0 * pi / 3.0d0), kind=8)

  chars(1,:) = (/ (1.0d0,0.0d0), (1.0d0,0.0d0), (1.0d0,0.0d0) /)
  chars(2,:) = (/ (1.0d0,0.0d0), omega, omega**2 /)
  chars(3,:) = (/ (1.0d0,0.0d0), omega**2, omega /)

  print *, "irrep,element,character_real,character_imag"

  do i = 1, 3
     do j = 1, 3
        print '(I1,A,I1,A,F12.8,A,F12.8)', i, ",", j, ",", real(chars(i,j)), ",", aimag(chars(i,j))
     end do
  end do

end program character_table_c3

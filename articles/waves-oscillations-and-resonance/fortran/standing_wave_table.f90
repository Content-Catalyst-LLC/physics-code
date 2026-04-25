! Standing Wave Table
!
! This Fortran workflow computes standing-wave frequencies:
!
!   f_n = n v / (2L)

program standing_wave_table
  implicit none

  integer :: n
  real(8), parameter :: wave_speed = 120.0d0
  real(8), parameter :: length = 0.65d0
  real(8) :: frequency

  print *, "mode,wave_speed_m_per_s,length_m,frequency_hz"

  do n = 1, 8
     frequency = n * wave_speed / (2.0d0 * length)

     print '(I4,A,F14.6,A,F14.6,A,F14.6)', &
       n, ",", wave_speed, ",", length, ",", frequency
  end do

end program standing_wave_table

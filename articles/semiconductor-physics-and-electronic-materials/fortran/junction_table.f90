! Junction Table
!
! This Fortran workflow computes built-in potential for abrupt p-n junctions.

program junction_table
  implicit none

  integer :: i
  real(8), parameter :: q = 1.602176634d-19
  real(8), parameter :: kb = 1.380649d-23
  real(8), parameter :: temperature = 300.0d0
  real(8), parameter :: ni = 1.0d10
  real(8), dimension(4) :: doping_values
  real(8) :: na
  real(8) :: nd
  real(8) :: vt
  real(8) :: vbi

  doping_values = (/1.0d15, 1.0d16, 1.0d17, 1.0d18/)
  vt = kb * temperature / q

  print *, "acceptor_cm3,donor_cm3,built_in_potential_v"

  do i = 1, size(doping_values)
     na = doping_values(i)
     nd = doping_values(i)
     vbi = vt * log((na * nd) / (ni * ni))

     print '(E16.8,A,E16.8,A,F16.8)', na, ",", nd, ",", vbi
  end do

end program junction_table

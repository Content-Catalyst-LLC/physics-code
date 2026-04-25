! Diffusion Table
!
! Computes mean squared displacement for simple diffusion:
!
!   <x^2> = 2 D t

program diffusion_table
  implicit none

  real(8), parameter :: diffusion = 1.0d0
  real(8) :: time
  real(8) :: msd

  print *, "time,diffusion,mean_squared_displacement"

  time = 0.0d0

  do while (time <= 10.0001d0)
     msd = 2.0d0 * diffusion * time

     print '(F10.4,A,F10.4,A,F14.8)', time, ",", diffusion, ",", msd

     time = time + 0.5d0
  end do

end program diffusion_table

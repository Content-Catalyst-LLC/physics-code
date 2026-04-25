! Ginzburg-Landau Free Energy Table
!
! Computes equilibrium amplitude for alpha(T) = alpha0 (T - Tc).

program gl_free_energy_table
  implicit none

  real(8), parameter :: tc = 9.2d0
  real(8), parameter :: alpha0 = 1.0d0
  real(8), parameter :: beta = 1.0d0

  real(8) :: temperature
  real(8) :: alpha
  real(8) :: amplitude

  print *, "temperature_k,alpha,equilibrium_amplitude"

  temperature = 2.0d0

  do while (temperature <= 14.0001d0)
     alpha = alpha0 * (temperature - tc)

     if (alpha < 0.0d0) then
        amplitude = sqrt(-alpha / beta)
     else
        amplitude = 0.0d0
     end if

     print '(F10.4,A,F12.6,A,F12.6)', temperature, ",", alpha, ",", amplitude

     temperature = temperature + 0.5d0
  end do

end program gl_free_energy_table

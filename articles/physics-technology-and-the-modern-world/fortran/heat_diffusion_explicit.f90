! One-Dimensional Explicit Heat Diffusion
!
! This Fortran workflow provides a classic scientific-computing scaffold
! for thermal diffusion.
!
! Equation:
!   dT/dt = alpha * d2T/dx2
!
! This kind of model is relevant to thermal management in electronics,
! sensors, materials, instruments, and energy systems.

program heat_diffusion_explicit
  implicit none

  integer, parameter :: n_points = 51
  integer, parameter :: n_steps = 300
  real(8), parameter :: alpha_m2_per_s = 1.0d-5
  real(8), parameter :: length_m = 0.10d0

  real(8) :: dx_m
  real(8) :: dt_s
  real(8) :: temperature_c(n_points)
  real(8) :: next_temperature_c(n_points)
  real(8) :: position_m
  integer :: i
  integer :: step

  dx_m = length_m / dble(n_points - 1)
  dt_s = 0.2d0 * dx_m**2 / alpha_m2_per_s

  temperature_c = 20.0d0
  temperature_c((n_points + 1) / 2) = 100.0d0

  print *, "step,position_m,temperature_c"

  do step = 0, n_steps
     if (mod(step, 25) == 0) then
        do i = 1, n_points
           position_m = dble(i - 1) * dx_m
           print '(I6,A,F12.6,A,F12.6)', step, ",", position_m, ",", temperature_c(i)
        end do
     end if

     next_temperature_c = temperature_c

     do i = 2, n_points - 1
        next_temperature_c(i) = temperature_c(i) + &
             alpha_m2_per_s * dt_s / dx_m**2 * &
             (temperature_c(i + 1) - 2.0d0 * temperature_c(i) + temperature_c(i - 1))
     end do

     temperature_c = next_temperature_c
  end do

end program heat_diffusion_explicit

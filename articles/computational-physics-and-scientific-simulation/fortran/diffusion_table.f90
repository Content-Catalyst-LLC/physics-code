! Diffusion Table
!
! This Fortran workflow solves a one-dimensional diffusion equation using an
! explicit finite-difference method.

program diffusion_table
  implicit none

  integer, parameter :: n_grid = 201
  integer, parameter :: n_steps = 1200
  integer :: i, step_index
  real(8), parameter :: length_m = 1.0d0
  real(8), parameter :: diffusivity = 0.001d0
  real(8), parameter :: dt = 0.0002d0
  real(8) :: dx
  real(8) :: s
  real(8) :: x
  real(8), dimension(n_grid) :: field
  real(8), dimension(n_grid) :: next_field
  real(8) :: total
  real(8) :: max_field

  dx = length_m / real(n_grid - 1, 8)
  s = diffusivity * dt / (dx * dx)

  if (s > 0.5d0) then
     print *, "Explicit diffusion stability condition violated."
     stop
  end if

  do i = 1, n_grid
     x = real(i - 1, 8) * dx
     field(i) = exp(-((x - 0.5d0)**2) / (2.0d0 * 0.04d0**2))
  end do

  print *, "step,time_s,total_integral,max_field,stability_number"

  do step_index = 0, n_steps
     if (mod(step_index, 300) == 0) then
        total = sum(field) * dx
        max_field = maxval(field)

        print '(I8,A,F12.6,A,F16.10,A,F16.10,A,F12.8)', &
          step_index, ",", step_index * dt, ",", total, ",", max_field, ",", s
     end if

     next_field = field

     do i = 2, n_grid - 1
        next_field(i) = field(i) + s * (field(i + 1) - 2.0d0 * field(i) + field(i - 1))
     end do

     next_field(1) = 0.0d0
     next_field(n_grid) = 0.0d0

     field = next_field
  end do

end program diffusion_table

! Lorenz Table
!
! This Fortran workflow advances the Lorenz system using a simple RK4 method.
! It is a transparent scaffold, not a production integrator.

program lorenz_table
  implicit none

  integer, parameter :: n_steps = 2000
  integer :: step
  real(8), parameter :: sigma = 10.0d0
  real(8), parameter :: rho = 28.0d0
  real(8), parameter :: beta = 8.0d0 / 3.0d0
  real(8), parameter :: dt = 0.01d0
  real(8) :: x, y, z, t

  x = 1.0d0
  y = 1.0d0
  z = 1.0d0

  print *, "step,time,x,y,z"

  do step = 0, n_steps
     t = step * dt

     if (mod(step, 20) == 0) then
        print '(I8,A,F12.6,A,F14.8,A,F14.8,A,F14.8)', &
          step, ",", t, ",", x, ",", y, ",", z
     end if

     call rk4_step(x, y, z, dt, sigma, rho, beta)
  end do

contains

  subroutine lorenz_rhs(x, y, z, sigma, rho, beta, dx, dy, dz)
    real(8), intent(in) :: x, y, z, sigma, rho, beta
    real(8), intent(out) :: dx, dy, dz

    dx = sigma * (y - x)
    dy = x * (rho - z) - y
    dz = x * y - beta * z
  end subroutine lorenz_rhs

  subroutine rk4_step(x, y, z, dt, sigma, rho, beta)
    real(8), intent(inout) :: x, y, z
    real(8), intent(in) :: dt, sigma, rho, beta
    real(8) :: k1x, k1y, k1z
    real(8) :: k2x, k2y, k2z
    real(8) :: k3x, k3y, k3z
    real(8) :: k4x, k4y, k4z

    call lorenz_rhs(x, y, z, sigma, rho, beta, k1x, k1y, k1z)
    call lorenz_rhs(x + 0.5d0 * dt * k1x, y + 0.5d0 * dt * k1y, z + 0.5d0 * dt * k1z, sigma, rho, beta, k2x, k2y, k2z)
    call lorenz_rhs(x + 0.5d0 * dt * k2x, y + 0.5d0 * dt * k2y, z + 0.5d0 * dt * k2z, sigma, rho, beta, k3x, k3y, k3z)
    call lorenz_rhs(x + dt * k3x, y + dt * k3y, z + dt * k3z, sigma, rho, beta, k4x, k4y, k4z)

    x = x + dt * (k1x + 2.0d0 * k2x + 2.0d0 * k3x + k4x) / 6.0d0
    y = y + dt * (k1y + 2.0d0 * k2y + 2.0d0 * k3y + k4y) / 6.0d0
    z = z + dt * (k1z + 2.0d0 * k2z + 2.0d0 * k3z + k4z) / 6.0d0
  end subroutine rk4_step

end program lorenz_table

! Discretized Euclidean Action Table
!
! This Fortran workflow computes Euclidean action for sinusoidal paths.

program discretized_action_table
  implicit none

  integer, parameter :: n_steps = 128
  real(8), parameter :: beta = 4.0d0
  real(8), parameter :: mass = 1.0d0
  real(8), parameter :: omega = 1.0d0
  real(8), parameter :: pi = 4.0d0 * atan(1.0d0)

  real(8) :: delta_tau
  real(8) :: amplitude
  real(8) :: path(n_steps)
  real(8) :: action
  integer :: i

  delta_tau = beta / n_steps

  print *, "amplitude,euclidean_action,path_weight"

  amplitude = 0.0d0

  do while (amplitude <= 2.0001d0)
     do i = 1, n_steps
        path(i) = amplitude * sin(2.0d0 * pi * ((i - 1) * delta_tau) / beta)
     end do

     action = compute_action(path, n_steps, mass, omega, delta_tau)

     print '(F8.3,A,F14.8,A,F14.8)', amplitude, ",", action, ",", exp(-action)

     amplitude = amplitude + 0.25d0
  end do

contains

  real(8) function compute_action(path, n, mass, omega, delta_tau)
    implicit none

    integer, intent(in) :: n
    real(8), intent(in) :: path(n)
    real(8), intent(in) :: mass
    real(8), intent(in) :: omega
    real(8), intent(in) :: delta_tau

    integer :: i
    integer :: next_i
    real(8) :: kinetic
    real(8) :: potential

    compute_action = 0.0d0

    do i = 1, n
       if (i == n) then
          next_i = 1
       else
          next_i = i + 1
       end if

       kinetic = mass / (2.0d0 * delta_tau) * (path(next_i) - path(i))**2
       potential = 0.5d0 * delta_tau * mass * omega**2 * path(i)**2

       compute_action = compute_action + kinetic + potential
    end do
  end function compute_action

end program discretized_action_table

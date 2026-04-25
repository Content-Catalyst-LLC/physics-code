! Harmonic Oscillator Velocity-Verlet Simulation
!
! This Fortran workflow demonstrates a classic numerical method used in
! computational physics.
!
! Equation:
!   x'' = -omega^2 x
!
! The velocity-Verlet method is common in mechanics and molecular simulation
! because it has favorable behavior for many conservative systems.

program harmonic_oscillator_verlet
  implicit none

  integer, parameter :: n_steps = 10000
  real(8), parameter :: omega_rad_per_s = 2.0d0
  real(8), parameter :: dt_s = 0.001d0

  integer :: i
  real(8) :: time_s
  real(8) :: position_m
  real(8) :: velocity_m_per_s
  real(8) :: acceleration_m_per_s2
  real(8) :: next_acceleration_m_per_s2

  position_m = 1.0d0
  velocity_m_per_s = 0.0d0
  acceleration_m_per_s2 = -omega_rad_per_s**2 * position_m

  print *, "time_s,position_m,velocity_m_per_s"

  do i = 0, n_steps
     time_s = i * dt_s

     if (mod(i, 100) == 0) then
        print '(F10.5,A,F14.8,A,F14.8)', time_s, ",", position_m, ",", velocity_m_per_s
     end if

     position_m = position_m + velocity_m_per_s * dt_s + 0.5d0 * acceleration_m_per_s2 * dt_s**2
     next_acceleration_m_per_s2 = -omega_rad_per_s**2 * position_m
     velocity_m_per_s = velocity_m_per_s + 0.5d0 * (acceleration_m_per_s2 + next_acceleration_m_per_s2) * dt_s
     acceleration_m_per_s2 = next_acceleration_m_per_s2
  end do

end program harmonic_oscillator_verlet

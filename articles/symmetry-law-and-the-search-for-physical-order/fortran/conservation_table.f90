! Harmonic Oscillator Conservation Table
!
! This Fortran workflow computes:
!
!   E = 0.5*m*v^2 + 0.5*k*x^2
!
! for an ideal harmonic oscillator.

program conservation_table
  implicit none

  integer :: i
  real(8), parameter :: mass = 1.0d0
  real(8), parameter :: spring_constant = 4.0d0
  real(8), parameter :: amplitude = 1.0d0
  real(8), parameter :: omega = 2.0d0
  real(8) :: time
  real(8) :: position
  real(8) :: velocity
  real(8) :: kinetic_energy
  real(8) :: potential_energy
  real(8) :: total_energy

  print *, "time,position,velocity,kinetic_energy,potential_energy,total_energy"

  do i = 0, 20
     time = 0.5d0 * dble(i)
     position = amplitude * cos(omega * time)
     velocity = -amplitude * omega * sin(omega * time)

     kinetic_energy = 0.5d0 * mass * velocity**2
     potential_energy = 0.5d0 * spring_constant * position**2
     total_energy = kinetic_energy + potential_energy

     print '(F10.4,A,F14.8,A,F14.8,A,F14.8,A,F14.8,A,F14.8)', &
       time, ",", position, ",", velocity, ",", kinetic_energy, ",", potential_energy, ",", total_energy
  end do

end program conservation_table

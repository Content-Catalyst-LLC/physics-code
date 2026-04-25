! Numerical Methods Table
!
! This Fortran workflow computes harmonic oscillator energy for a small
! table of displacements and velocities.

program numerical_methods_table
  implicit none

  integer :: i, j
  real(8), parameter :: mass_kg = 1.0d0
  real(8), parameter :: spring_constant = 25.0d0
  real(8), dimension(5) :: x_values
  real(8), dimension(5) :: v_values
  real(8) :: energy

  x_values = (/-1.0d0, -0.5d0, 0.0d0, 0.5d0, 1.0d0/)
  v_values = (/-2.0d0, -1.0d0, 0.0d0, 1.0d0, 2.0d0/)

  print *, "displacement_m,velocity_m_per_s,total_energy_j"

  do i = 1, size(x_values)
     do j = 1, size(v_values)
        energy = 0.5d0 * mass_kg * v_values(j)**2 + &
                 0.5d0 * spring_constant * x_values(i)**2

        print '(F12.6,A,F12.6,A,F14.8)', &
          x_values(i), ",", v_values(j), ",", energy
     end do
  end do

end program numerical_methods_table

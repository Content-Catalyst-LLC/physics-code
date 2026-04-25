! Hamiltonian Table
!
! This Fortran workflow computes the simple pendulum Hamiltonian:
!
!   H = p^2/(2 m l^2) + m g l(1 - cos(theta))

program hamiltonian_table
  implicit none

  integer :: i, j
  real(8), parameter :: mass_kg = 1.0d0
  real(8), parameter :: length_m = 1.0d0
  real(8), parameter :: g = 9.80665d0
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), dimension(5) :: theta_values
  real(8), dimension(5) :: p_values
  real(8) :: theta
  real(8) :: p
  real(8) :: h

  theta_values = (/-pi_value, -pi_value/2.0d0, 0.0d0, pi_value/2.0d0, pi_value/)
  p_values = (/-4.0d0, -2.0d0, 0.0d0, 2.0d0, 4.0d0/)

  print *, "theta_rad,p_theta_kg_m2_per_s,hamiltonian_j"

  do i = 1, size(theta_values)
     do j = 1, size(p_values)
        theta = theta_values(i)
        p = p_values(j)
        h = p**2 / (2.0d0 * mass_kg * length_m**2) + &
            mass_kg * g * length_m * (1.0d0 - cos(theta))

        print '(F14.8,A,F14.8,A,F18.8)', theta, ",", p, ",", h
     end do
  end do

end program hamiltonian_table

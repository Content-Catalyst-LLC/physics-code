! Two-State Partition Table
!
! This Fortran workflow computes:
!
!   Z = 1 + exp(-beta epsilon)
!   p_exc = exp(-beta epsilon) / Z
!   <E> = epsilon p_exc
!   F = -k_B T ln Z

program two_state_partition_table
  implicit none

  integer :: i
  real(8), parameter :: k_b = 1.380649d-23
  real(8), parameter :: epsilon_j = 2.0d-21
  real(8), dimension(5) :: temperatures_k
  real(8) :: temperature_k
  real(8) :: beta
  real(8) :: boltzmann_factor
  real(8) :: z
  real(8) :: p_excited
  real(8) :: mean_energy_j
  real(8) :: free_energy_j

  temperatures_k = (/100.0d0, 150.0d0, 300.0d0, 600.0d0, 1000.0d0/)

  print *, "temperature_k,beta_per_joule,partition_function,p_excited,mean_energy_j,free_energy_j"

  do i = 1, size(temperatures_k)
     temperature_k = temperatures_k(i)
     beta = 1.0d0 / (k_b * temperature_k)
     boltzmann_factor = exp(-beta * epsilon_j)
     z = 1.0d0 + boltzmann_factor
     p_excited = boltzmann_factor / z
     mean_energy_j = epsilon_j * p_excited
     free_energy_j = -k_b * temperature_k * log(z)

     print '(F10.3,A,ES18.10,A,F14.8,A,F14.8,A,ES18.10,A,ES18.10)', &
       temperature_k, ",", beta, ",", z, ",", p_excited, ",", mean_energy_j, ",", free_energy_j
  end do

end program two_state_partition_table

! Diffusion and Nernst Table
!
! This Fortran workflow computes diffusion time and Nernst potential.

program diffusion_nernst_table
  implicit none

  integer :: i
  real(8), parameter :: gas_constant = 8.314462618d0
  real(8), parameter :: faraday_constant = 96485.33212d0
  real(8), parameter :: temperature = 310.15d0
  real(8), dimension(4) :: lengths_um
  real(8) :: diffusion_coefficient
  real(8) :: diffusion_time
  real(8) :: nernst_k

  lengths_um = (/0.1d0, 1.0d0, 10.0d0, 100.0d0/)
  diffusion_coefficient = 10.0d0

  print *, "model,parameter,value,unit"

  do i = 1, size(lengths_um)
     diffusion_time = lengths_um(i)**2 / (2.0d0 * diffusion_coefficient)
     print '(A,F10.4,A,F16.8,A)', "diffusion_time,length_um_", lengths_um(i), ",", diffusion_time, ",s"
  end do

  nernst_k = (gas_constant * temperature / faraday_constant) * log(5.0d0 / 140.0d0)

  print '(A,F16.8,A)', "nernst_potential,potassium,", nernst_k, ",V"

end program diffusion_nernst_table

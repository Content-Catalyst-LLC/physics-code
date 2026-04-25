! Radiation Balance Table
!
! This Fortran workflow computes:
!
!   ASR = S0(1-alpha)/4
!   Te = (ASR/sigma)^(1/4)

program radiation_balance_table
  implicit none

  integer :: i
  real(8), parameter :: solar_constant = 1361.0d0
  real(8), parameter :: sigma_sb = 5.670374419d-8
  real(8), dimension(7) :: albedos
  real(8) :: albedo
  real(8) :: asr
  real(8) :: te

  albedos = (/0.10d0, 0.20d0, 0.25d0, 0.30d0, 0.35d0, 0.50d0, 0.70d0/)

  print *, "albedo,absorbed_shortwave_w_m2,effective_emission_temperature_k"

  do i = 1, size(albedos)
     albedo = albedos(i)
     asr = solar_constant * (1.0d0 - albedo) / 4.0d0
     te = (asr / sigma_sb)**0.25d0

     print '(F10.4,A,F16.8,A,F16.8)', albedo, ",", asr, ",", te
  end do

end program radiation_balance_table

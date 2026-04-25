! Ideal Gas Process Table
!
! This Fortran workflow computes:
!
!   P = nRT/V
!   W = nRT ln(V2/V1)
!   Delta S = nR ln(V2/V1)

program ideal_gas_process_table
  implicit none

  integer :: i
  real(8), parameter :: R = 8.314462618d0
  real(8), parameter :: n = 1.0d0
  real(8), parameter :: T = 300.0d0
  real(8), parameter :: V1 = 0.02d0
  real(8), dimension(5) :: V2_values
  real(8) :: V2
  real(8) :: work_j
  real(8) :: entropy_j_per_k
  real(8) :: pressure_initial_pa
  real(8) :: pressure_final_pa

  V2_values = (/0.03d0, 0.04d0, 0.06d0, 0.08d0, 0.10d0/)

  print *, "V1_m3,V2_m3,pressure_initial_pa,pressure_final_pa,isothermal_work_j,entropy_change_j_per_k"

  do i = 1, size(V2_values)
     V2 = V2_values(i)
     pressure_initial_pa = n * R * T / V1
     pressure_final_pa = n * R * T / V2
     work_j = n * R * T * log(V2 / V1)
     entropy_j_per_k = n * R * log(V2 / V1)

     print '(F10.5,A,F10.5,A,ES14.6,A,ES14.6,A,ES14.6,A,ES14.6)', &
       V1, ",", V2, ",", pressure_initial_pa, ",", pressure_final_pa, ",", work_j, ",", entropy_j_per_k
  end do

end program ideal_gas_process_table

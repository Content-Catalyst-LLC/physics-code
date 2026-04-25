! Moment of Inertia and Rolling Table
!
! This Fortran workflow computes:
!
!   I = beta M R^2
!   a = g sin(theta)/(1+beta)
!   v = sqrt(2gh/(1+beta))

program moment_of_inertia_table
  implicit none

  integer :: i
  real(8), parameter :: g = 9.80665d0
  real(8), parameter :: pi_value = 3.141592653589793d0
  real(8), parameter :: mass_kg = 1.0d0
  real(8), parameter :: radius_m = 0.10d0
  real(8), parameter :: height_drop_m = 1.0d0
  real(8), parameter :: incline_angle_rad = 20.0d0 * pi_value / 180.0d0

  character(len=24), dimension(5) :: names
  real(8), dimension(5) :: beta_values
  real(8) :: beta
  real(8) :: inertia
  real(8) :: acceleration
  real(8) :: final_speed

  names = (/ "hoop                  ", "solid_disk            ", "solid_sphere          ", &
             "thin_spherical_shell  ", "sliding_point_mass    " /)

  beta_values = (/1.0d0, 0.5d0, 0.4d0, 2.0d0/3.0d0, 0.0d0/)

  print *, "object,beta,moment_of_inertia_kg_m2,acceleration_m_per_s2,final_speed_m_per_s"

  do i = 1, size(beta_values)
     beta = beta_values(i)
     inertia = beta * mass_kg * radius_m**2
     acceleration = g * sin(incline_angle_rad) / (1.0d0 + beta)
     final_speed = sqrt(2.0d0 * g * height_drop_m / (1.0d0 + beta))

     print '(A,A,F10.6,A,ES14.6,A,F14.8,A,F14.8)', &
       trim(names(i)), ",", beta, ",", inertia, ",", acceleration, ",", final_speed
  end do

end program moment_of_inertia_table

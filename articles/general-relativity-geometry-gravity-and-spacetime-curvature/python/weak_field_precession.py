"""
Weak-Field Relativistic Orbital Precession

This workflow integrates planar orbital motion with a Newtonian central
acceleration plus a simple weak-field relativistic correction.

It is a pedagogical model, not a full Schwarzschild geodesic solver.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 6.67430e-11
C = 299792458.0


def run_orbit(case: pd.Series) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Integrate a weak-field precession toy orbit for one case.
    """
    mu = G * case["central_mass_kg"]
    semi_major_axis = case["semi_major_axis_m"]
    eccentricity = case["eccentricity"]
    time_step = case["time_step_s"]
    n_steps = int(case["n_steps"])

    perihelion_distance = semi_major_axis * (1.0 - eccentricity)

    perihelion_speed = np.sqrt(
        mu * (1.0 + eccentricity) / (semi_major_axis * (1.0 - eccentricity))
    )

    position = np.array([perihelion_distance, 0.0], dtype=float)
    velocity = np.array([0.0, perihelion_speed], dtype=float)

    def acceleration(position_m: np.ndarray, velocity_m_s: np.ndarray) -> np.ndarray:
        radius = np.linalg.norm(position_m)

        if radius == 0.0:
            raise ValueError("Orbital radius cannot be zero.")

        h = position_m[0] * velocity_m_s[1] - position_m[1] * velocity_m_s[0]

        correction = 1.0 + 3.0 * h**2 / (C**2 * radius**2)

        return -mu * position_m / radius**3 * correction

    def specific_energy(position_m: np.ndarray, velocity_m_s: np.ndarray) -> float:
        radius = np.linalg.norm(position_m)
        kinetic = 0.5 * np.dot(velocity_m_s, velocity_m_s)
        potential = -mu / radius
        return kinetic + potential

    rows = []
    perihelion_events = []

    previous_radius = np.linalg.norm(position)
    previous_previous_radius = previous_radius
    current_acceleration = acceleration(position, velocity)

    for step in range(n_steps + 1):
        time_s = step * time_step
        radius = np.linalg.norm(position)
        angle = np.arctan2(position[1], position[0])

        rows.append(
            {
                "case_id": case["case_id"],
                "step": step,
                "time_s": time_s,
                "x_m": position[0],
                "y_m": position[1],
                "vx_m_s": velocity[0],
                "vy_m_s": velocity[1],
                "radius_m": radius,
                "angle_rad": angle,
                "specific_energy_j_kg": specific_energy(position, velocity),
            }
        )

        if step > 2 and previous_radius < previous_previous_radius and previous_radius < radius:
            previous_row = rows[-2]
            perihelion_events.append(
                {
                    "case_id": case["case_id"],
                    "step": previous_row["step"],
                    "time_s": previous_row["time_s"],
                    "angle_rad": previous_row["angle_rad"],
                    "radius_m": previous_row["radius_m"],
                }
            )

        if step < n_steps:
            next_position = (
                position
                + velocity * time_step
                + 0.5 * current_acceleration * time_step**2
            )

            # Use the current velocity in the correction for this pedagogical
            # integrator. A full treatment would integrate the exact geodesic equations.
            next_acceleration = acceleration(next_position, velocity)

            next_velocity = (
                velocity
                + 0.5 * (current_acceleration + next_acceleration) * time_step
            )

            previous_previous_radius = previous_radius
            previous_radius = radius

            position = next_position
            velocity = next_velocity
            current_acceleration = next_acceleration

    trajectory = pd.DataFrame(rows)
    perihelia = pd.DataFrame(perihelion_events)

    if len(perihelia) > 1:
        unwrapped_angles = np.unwrap(perihelia["angle_rad"].to_numpy())
        perihelia["unwrapped_angle_rad"] = unwrapped_angles
        perihelia["precession_since_first_rad"] = unwrapped_angles - unwrapped_angles[0]
        perihelia["precession_since_first_arcsec"] = (
            perihelia["precession_since_first_rad"] * 206264.806247
        )

    return trajectory, perihelia


def main() -> None:
    """
    Run weak-field precession cases and save outputs.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "weak_field_orbit_cases.csv"
    trajectory_path = article_dir / "data" / "computed_weak_field_orbits.csv"
    perihelion_path = article_dir / "data" / "computed_weak_field_perihelia.csv"

    cases = pd.read_csv(input_path)

    trajectories = []
    perihelia_all = []

    for _, case in cases.iterrows():
        trajectory, perihelia = run_orbit(case)
        trajectories.append(trajectory)
        if len(perihelia) > 0:
            perihelia_all.append(perihelia)

    trajectory_output = pd.concat(trajectories, ignore_index=True)
    trajectory_output.to_csv(trajectory_path, index=False)

    if perihelia_all:
        perihelion_output = pd.concat(perihelia_all, ignore_index=True)
    else:
        perihelion_output = pd.DataFrame()

    perihelion_output.to_csv(perihelion_path, index=False)

    print("Trajectory sample:")
    print(trajectory_output.groupby("case_id").head(3).round(6).to_string(index=False))

    print("\nPerihelion sample:")
    if len(perihelion_output) == 0:
        print("No perihelia detected.")
    else:
        print(perihelion_output.groupby("case_id").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

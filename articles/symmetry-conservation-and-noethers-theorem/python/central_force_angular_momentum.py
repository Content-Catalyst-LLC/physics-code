"""
Central Force Angular Momentum Conservation

This workflow simulates a particle moving under an inverse-square
central force:

    a = -mu r / |r|^3

A central force is rotationally invariant, so angular momentum should
be conserved. The simulation uses a velocity-Verlet integrator.
"""

from pathlib import Path

import numpy as np
import pandas as pd


MU = 1.0
MASS = 1.0
TIME_STEP = 0.001
N_STEPS = 20000


def acceleration(position: np.ndarray) -> np.ndarray:
    """
    Compute inverse-square central acceleration.
    """
    radius = np.linalg.norm(position)

    if radius == 0.0:
        raise ValueError("Radius cannot be zero.")

    return -MU * position / radius**3


def total_energy(position: np.ndarray, velocity: np.ndarray) -> float:
    """
    Compute total mechanical energy per unit mass.
    """
    radius = np.linalg.norm(position)
    kinetic = 0.5 * np.dot(velocity, velocity)
    potential = -MU / radius
    return kinetic + potential


def angular_momentum_z(position: np.ndarray, velocity: np.ndarray) -> float:
    """
    Compute z-component of angular momentum for planar motion.
    """
    return MASS * (position[0] * velocity[1] - position[1] * velocity[0])


def main() -> None:
    """
    Integrate a central-force orbit and save conservation diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_central_force_orbit.csv"
    summary_path = article_dir / "data" / "computed_central_force_conservation_summary.csv"

    position = np.array([1.0, 0.0], dtype=float)
    velocity = np.array([0.0, 0.8], dtype=float)

    rows = []

    initial_energy = total_energy(position, velocity)
    initial_angular_momentum = angular_momentum_z(position, velocity)
    current_acceleration = acceleration(position)

    for step in range(N_STEPS + 1):
        time = step * TIME_STEP

        energy = total_energy(position, velocity)
        angular_momentum = angular_momentum_z(position, velocity)

        rows.append(
            {
                "step": step,
                "time": time,
                "x": position[0],
                "y": position[1],
                "vx": velocity[0],
                "vy": velocity[1],
                "energy": energy,
                "angular_momentum_z": angular_momentum,
                "relative_energy_error": (
                    energy - initial_energy
                ) / abs(initial_energy),
                "relative_angular_momentum_error": (
                    angular_momentum - initial_angular_momentum
                ) / abs(initial_angular_momentum),
            }
        )

        if step < N_STEPS:
            next_position = (
                position
                + velocity * TIME_STEP
                + 0.5 * current_acceleration * TIME_STEP**2
            )

            next_acceleration = acceleration(next_position)

            next_velocity = (
                velocity
                + 0.5
                * (current_acceleration + next_acceleration)
                * TIME_STEP
            )

            position = next_position
            velocity = next_velocity
            current_acceleration = next_acceleration

    diagnostics = pd.DataFrame(rows)
    diagnostics.to_csv(output_path, index=False)

    summary = pd.DataFrame(
        [
            {
                "initial_energy": initial_energy,
                "final_energy": diagnostics["energy"].iloc[-1],
                "max_abs_relative_energy_error": diagnostics[
                    "relative_energy_error"
                ].abs().max(),
                "initial_angular_momentum_z": initial_angular_momentum,
                "final_angular_momentum_z": diagnostics[
                    "angular_momentum_z"
                ].iloc[-1],
                "max_abs_relative_angular_momentum_error": diagnostics[
                    "relative_angular_momentum_error"
                ].abs().max(),
            }
        ]
    )

    summary.to_csv(summary_path, index=False)

    print("Trajectory sample:")
    print(diagnostics.iloc[::2000, :].round(10).to_string(index=False))

    print("\nConservation summary:")
    print(summary.round(12).to_string(index=False))


if __name__ == "__main__":
    main()

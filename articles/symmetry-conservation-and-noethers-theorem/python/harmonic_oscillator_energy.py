"""
Harmonic Oscillator Energy Conservation

For a time-independent harmonic oscillator:

    L = 1/2 m qdot^2 - 1/2 k q^2

time-translation symmetry implies energy conservation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


MASS = 1.0
SPRING_CONSTANT = 4.0
TIME_STEP = 0.001
N_STEPS = 20000


def acceleration(position: float) -> float:
    """
    Compute harmonic oscillator acceleration.
    """
    return -(SPRING_CONSTANT / MASS) * position


def energy(position: float, velocity: float) -> float:
    """
    Compute total oscillator energy.
    """
    kinetic = 0.5 * MASS * velocity**2
    potential = 0.5 * SPRING_CONSTANT * position**2
    return kinetic + potential


def main() -> None:
    """
    Integrate harmonic oscillator and save energy conservation diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_harmonic_oscillator_energy.csv"

    position = 1.0
    velocity = 0.0
    current_acceleration = acceleration(position)

    initial_energy = energy(position, velocity)
    rows = []

    for step in range(N_STEPS + 1):
        time = step * TIME_STEP
        current_energy = energy(position, velocity)

        rows.append(
            {
                "step": step,
                "time": time,
                "position": position,
                "velocity": velocity,
                "energy": current_energy,
                "relative_energy_error": (
                    current_energy - initial_energy
                ) / initial_energy,
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

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Harmonic oscillator energy diagnostics:")
    print(output.iloc[::2000, :].round(10).to_string(index=False))
    print("\nMaximum absolute relative energy error:")
    print(output["relative_energy_error"].abs().max())


if __name__ == "__main__":
    main()

"""
Example Physics Workflow

This placeholder demonstrates the preferred Python style for Physics articles:
clear variables, documented assumptions, reproducible calculations, and simple plots.
"""

import numpy as np
import pandas as pd


def kinetic_energy(mass_kg: float, velocity_m_per_s: float) -> float:
    """Return classical kinetic energy in joules."""
    return 0.5 * mass_kg * velocity_m_per_s**2


def main() -> None:
    masses = np.array([1.0, 2.0, 5.0])
    velocities = np.array([3.0, 4.0, 5.0])

    df = pd.DataFrame({
        "mass_kg": masses,
        "velocity_m_per_s": velocities,
        "kinetic_energy_j": [
            kinetic_energy(mass, velocity)
            for mass, velocity in zip(masses, velocities)
        ],
    })

    print(df)


if __name__ == "__main__":
    main()

"""
Noether-Style Energy Conservation Check

This workflow illustrates energy conservation in an ideal harmonic oscillator:

    E = 0.5*m*v^2 + 0.5*k*x^2

The oscillator has no explicit time dependence in its Lagrangian, so the
energy-like quantity remains constant in the ideal analytic solution.

This is educational scaffolding for symmetry and conservation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def harmonic_oscillator_table(
    mass: float,
    spring_constant: float,
    amplitude: float,
    time: np.ndarray,
) -> pd.DataFrame:
    """
    Compute position, velocity, and energy for an ideal harmonic oscillator.

    Parameters
    ----------
    mass:
        Oscillator mass.
    spring_constant:
        Spring constant.
    amplitude:
        Oscillation amplitude.
    time:
        Time values.

    Returns
    -------
    pandas.DataFrame
        Table containing position, velocity, and energy components.
    """
    omega = np.sqrt(spring_constant / mass)

    position = amplitude * np.cos(omega * time)
    velocity = -amplitude * omega * np.sin(omega * time)

    kinetic_energy = 0.5 * mass * velocity**2
    potential_energy = 0.5 * spring_constant * position**2
    total_energy = kinetic_energy + potential_energy

    return pd.DataFrame(
        {
            "time": time,
            "position": position,
            "velocity": velocity,
            "kinetic_energy": kinetic_energy,
            "potential_energy": potential_energy,
            "total_energy": total_energy,
        }
    )


def main() -> None:
    """
    Generate and save an ideal energy-conservation table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_energy_conservation.csv"

    time = np.linspace(0.0, 10.0, 201)

    table = harmonic_oscillator_table(
        mass=1.0,
        spring_constant=4.0,
        amplitude=1.0,
        time=time,
    )

    table.to_csv(output_path, index=False)

    summary = table["total_energy"].agg(["min", "max", "mean", "std"])

    print("Energy conservation summary:")
    print(summary.to_string())
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()

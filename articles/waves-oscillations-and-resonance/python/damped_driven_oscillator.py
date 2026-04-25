"""
Damped and Driven Oscillator Simulation

This workflow integrates:

    m x'' + b x' + k x = F0 cos(omega_drive t)

It computes displacement, velocity, energy, and a late-time amplitude estimate.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


MASS_KG = 1.0
SPRING_CONSTANT_N_PER_M = 25.0
DAMPING_COEFFICIENT_KG_PER_S = 0.6
DRIVING_FORCE_N = 1.0

NATURAL_ANGULAR_FREQUENCY_RAD_PER_S = np.sqrt(SPRING_CONSTANT_N_PER_M / MASS_KG)
DRIVING_ANGULAR_FREQUENCY_RAD_PER_S = 0.95 * NATURAL_ANGULAR_FREQUENCY_RAD_PER_S


def driven_oscillator(time_s: float, state: np.ndarray) -> list[float]:
    """
    Return derivatives for a damped driven oscillator.
    """
    displacement_m, velocity_m_per_s = state

    driving_force = DRIVING_FORCE_N * np.cos(
        DRIVING_ANGULAR_FREQUENCY_RAD_PER_S * time_s
    )

    acceleration_m_per_s2 = (
        driving_force
        - DAMPING_COEFFICIENT_KG_PER_S * velocity_m_per_s
        - SPRING_CONSTANT_N_PER_M * displacement_m
    ) / MASS_KG

    return [velocity_m_per_s, acceleration_m_per_s2]


def main() -> None:
    """
    Integrate the oscillator and save time-domain diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_damped_driven_oscillator.csv"
    summary_path = article_dir / "data" / "computed_damped_driven_oscillator_summary.csv"

    time_eval_s = np.linspace(0.0, 40.0, 4000)

    solution = solve_ivp(
        driven_oscillator,
        (0.0, 40.0),
        [0.0, 0.0],
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    displacement_m = solution.y[0]
    velocity_m_per_s = solution.y[1]

    kinetic_energy_j = 0.5 * MASS_KG * velocity_m_per_s**2
    spring_potential_energy_j = 0.5 * SPRING_CONSTANT_N_PER_M * displacement_m**2
    total_mechanical_energy_j = kinetic_energy_j + spring_potential_energy_j

    table = pd.DataFrame(
        {
            "time_s": solution.t,
            "displacement_m": displacement_m,
            "velocity_m_per_s": velocity_m_per_s,
            "kinetic_energy_j": kinetic_energy_j,
            "spring_potential_energy_j": spring_potential_energy_j,
            "total_mechanical_energy_j": total_mechanical_energy_j,
        }
    )

    late_time = table[table["time_s"] >= 25.0]
    steady_state_amplitude_m = 0.5 * (
        late_time["displacement_m"].max() - late_time["displacement_m"].min()
    )

    summary = pd.DataFrame(
        [
            {
                "natural_angular_frequency_rad_per_s":
                    NATURAL_ANGULAR_FREQUENCY_RAD_PER_S,
                "driving_angular_frequency_rad_per_s":
                    DRIVING_ANGULAR_FREQUENCY_RAD_PER_S,
                "frequency_ratio":
                    DRIVING_ANGULAR_FREQUENCY_RAD_PER_S /
                    NATURAL_ANGULAR_FREQUENCY_RAD_PER_S,
                "estimated_steady_state_amplitude_m":
                    steady_state_amplitude_m,
                "max_total_mechanical_energy_j":
                    table["total_mechanical_energy_j"].max(),
                "final_total_mechanical_energy_j":
                    table["total_mechanical_energy_j"].iloc[-1],
            }
        ]
    )

    table.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Driven oscillator sample:")
    print(table.head(12).round(8).to_string(index=False))
    print("\nResponse summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

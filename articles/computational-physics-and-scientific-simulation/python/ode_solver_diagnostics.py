"""
ODE Solver Diagnostics for a Harmonic Oscillator

This workflow integrates:

    d2x/dt2 + omega0^2 x = 0

as a first-order system and monitors energy conservation.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


MASS_KG = 1.0
SPRING_CONSTANT_N_PER_M = 25.0
OMEGA0 = np.sqrt(SPRING_CONSTANT_N_PER_M / MASS_KG)


def harmonic_oscillator(time_s: float, state: np.ndarray) -> list[float]:
    """
    Return derivatives for a harmonic oscillator.
    """
    displacement_m, velocity_m_per_s = state
    acceleration_m_per_s2 = -OMEGA0**2 * displacement_m
    return [velocity_m_per_s, acceleration_m_per_s2]


def main() -> None:
    """
    Integrate the oscillator and save energy diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_ode_solver_diagnostics.csv"
    summary_path = article_dir / "data" / "computed_ode_solver_summary.csv"

    time_eval = np.linspace(0.0, 20.0, 4000)

    solution = solve_ivp(
        harmonic_oscillator,
        (0.0, 20.0),
        [1.0, 0.0],
        t_eval=time_eval,
        rtol=1e-10,
        atol=1e-12,
    )

    displacement = solution.y[0]
    velocity = solution.y[1]

    energy = (
        0.5 * MASS_KG * velocity**2
        + 0.5 * SPRING_CONSTANT_N_PER_M * displacement**2
    )

    table = pd.DataFrame(
        {
            "time_s": solution.t,
            "displacement_m": displacement,
            "velocity_m_per_s": velocity,
            "total_energy_j": energy,
            "energy_error_j": energy - energy[0],
        }
    )

    summary = pd.DataFrame(
        [
            {
                "initial_energy_j": energy[0],
                "final_energy_j": energy[-1],
                "max_abs_energy_error_j": np.max(np.abs(energy - energy[0])),
                "expected_frequency_hz": OMEGA0 / (2.0 * np.pi),
            }
        ]
    )

    table.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("ODE solver diagnostics:")
    print(table.head(12).round(8).to_string(index=False))
    print("\nSummary:")
    print(summary.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

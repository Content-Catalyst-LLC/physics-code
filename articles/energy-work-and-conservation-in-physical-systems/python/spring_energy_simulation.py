"""
Spring-Mass Energy Simulation

This workflow compares conservative and damped spring-mass systems.

Conservative system:
    m x'' + k x = 0

Damped system:
    m x'' + b x' + k x = 0

Energy components:
    K = 1/2 m v^2
    U = 1/2 k x^2
    E = K + U
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


MASS_KG = 0.50
SPRING_CONSTANT_N_PER_M = 20.0
DAMPING_COEFFICIENT_KG_PER_S = 0.25


def conservative_oscillator(time_s: float, state: np.ndarray) -> list[float]:
    """
    Derivatives for a conservative spring-mass oscillator.
    """
    displacement_m, velocity_m_per_s = state
    acceleration_m_per_s2 = -SPRING_CONSTANT_N_PER_M / MASS_KG * displacement_m

    return [velocity_m_per_s, acceleration_m_per_s2]


def damped_oscillator(time_s: float, state: np.ndarray) -> list[float]:
    """
    Derivatives for a velocity-damped spring-mass oscillator.
    """
    displacement_m, velocity_m_per_s = state
    acceleration_m_per_s2 = (
        -SPRING_CONSTANT_N_PER_M / MASS_KG * displacement_m
        - DAMPING_COEFFICIENT_KG_PER_S / MASS_KG * velocity_m_per_s
    )

    return [velocity_m_per_s, acceleration_m_per_s2]


def compute_energy_table(solution, label: str) -> pd.DataFrame:
    """
    Compute kinetic, elastic potential, and total mechanical energy.
    """
    displacement_m = solution.y[0]
    velocity_m_per_s = solution.y[1]

    kinetic_energy_j = 0.5 * MASS_KG * velocity_m_per_s**2
    spring_potential_energy_j = 0.5 * SPRING_CONSTANT_N_PER_M * displacement_m**2
    total_mechanical_energy_j = kinetic_energy_j + spring_potential_energy_j

    return pd.DataFrame(
        {
            "model": label,
            "time_s": solution.t,
            "displacement_m": displacement_m,
            "velocity_m_per_s": velocity_m_per_s,
            "kinetic_energy_j": kinetic_energy_j,
            "spring_potential_energy_j": spring_potential_energy_j,
            "total_mechanical_energy_j": total_mechanical_energy_j,
        }
    )


def main() -> None:
    """
    Simulate and summarize conservative and damped spring-mass systems.
    """
    article_dir = Path(__file__).resolve().parents[1]
    energy_output = article_dir / "data" / "computed_spring_energy_simulation.csv"
    summary_output = article_dir / "data" / "computed_spring_energy_summary.csv"

    time_span_s = (0.0, 10.0)
    time_eval_s = np.linspace(time_span_s[0], time_span_s[1], 1000)
    initial_state = [0.10, 0.0]

    conservative_solution = solve_ivp(
        conservative_oscillator,
        time_span_s,
        initial_state,
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    damped_solution = solve_ivp(
        damped_oscillator,
        time_span_s,
        initial_state,
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    energy_table = pd.concat(
        [
            compute_energy_table(conservative_solution, "conservative"),
            compute_energy_table(damped_solution, "damped"),
        ],
        ignore_index=True,
    )

    summary = (
        energy_table.groupby("model")
        .agg(
            initial_energy_j=("total_mechanical_energy_j", "first"),
            final_energy_j=("total_mechanical_energy_j", "last"),
            min_energy_j=("total_mechanical_energy_j", "min"),
            max_energy_j=("total_mechanical_energy_j", "max"),
            mean_energy_j=("total_mechanical_energy_j", "mean"),
        )
        .reset_index()
    )

    summary["energy_change_j"] = summary["final_energy_j"] - summary["initial_energy_j"]
    summary["relative_energy_change"] = summary["energy_change_j"] / summary["initial_energy_j"]

    energy_table.to_csv(energy_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Energy table sample:")
    print(energy_table.head(12).round(8).to_string(index=False))

    print("\nEnergy summary:")
    print(summary.round(8).to_string(index=False))

    print(f"\nSaved energy table to: {energy_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()

"""
Energy Drift Comparison

This workflow compares explicit Euler and symplectic Euler for the pendulum.
The point is to show that numerical methods encode geometric assumptions.
"""

from pathlib import Path

import numpy as np
import pandas as pd


MASS_KG = 1.0
LENGTH_M = 1.0
GRAVITY_M_PER_S2 = 9.80665
DT = 0.01
N_STEPS = 5000


def hamiltonian(theta: float, p: float) -> float:
    """
    Compute pendulum Hamiltonian.
    """
    return (
        p**2 / (2.0 * MASS_KG * LENGTH_M**2)
        + MASS_KG * GRAVITY_M_PER_S2 * LENGTH_M * (1.0 - np.cos(theta))
    )


def explicit_euler_step(theta: float, p: float) -> tuple[float, float]:
    """
    Explicit Euler update.
    """
    theta_next = theta + DT * p / (MASS_KG * LENGTH_M**2)
    p_next = p - DT * MASS_KG * GRAVITY_M_PER_S2 * LENGTH_M * np.sin(theta)
    theta_next = (theta_next + np.pi) % (2.0 * np.pi) - np.pi
    return theta_next, p_next


def symplectic_euler_step(theta: float, p: float) -> tuple[float, float]:
    """
    Symplectic Euler update.
    """
    p_next = p - DT * MASS_KG * GRAVITY_M_PER_S2 * LENGTH_M * np.sin(theta)
    theta_next = theta + DT * p_next / (MASS_KG * LENGTH_M**2)
    theta_next = (theta_next + np.pi) % (2.0 * np.pi) - np.pi
    return theta_next, p_next


def integrate(method_name: str, step_function) -> pd.DataFrame:
    """
    Integrate the pendulum using the selected step function.
    """
    theta = 1.0
    p = 0.0
    e0 = hamiltonian(theta, p)
    rows = []

    for step in range(N_STEPS + 1):
        e = hamiltonian(theta, p)

        rows.append(
            {
                "method": method_name,
                "step": step,
                "time_s": step * DT,
                "theta_rad": theta,
                "p_theta_kg_m2_per_s": p,
                "hamiltonian_j": e,
                "energy_error_j": e - e0,
                "relative_energy_error": (e - e0) / e0,
            }
        )

        theta, p = step_function(theta, p)

    return pd.DataFrame(rows)


def main() -> None:
    """
    Compare energy drift across two numerical methods.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_energy_drift_comparison.csv"
    summary_path = article_dir / "data" / "computed_energy_drift_summary.csv"

    trajectory = pd.concat(
        [
            integrate("explicit_euler", explicit_euler_step),
            integrate("symplectic_euler", symplectic_euler_step),
        ],
        ignore_index=True,
    )

    summary = (
        trajectory.groupby("method", as_index=False)
        .agg(
            initial_energy_j=("hamiltonian_j", "first"),
            final_energy_j=("hamiltonian_j", "last"),
            max_abs_energy_error_j=("energy_error_j", lambda x: x.abs().max()),
            max_abs_relative_energy_error=(
                "relative_energy_error",
                lambda x: x.abs().max(),
            ),
        )
    )

    trajectory.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Energy drift summary:")
    print(summary.round(10).to_string(index=False))
    print(f"\nSaved comparison to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

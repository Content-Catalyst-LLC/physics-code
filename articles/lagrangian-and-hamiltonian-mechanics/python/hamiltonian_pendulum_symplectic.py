"""
Hamiltonian Pendulum Integration with Symplectic Euler

Hamiltonian:
    H(theta, p) = p^2/(2 m l^2) + m g l(1 - cos(theta))

Hamilton's equations:
    theta_dot = p/(m l^2)
    p_dot     = -m g l sin(theta)

The symplectic Euler method updates momentum first and then position.
"""

from pathlib import Path

import numpy as np
import pandas as pd


MASS_KG = 1.0
LENGTH_M = 1.0
GRAVITY_M_PER_S2 = 9.80665
TIME_STEP_S = 0.01
N_STEPS = 5000


def hamiltonian(theta_rad: float, p_theta: float) -> float:
    """
    Compute the simple pendulum Hamiltonian in joules.
    """
    kinetic = p_theta**2 / (2.0 * MASS_KG * LENGTH_M**2)
    potential = MASS_KG * GRAVITY_M_PER_S2 * LENGTH_M * (1.0 - np.cos(theta_rad))
    return kinetic + potential


def symplectic_euler_step(theta_rad: float, p_theta: float) -> tuple[float, float]:
    """
    Advance one step using the symplectic Euler method.
    """
    p_next = (
        p_theta
        - TIME_STEP_S
        * MASS_KG
        * GRAVITY_M_PER_S2
        * LENGTH_M
        * np.sin(theta_rad)
    )

    theta_next = theta_rad + TIME_STEP_S * p_next / (MASS_KG * LENGTH_M**2)
    theta_next = (theta_next + np.pi) % (2.0 * np.pi) - np.pi

    return theta_next, p_next


def main() -> None:
    """
    Integrate pendulum motion and save trajectory diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_hamiltonian_pendulum_symplectic.csv"
    summary_path = article_dir / "data" / "computed_hamiltonian_pendulum_summary.csv"

    theta = 1.0
    p_theta = 0.0
    initial_energy = hamiltonian(theta, p_theta)

    rows = []

    for step in range(N_STEPS + 1):
        energy = hamiltonian(theta, p_theta)

        rows.append(
            {
                "step": step,
                "time_s": step * TIME_STEP_S,
                "theta_rad": theta,
                "p_theta_kg_m2_per_s": p_theta,
                "hamiltonian_j": energy,
                "energy_error_j": energy - initial_energy,
                "relative_energy_error": (energy - initial_energy) / initial_energy,
            }
        )

        theta, p_theta = symplectic_euler_step(theta, p_theta)

    trajectory = pd.DataFrame(rows)

    summary = pd.DataFrame(
        [
            {
                "initial_energy_j": initial_energy,
                "final_energy_j": trajectory["hamiltonian_j"].iloc[-1],
                "max_abs_energy_error_j": trajectory["energy_error_j"].abs().max(),
                "max_abs_relative_energy_error":
                    trajectory["relative_energy_error"].abs().max(),
                "final_theta_rad": trajectory["theta_rad"].iloc[-1],
                "final_p_theta_kg_m2_per_s":
                    trajectory["p_theta_kg_m2_per_s"].iloc[-1],
            }
        ]
    )

    trajectory.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Hamiltonian trajectory sample:")
    print(trajectory.head(12).round(8).to_string(index=False))
    print("\nEnergy diagnostic summary:")
    print(summary.round(10).to_string(index=False))
    print(f"\nSaved trajectory to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

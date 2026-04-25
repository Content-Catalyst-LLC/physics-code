"""
Discretized Euclidean Path Actions

This workflow computes Euclidean harmonic oscillator actions for
deterministic sample paths.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def generate_path(path_type: str, amplitude: float, roughness_multiplier: float, tau: np.ndarray, beta: float) -> np.ndarray:
    """
    Generate a sample path by name.
    """
    if path_type == "zero":
        return np.zeros_like(tau)

    if path_type == "sine":
        return amplitude * np.sin(2.0 * np.pi * tau / beta)

    if path_type == "sine_plus_harmonic":
        return amplitude * np.sin(2.0 * np.pi * tau / beta) + roughness_multiplier * np.sin(
            10.0 * np.pi * tau / beta
        )

    raise ValueError(f"Unsupported path_type: {path_type}")


def action_components(path: np.ndarray, mass: float, omega: float, delta_tau: float) -> tuple[float, float, float]:
    """
    Compute kinetic, potential, and total Euclidean action.
    """
    shifted = np.roll(path, -1)

    kinetic = float(np.sum(mass / (2.0 * delta_tau) * (shifted - path) ** 2))
    potential = float(np.sum(0.5 * delta_tau * mass * omega**2 * path**2))

    return kinetic, potential, kinetic + potential


def main() -> None:
    """
    Compute deterministic sample path action summaries.
    """
    article_dir = Path(__file__).resolve().parents[1]
    path_cases_path = article_dir / "data" / "sample_path_cases.csv"
    output_path = article_dir / "data" / "computed_discretized_path_actions.csv"

    beta = 4.0
    n_steps = 100
    delta_tau = beta / n_steps
    mass = 1.0
    omega = 1.0
    hbar = 1.0

    tau = np.arange(n_steps) * delta_tau
    path_cases = pd.read_csv(path_cases_path)

    rows = []

    for _, case in path_cases.iterrows():
        path = generate_path(
            path_type=case["path_type"],
            amplitude=float(case["amplitude"]),
            roughness_multiplier=float(case["roughness_multiplier"]),
            tau=tau,
            beta=beta,
        )

        kinetic, potential, total = action_components(path, mass, omega, delta_tau)

        rows.append(
            {
                "path_name": case["path_name"],
                "path_type": case["path_type"],
                "kinetic_action": kinetic,
                "potential_action": potential,
                "euclidean_action": total,
                "path_weight": np.exp(-total / hbar),
                "mean_x": float(np.mean(path)),
                "mean_x_squared": float(np.mean(path**2)),
                "notes": case["notes"],
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Discretized path action summaries:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

"""
Euclidean Harmonic Oscillator Path-Integral Monte Carlo

This workflow samples paths with weight:

    exp(-S_E / hbar)

where:

    S_E = sum_n [
        m / (2 Delta tau) * (x[n+1] - x[n])^2
        + Delta tau / 2 * m * omega^2 * x[n]^2
    ]

Periodic boundary conditions are used in imaginary time.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def local_action(path: np.ndarray, index: int, mass: float, omega: float, delta_tau: float) -> float:
    """
    Compute the local action contribution affected by one site.
    """
    n = len(path)
    x_prev = path[(index - 1) % n]
    x_curr = path[index]
    x_next = path[(index + 1) % n]

    kinetic_left = mass / (2.0 * delta_tau) * (x_curr - x_prev) ** 2
    kinetic_right = mass / (2.0 * delta_tau) * (x_next - x_curr) ** 2
    potential = 0.5 * delta_tau * mass * omega**2 * x_curr**2

    return kinetic_left + kinetic_right + potential


def total_action(path: np.ndarray, mass: float, omega: float, delta_tau: float) -> float:
    """
    Compute the full discretized Euclidean action.
    """
    shifted = np.roll(path, -1)

    kinetic_terms = mass / (2.0 * delta_tau) * (shifted - path) ** 2
    potential_terms = 0.5 * delta_tau * mass * omega**2 * path**2

    return float(np.sum(kinetic_terms + potential_terms))


def metropolis_sweep(
    path: np.ndarray,
    mass: float,
    omega: float,
    hbar: float,
    delta_tau: float,
    proposal_width: float,
    rng: np.random.Generator,
) -> int:
    """
    Perform one local Metropolis sweep.
    """
    accepted = 0
    n = len(path)

    for _ in range(n):
        index = rng.integers(0, n)

        old_value = path[index]
        old_action = local_action(path, index, mass, omega, delta_tau)

        path[index] = old_value + rng.normal(0.0, proposal_width)
        new_action = local_action(path, index, mass, omega, delta_tau)

        delta_action = new_action - old_action

        if delta_action <= 0.0:
            accepted += 1
        else:
            if rng.random() < np.exp(-delta_action / hbar):
                accepted += 1
            else:
                path[index] = old_value

    return accepted


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Run one Euclidean harmonic oscillator path Monte Carlo case.
    """
    mass = float(case["mass"])
    omega = float(case["omega"])
    hbar = float(case["hbar"])
    beta = float(case["beta"])
    n_steps = int(case["n_steps"])
    delta_tau = beta / n_steps
    proposal_width = float(case["proposal_width"])

    rng = np.random.default_rng(int(case["random_seed"]))
    path = np.zeros(n_steps, dtype=float)

    for _ in range(int(case["n_thermalization_sweeps"])):
        metropolis_sweep(path, mass, omega, hbar, delta_tau, proposal_width, rng)

    rows = []

    for sweep in range(int(case["n_measurement_sweeps"])):
        accepted = metropolis_sweep(path, mass, omega, hbar, delta_tau, proposal_width, rng)

        rows.append(
            {
                "case_id": case["case_id"],
                "sweep": sweep,
                "mass": mass,
                "omega": omega,
                "hbar": hbar,
                "beta": beta,
                "n_steps": n_steps,
                "delta_tau": delta_tau,
                "euclidean_action": total_action(path, mass, omega, delta_tau),
                "mean_x": float(np.mean(path)),
                "mean_x_squared": float(np.mean(path**2)),
                "acceptance_rate": accepted / n_steps,
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run all configured Euclidean oscillator Monte Carlo cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "euclidean_oscillator_cases.csv"
    output_path = article_dir / "data" / "computed_euclidean_oscillator_monte_carlo.csv"
    summary_path = article_dir / "data" / "computed_euclidean_oscillator_monte_carlo_summary.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    summary = (
        output.groupby("case_id", as_index=False)
        .agg(
            mean_action=("euclidean_action", "mean"),
            sd_action=("euclidean_action", "std"),
            mean_x=("mean_x", "mean"),
            mean_x_squared=("mean_x_squared", "mean"),
            mean_acceptance_rate=("acceptance_rate", "mean"),
            n_measurements=("sweep", "count"),
        )
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Euclidean oscillator Monte Carlo summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

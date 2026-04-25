"""
Two-State System: Exact Distribution, Partition Function, and Monte Carlo

This workflow connects core statistical-physics concepts:

1. Multiplicity:
       W(n) = N! / [n!(N-n)!]

2. Canonical statistical weight:
       W(n) * exp(-beta * n * epsilon)

3. Single-particle partition function:
       Z_1 = 1 + exp(-beta * epsilon)

4. Excited-state probability:
       p_exc = exp(-beta * epsilon) / Z_1

5. Monte Carlo sampling:
       n_excited ~ Binomial(N, p_exc)
"""

from __future__ import annotations

from math import lgamma
from pathlib import Path

import numpy as np
import pandas as pd


BOLTZMANN_CONSTANT_J_PER_K = 1.380_649e-23


def log_combination(n_total: int, n_selected: np.ndarray) -> np.ndarray:
    """
    Compute log binomial coefficients using log-gamma functions.
    """
    return np.array(
        [
            lgamma(n_total + 1) - lgamma(n + 1) - lgamma(n_total - n + 1)
            for n in n_selected
        ]
    )


def exact_macrostate_distribution(
    n_total: int,
    temperature_k: float,
    excitation_energy_j: float,
) -> pd.DataFrame:
    """
    Compute exact canonical macrostate distribution for a two-state model.
    """
    beta = 1.0 / (BOLTZMANN_CONSTANT_J_PER_K * temperature_k)
    n_excited = np.arange(n_total + 1)

    log_weights = (
        log_combination(n_total, n_excited)
        - beta * n_excited * excitation_energy_j
    )

    shifted_weights = np.exp(log_weights - np.max(log_weights))
    probabilities = shifted_weights / shifted_weights.sum()

    return pd.DataFrame(
        {
            "N": n_total,
            "temperature_k": temperature_k,
            "excitation_energy_j": excitation_energy_j,
            "n_excited": n_excited,
            "energy_j": n_excited * excitation_energy_j,
            "probability": probabilities,
        }
    )


def thermodynamic_summary(
    n_total: int,
    temperature_k: float,
    excitation_energy_j: float,
    n_samples: int = 100_000,
    random_seed: int = 42,
) -> pd.DataFrame:
    """
    Compare exact results with Monte Carlo sampling.
    """
    beta = 1.0 / (BOLTZMANN_CONSTANT_J_PER_K * temperature_k)
    z_one_particle = 1.0 + np.exp(-beta * excitation_energy_j)
    p_excited = np.exp(-beta * excitation_energy_j) / z_one_particle

    distribution = exact_macrostate_distribution(
        n_total=n_total,
        temperature_k=temperature_k,
        excitation_energy_j=excitation_energy_j,
    )

    exact_mean_n = float(np.sum(distribution["n_excited"] * distribution["probability"]))
    exact_var_n = float(
        np.sum((distribution["n_excited"] - exact_mean_n) ** 2 * distribution["probability"])
    )

    rng = np.random.default_rng(random_seed)
    samples = rng.binomial(n_total, p_excited, size=n_samples)

    mean_single_particle_energy = excitation_energy_j * p_excited
    free_energy_single_particle = (
        -BOLTZMANN_CONSTANT_J_PER_K * temperature_k * np.log(z_one_particle)
    )

    return pd.DataFrame(
        [
            {
                "N": n_total,
                "temperature_k": temperature_k,
                "excitation_energy_j": excitation_energy_j,
                "single_particle_partition_function": z_one_particle,
                "excited_state_probability": p_excited,
                "mean_single_particle_energy_j": mean_single_particle_energy,
                "free_energy_single_particle_j": free_energy_single_particle,
                "exact_mean_n": exact_mean_n,
                "exact_sd_n": np.sqrt(exact_var_n),
                "monte_carlo_mean_n": float(samples.mean()),
                "monte_carlo_sd_n": float(samples.std(ddof=0)),
                "relative_fluctuation_exact": np.sqrt(exact_var_n) / exact_mean_n,
            }
        ]
    )


def main() -> None:
    """
    Run exact and Monte Carlo two-state workflows.
    """
    article_dir = Path(__file__).resolve().parents[1]
    distribution_output = article_dir / "data" / "computed_two_state_distribution.csv"
    summary_output = article_dir / "data" / "computed_two_state_summary.csv"

    n_total = 100
    temperature_k = 300.0
    excitation_energy_j = 2.0e-21

    distribution = exact_macrostate_distribution(
        n_total=n_total,
        temperature_k=temperature_k,
        excitation_energy_j=excitation_energy_j,
    )

    summary = thermodynamic_summary(
        n_total=n_total,
        temperature_k=temperature_k,
        excitation_energy_j=excitation_energy_j,
    )

    distribution.to_csv(distribution_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Exact macrostate distribution sample:")
    print(distribution.head(12).to_string(index=False))

    print("\nThermodynamic and Monte Carlo summary:")
    print(summary.to_string(index=False))

    print(f"\nSaved distribution to: {distribution_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()

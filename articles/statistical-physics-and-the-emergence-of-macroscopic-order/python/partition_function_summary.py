"""
Two-State Partition Function Summary

This workflow evaluates the one-particle two-state partition function:

    Z = 1 + exp(-beta epsilon)

and derived quantities across temperature.

Derived quantities:
    p_exc = exp(-beta epsilon) / Z
    <E> = epsilon * p_exc
    F = -k_B T ln Z
"""

from pathlib import Path

import numpy as np
import pandas as pd


K_B = 1.380_649e-23


def two_state_quantities(temperature_k: np.ndarray, excitation_energy_j: float) -> pd.DataFrame:
    """
    Compute two-state canonical quantities over temperature.
    """
    beta = 1.0 / (K_B * temperature_k)
    boltzmann_factor = np.exp(-beta * excitation_energy_j)
    partition_function = 1.0 + boltzmann_factor
    p_excited = boltzmann_factor / partition_function
    mean_energy = excitation_energy_j * p_excited
    free_energy = -K_B * temperature_k * np.log(partition_function)

    return pd.DataFrame(
        {
            "temperature_k": temperature_k,
            "beta_per_joule": beta,
            "partition_function": partition_function,
            "excited_state_probability": p_excited,
            "mean_energy_j": mean_energy,
            "free_energy_j": free_energy,
        }
    )


def main() -> None:
    """
    Generate a temperature sweep for the two-state partition function.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_partition_function_temperature_sweep.csv"

    temperature_k = np.linspace(50.0, 1000.0, 300)
    excitation_energy_j = 2.0e-21

    table = two_state_quantities(temperature_k, excitation_energy_j)
    table.to_csv(output_path, index=False)

    print("Two-state partition-function temperature sweep:")
    print(table.head(12).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()

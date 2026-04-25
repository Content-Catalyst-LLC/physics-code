"""
Lorentz Transformation and Spacetime Interval Invariance

This workflow demonstrates:

1. Lorentz factor:
       gamma = 1 / sqrt(1 - beta^2)

2. Lorentz transformation for motion along x:
       ct' = gamma * (ct - beta*x)
       x'  = gamma * (x - beta*ct)

3. Spacetime interval invariance:
       s^2 = ct^2 - x^2 - y^2 - z^2

Coordinates use compatible length units: ct, x, y, and z.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def lorentz_factor(beta: float) -> float:
    """
    Compute the Lorentz factor.
    """
    if abs(beta) >= 1:
        raise ValueError("beta must satisfy |beta| < 1.")

    return 1.0 / np.sqrt(1.0 - beta**2)


def lorentz_transform_x(event_table: pd.DataFrame, beta: float) -> pd.DataFrame:
    """
    Apply a Lorentz transformation for motion along the x-axis.
    """
    gamma = lorentz_factor(beta)

    transformed = event_table.copy()
    transformed["ct_prime"] = gamma * (event_table["ct"] - beta * event_table["x"])
    transformed["x_prime"] = gamma * (event_table["x"] - beta * event_table["ct"])
    transformed["y_prime"] = event_table["y"]
    transformed["z_prime"] = event_table["z"]

    return transformed


def spacetime_interval_squared(ct: np.ndarray, x: np.ndarray, y: np.ndarray, z: np.ndarray) -> np.ndarray:
    """
    Compute flat-spacetime interval squared using signature (+---).
    """
    return ct**2 - x**2 - y**2 - z**2


def main() -> None:
    """
    Transform sample events and verify interval invariance.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "event_examples.csv"
    output_path = article_dir / "data" / "computed_lorentz_transformed_events.csv"

    beta = 0.8

    events = pd.read_csv(input_path)
    transformed = lorentz_transform_x(events, beta)

    transformed["interval_original"] = spacetime_interval_squared(
        transformed["ct"].to_numpy(),
        transformed["x"].to_numpy(),
        transformed["y"].to_numpy(),
        transformed["z"].to_numpy(),
    )

    transformed["interval_transformed"] = spacetime_interval_squared(
        transformed["ct_prime"].to_numpy(),
        transformed["x_prime"].to_numpy(),
        transformed["y_prime"].to_numpy(),
        transformed["z_prime"].to_numpy(),
    )

    transformed["interval_difference"] = (
        transformed["interval_transformed"] - transformed["interval_original"]
    )

    transformed["beta"] = beta
    transformed["gamma"] = lorentz_factor(beta)

    transformed.to_csv(output_path, index=False)

    print(f"beta = {beta}")
    print(f"gamma = {lorentz_factor(beta):.8f}")
    print("\nLorentz-transformed event table:")
    print(transformed.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()

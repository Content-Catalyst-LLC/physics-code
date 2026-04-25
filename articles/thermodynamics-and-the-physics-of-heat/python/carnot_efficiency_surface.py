"""
Carnot Efficiency Surface

This workflow computes the ideal Carnot efficiency:

    eta = 1 - Tc/Th

for grids of hot- and cold-reservoir temperatures.

It is an upper-bound scaffold, not a real-engine performance model.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def carnot_efficiency(hot_temperature_k: np.ndarray, cold_temperature_k: np.ndarray) -> np.ndarray:
    """
    Compute Carnot efficiency for valid reservoir temperature pairs.
    """
    efficiency = 1.0 - cold_temperature_k / hot_temperature_k
    efficiency = np.where(hot_temperature_k > cold_temperature_k, efficiency, np.nan)

    return efficiency


def main() -> None:
    """
    Generate a Carnot efficiency grid.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_carnot_efficiency_surface.csv"

    hot_temperatures = np.linspace(350.0, 1200.0, 100)
    cold_temperatures = np.linspace(250.0, 500.0, 100)

    hot_grid, cold_grid = np.meshgrid(hot_temperatures, cold_temperatures)

    table = pd.DataFrame(
        {
            "hot_temperature_k": hot_grid.ravel(),
            "cold_temperature_k": cold_grid.ravel(),
            "carnot_efficiency": carnot_efficiency(hot_grid, cold_grid).ravel(),
        }
    ).dropna()

    table.to_csv(output_path, index=False)

    print("Carnot efficiency surface sample:")
    print(table.head(12).round(6).to_string(index=False))
    print(f"\nSaved Carnot surface to: {output_path}")


if __name__ == "__main__":
    main()

"""
Free-Energy Surface Scaffold

This workflow creates a simple illustrative Gibbs free-energy relation:

    G(T, P) = G0 - S0 (T - T0) + V0 (P - P0)

This is not a real-material equation of state. It is a scaffold for thinking
about how thermodynamic potentials change with temperature and pressure.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def gibbs_free_energy_linear(
    temperature_k: np.ndarray,
    pressure_pa: np.ndarray,
    g0_j_per_mol: float,
    t0_k: float,
    p0_pa: float,
    entropy_j_per_mol_k: float,
    molar_volume_m3_per_mol: float,
) -> np.ndarray:
    """
    Compute a linearized Gibbs free-energy scaffold.
    """
    return (
        g0_j_per_mol
        - entropy_j_per_mol_k * (temperature_k - t0_k)
        + molar_volume_m3_per_mol * (pressure_pa - p0_pa)
    )


def main() -> None:
    """
    Generate a simple free-energy surface table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_free_energy_surface.csv"

    temperature_values = np.linspace(250.0, 450.0, 80)
    pressure_values = np.linspace(80_000.0, 200_000.0, 80)

    temperature_grid, pressure_grid = np.meshgrid(temperature_values, pressure_values)

    g_values = gibbs_free_energy_linear(
        temperature_k=temperature_grid,
        pressure_pa=pressure_grid,
        g0_j_per_mol=-10_000.0,
        t0_k=298.15,
        p0_pa=101_325.0,
        entropy_j_per_mol_k=100.0,
        molar_volume_m3_per_mol=1.0e-5,
    )

    table = pd.DataFrame(
        {
            "temperature_k": temperature_grid.ravel(),
            "pressure_pa": pressure_grid.ravel(),
            "gibbs_free_energy_j_per_mol": g_values.ravel(),
        }
    )

    table.to_csv(output_path, index=False)

    print("Free-energy surface sample:")
    print(table.head(12).round(6).to_string(index=False))
    print(f"\nSaved free-energy surface to: {output_path}")


if __name__ == "__main__":
    main()

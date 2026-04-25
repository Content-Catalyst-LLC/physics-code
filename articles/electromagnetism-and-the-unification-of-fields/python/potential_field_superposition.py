"""
Electric Potential Grids and Field Superposition

This workflow demonstrates:

1. Electric potential from point charges:
       V = q / (4*pi*epsilon0*r)

2. Electric field from potential:
       E = -grad(V)

3. Dipole-style superposition.

The workflow writes reusable CSV summaries for article, notebook, and
dashboard work.
"""

from pathlib import Path

import numpy as np
import pandas as pd


EPSILON0 = 8.854_187_8188e-12
COULOMB_CONSTANT = 1.0 / (4.0 * np.pi * EPSILON0)


def point_charge_potential(
    x_grid: np.ndarray,
    y_grid: np.ndarray,
    charge_c: float,
    charge_x_m: float,
    charge_y_m: float,
    softening_m: float = 0.02,
) -> np.ndarray:
    """
    Compute electric potential from a point charge on a 2D grid.
    """
    radius_m = np.sqrt((x_grid - charge_x_m) ** 2 + (y_grid - charge_y_m) ** 2)
    radius_m = np.maximum(radius_m, softening_m)

    return COULOMB_CONSTANT * charge_c / radius_m


def electric_field_from_potential(
    potential_v: np.ndarray,
    x_m: np.ndarray,
    y_m: np.ndarray,
) -> tuple[np.ndarray, np.ndarray]:
    """
    Compute electric-field components from a scalar potential grid.
    """
    d_v_dy, d_v_dx = np.gradient(potential_v, y_m, x_m)

    electric_field_x = -d_v_dx
    electric_field_y = -d_v_dy

    return electric_field_x, electric_field_y


def summarize_field(
    label: str,
    potential_v: np.ndarray,
    electric_field_x: np.ndarray,
    electric_field_y: np.ndarray,
) -> dict:
    """
    Summarize potential and field magnitude for a configuration.
    """
    field_magnitude = np.sqrt(electric_field_x**2 + electric_field_y**2)

    return {
        "configuration": label,
        "potential_min_v": float(np.min(potential_v)),
        "potential_max_v": float(np.max(potential_v)),
        "field_magnitude_mean": float(np.mean(field_magnitude)),
        "field_magnitude_max": float(np.max(field_magnitude)),
    }


def main() -> None:
    """
    Compute point-charge and dipole-style potential/field summaries.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_potential_field_summaries.csv"

    x_m = np.linspace(-1.0, 1.0, 250)
    y_m = np.linspace(-1.0, 1.0, 250)
    x_grid, y_grid = np.meshgrid(x_m, y_m)

    charge_c = 1e-9

    point_potential = point_charge_potential(
        x_grid=x_grid,
        y_grid=y_grid,
        charge_c=charge_c,
        charge_x_m=0.0,
        charge_y_m=0.0,
    )
    point_ex, point_ey = electric_field_from_potential(point_potential, x_m, y_m)

    dipole_potential = (
        point_charge_potential(x_grid, y_grid, charge_c, 0.2, 0.0)
        + point_charge_potential(x_grid, y_grid, -charge_c, -0.2, 0.0)
    )
    dipole_ex, dipole_ey = electric_field_from_potential(dipole_potential, x_m, y_m)

    summary = pd.DataFrame(
        [
            summarize_field("single_point_charge", point_potential, point_ex, point_ey),
            summarize_field("dipole_style_pair", dipole_potential, dipole_ex, dipole_ey),
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Electrostatic potential and field summaries:")
    print(summary.to_string(index=False))
    print(f"\nSaved summaries to: {output_path}")


if __name__ == "__main__":
    main()

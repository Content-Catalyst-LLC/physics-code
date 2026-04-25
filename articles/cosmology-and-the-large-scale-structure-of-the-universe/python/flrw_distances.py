"""
FLRW Expansion and Distance-Redshift Relations

This workflow computes E(z), H(z), comoving distance, angular diameter distance,
and luminosity distance for a flat Lambda-CDM cosmology.

It uses a transparent trapezoid rule and is intended as a teaching scaffold.
"""

from pathlib import Path

import numpy as np
import pandas as pd


C_KM_S = 299792.458


def load_parameters(article_dir: Path) -> dict:
    """
    Load cosmological parameters from CSV into a dictionary.
    """
    table = pd.read_csv(article_dir / "data" / "cosmology_parameters.csv")
    return dict(zip(table["parameter"], table["value"]))


def e_z(redshift: np.ndarray | float, omega_m: float, omega_lambda: float) -> np.ndarray | float:
    """
    Dimensionless expansion function for flat Lambda-CDM.
    """
    return np.sqrt(omega_m * (1.0 + redshift) ** 3 + omega_lambda)


def comoving_distance(redshift: float, h0: float, omega_m: float, omega_lambda: float) -> float:
    """
    Compute comoving radial distance in Mpc using trapezoid integration.
    """
    if redshift == 0:
        return 0.0

    z_grid = np.linspace(0.0, redshift, 6000)
    integrand = 1.0 / e_z(z_grid, omega_m, omega_lambda)
    integral = np.trapz(integrand, z_grid)

    return (C_KM_S / h0) * integral


def main() -> None:
    """
    Compute and save a redshift-distance table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    params = load_parameters(article_dir)

    h0 = float(params["H0"])
    omega_m = float(params["Omega_m"])
    omega_lambda = float(params["Omega_lambda"])

    redshift_table = pd.read_csv(article_dir / "data" / "redshift_grid.csv")

    rows = []

    for _, row in redshift_table.iterrows():
        z = float(row["redshift"])
        chi = comoving_distance(z, h0, omega_m, omega_lambda)

        rows.append(
            {
                "redshift": z,
                "scale_factor": 1.0 / (1.0 + z),
                "E_z": e_z(z, omega_m, omega_lambda),
                "H_z_km_s_mpc": h0 * e_z(z, omega_m, omega_lambda),
                "comoving_distance_mpc": chi,
                "angular_diameter_distance_mpc": chi / (1.0 + z),
                "luminosity_distance_mpc": chi * (1.0 + z),
                "notes": row["notes"],
            }
        )

    output = pd.DataFrame(rows)
    output_path = article_dir / "data" / "computed_flrw_distances.csv"
    output.to_csv(output_path, index=False)

    print("FLRW distance-redshift table:")
    print(output.round(6).to_string(index=False))


if __name__ == "__main__":
    main()

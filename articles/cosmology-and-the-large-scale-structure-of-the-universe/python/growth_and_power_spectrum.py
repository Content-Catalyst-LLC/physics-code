"""
Linear Growth and Toy Matter Power Spectrum

This workflow demonstrates:
1. a growth-index approximation to linear structure growth
2. a toy matter power spectrum with transfer suppression and BAO-like wiggles

This is not a replacement for CAMB, CLASS, or survey likelihood pipelines.
"""

from pathlib import Path

import numpy as np
import pandas as pd


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


def omega_m_z(redshift: np.ndarray | float, omega_m: float, omega_lambda: float) -> np.ndarray | float:
    """
    Matter density fraction as a function of redshift.
    """
    return omega_m * (1.0 + redshift) ** 3 / e_z(redshift, omega_m, omega_lambda) ** 2


def approximate_growth_factor(redshift_values: np.ndarray, omega_m: float, omega_lambda: float) -> np.ndarray:
    """
    Approximate growth factor using growth-index f ≈ Omega_m(z)^0.55.
    Normalized to D(z=0)=1.
    """
    max_z = float(np.max(redshift_values))
    z_grid = np.linspace(0.0, max_z, 3000)

    gamma = 0.55
    f_grid = omega_m_z(z_grid, omega_m, omega_lambda) ** gamma
    dln1pz = np.gradient(np.log(1.0 + z_grid))
    ln_growth = -np.cumsum(f_grid * dln1pz)
    growth_grid = np.exp(ln_growth)
    growth_grid /= growth_grid[0]

    return np.interp(redshift_values, z_grid, growth_grid)


def toy_transfer_function(k_h_mpc: np.ndarray) -> np.ndarray:
    """
    Smooth toy transfer suppression.
    """
    equality_scale = 0.02
    return 1.0 / (1.0 + (k_h_mpc / equality_scale) ** 2)


def toy_bao_wiggle(k_h_mpc: np.ndarray) -> np.ndarray:
    """
    Damped BAO-like oscillatory feature.
    """
    sound_horizon_mpc_h = 105.0
    damping_scale = 0.18

    return 1.0 + 0.06 * np.sin(k_h_mpc * sound_horizon_mpc_h) * np.exp(
        -(k_h_mpc / damping_scale) ** 2
    )


def main() -> None:
    """
    Compute approximate growth and toy matter power-spectrum tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    params = load_parameters(article_dir)

    omega_m = float(params["Omega_m"])
    omega_lambda = float(params["Omega_lambda"])
    n_s = float(params["n_s"])
    sigma8_like = float(params["sigma8"])

    redshifts = pd.read_csv(article_dir / "data" / "redshift_grid.csv")["redshift"].to_numpy()
    growth = approximate_growth_factor(redshifts, omega_m, omega_lambda)

    growth_table = pd.DataFrame(
        {
            "redshift": redshifts,
            "scale_factor": 1.0 / (1.0 + redshifts),
            "E_z": e_z(redshifts, omega_m, omega_lambda),
            "omega_m_z": omega_m_z(redshifts, omega_m, omega_lambda),
            "growth_factor_approx": growth,
        }
    )

    k_values = np.logspace(-3, 0, 200)

    spectrum_rows = []
    for z in [0.0, 1.0, 3.0]:
        d_z = approximate_growth_factor(np.array([z]), omega_m, omega_lambda)[0]
        toy_power = (
            sigma8_like
            * k_values**n_s
            * toy_transfer_function(k_values) ** 2
            * toy_bao_wiggle(k_values)
            * d_z**2
        )

        for k, p in zip(k_values, toy_power):
            spectrum_rows.append(
                {
                    "redshift": z,
                    "wavenumber_h_mpc": k,
                    "toy_power": p,
                }
            )

    spectrum_table = pd.DataFrame(spectrum_rows)

    growth_table.to_csv(article_dir / "data" / "computed_growth_table.csv", index=False)
    spectrum_table.to_csv(article_dir / "data" / "computed_toy_power_spectrum.csv", index=False)

    print("Growth table:")
    print(growth_table.round(6).to_string(index=False))

    print("\nToy matter power spectrum sample:")
    print(spectrum_table.groupby("redshift").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

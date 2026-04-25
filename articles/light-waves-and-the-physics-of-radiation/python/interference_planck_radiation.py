"""
Double-Slit Interference and Planck Radiation

This workflow demonstrates two foundational models:

1. Double-slit interference:
       I(y) = cos^2(pi*d*sin(theta)/lambda)

2. Planck spectral radiance:
       B_lambda(T) = (2*h*c^2/lambda^5) / (exp(h*c/(lambda*kB*T)) - 1)

The code writes reusable CSV outputs for article, notebook, and dashboard work.
"""

from pathlib import Path

import numpy as np
import pandas as pd


PLANCK_CONSTANT = 6.626_070_15e-34
SPEED_OF_LIGHT = 299_792_458.0
BOLTZMANN_CONSTANT = 1.380_649e-23
WIEN_DISPLACEMENT_CONSTANT = 2.897_771_955e-3
STEFAN_BOLTZMANN_CONSTANT = 5.670_374_419e-8


def double_slit_intensity(
    screen_position_m: np.ndarray,
    wavelength_m: float,
    slit_separation_m: float,
    screen_distance_m: float,
) -> np.ndarray:
    """
    Compute a simple double-slit interference intensity pattern.
    """
    theta = np.arctan(screen_position_m / screen_distance_m)
    phase_argument = np.pi * slit_separation_m * np.sin(theta) / wavelength_m

    return np.cos(phase_argument) ** 2


def planck_lambda(wavelength_m: np.ndarray, temperature_k: float) -> np.ndarray:
    """
    Compute Planck spectral radiance by wavelength.
    """
    numerator = 2.0 * PLANCK_CONSTANT * SPEED_OF_LIGHT**2
    exponent = PLANCK_CONSTANT * SPEED_OF_LIGHT / (
        wavelength_m * BOLTZMANN_CONSTANT * temperature_k
    )
    denominator = wavelength_m**5 * np.expm1(exponent)

    return numerator / denominator


def main() -> None:
    """
    Compute double-slit and blackbody output tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    interference_output = article_dir / "data" / "computed_double_slit_interference.csv"
    blackbody_output = article_dir / "data" / "computed_blackbody_5800k.csv"
    summary_output = article_dir / "data" / "computed_radiation_summary.csv"

    screen_position_m = np.linspace(-0.02, 0.02, 2000)

    interference = pd.DataFrame(
        {
            "screen_position_m": screen_position_m,
            "relative_intensity": double_slit_intensity(
                screen_position_m=screen_position_m,
                wavelength_m=550e-9,
                slit_separation_m=0.2e-3,
                screen_distance_m=1.5,
            ),
        }
    )
    interference["screen_position_mm"] = interference["screen_position_m"] * 1000

    wavelength_grid_m = np.linspace(100e-9, 3000e-9, 1000)
    temperature_k = 5800.0

    blackbody = pd.DataFrame(
        {
            "wavelength_m": wavelength_grid_m,
            "wavelength_nm": wavelength_grid_m * 1e9,
            "spectral_radiance": planck_lambda(wavelength_grid_m, temperature_k),
        }
    )

    peak_row = blackbody.loc[blackbody["spectral_radiance"].idxmax()]
    wien_peak_m = WIEN_DISPLACEMENT_CONSTANT / temperature_k
    total_exitance = STEFAN_BOLTZMANN_CONSTANT * temperature_k**4

    summary = pd.DataFrame(
        [
            {
                "temperature_k": temperature_k,
                "numerical_peak_wavelength_nm": peak_row["wavelength_nm"],
                "wien_peak_wavelength_nm": wien_peak_m * 1e9,
                "stefan_boltzmann_exitance_w_m2": total_exitance,
            }
        ]
    )

    interference.to_csv(interference_output, index=False)
    blackbody.to_csv(blackbody_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Double-slit interference sample:")
    print(interference.head(12).round(8).to_string(index=False))

    print("\nBlackbody sample:")
    print(blackbody.head(12).round(8).to_string(index=False))

    print("\nRadiation summary:")
    print(summary.round(8).to_string(index=False))

    print(f"\nSaved interference table to: {interference_output}")
    print(f"Saved blackbody table to: {blackbody_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()

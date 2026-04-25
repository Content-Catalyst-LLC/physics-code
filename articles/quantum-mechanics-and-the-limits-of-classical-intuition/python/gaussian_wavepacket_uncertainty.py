"""
Gaussian Wave Packet and Position Uncertainty

This workflow samples a normalized one-dimensional Gaussian probability
density and estimates the expectation value and uncertainty in position.

The goal is to provide a compact computational bridge to uncertainty.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def gaussian_wavefunction(x_m: np.ndarray, center_m: float, sigma_m: float) -> np.ndarray:
    """
    Compute a normalized real Gaussian wavefunction.

    The probability density has width controlled by sigma_m.
    """
    normalization = (1.0 / (2.0 * np.pi * sigma_m**2)) ** 0.25
    exponent = -((x_m - center_m) ** 2) / (4.0 * sigma_m**2)

    return normalization * np.exp(exponent)


def main() -> None:
    """
    Estimate position expectation and uncertainty for Gaussian packets.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_gaussian_uncertainty.csv"

    x_m = np.linspace(-5.0e-9, 5.0e-9, 5000)

    rows = []

    for sigma_m in [0.25e-9, 0.5e-9, 1.0e-9]:
        psi = gaussian_wavefunction(x_m, center_m=0.0, sigma_m=sigma_m)
        probability_density = psi**2

        normalization = float(np.trapz(probability_density, x_m))
        mean_x_m = float(np.trapz(x_m * probability_density, x_m))
        mean_x2_m2 = float(np.trapz((x_m**2) * probability_density, x_m))
        uncertainty_x_m = float(np.sqrt(mean_x2_m2 - mean_x_m**2))

        rows.append(
            {
                "sigma_input_m": sigma_m,
                "normalization_check": normalization,
                "expectation_x_m": mean_x_m,
                "uncertainty_x_m": uncertainty_x_m,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Gaussian wave-packet uncertainty summary:")
    print(output.to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()

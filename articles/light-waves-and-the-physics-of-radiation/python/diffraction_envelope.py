"""
Single-Slit Diffraction Envelope Scaffold

This workflow computes the idealized single-slit diffraction envelope:

    I(theta) = [sin(alpha) / alpha]^2

where:

    alpha = pi*a*sin(theta)/lambda

This is a scalar far-field teaching model, not a full electromagnetic
aperture simulation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def sinc_squared_envelope(theta_rad: np.ndarray, wavelength_m: float, slit_width_m: float) -> np.ndarray:
    """
    Compute a normalized single-slit diffraction envelope.
    """
    alpha = np.pi * slit_width_m * np.sin(theta_rad) / wavelength_m

    envelope = np.ones_like(alpha)
    nonzero = np.abs(alpha) > 1e-12
    envelope[nonzero] = (np.sin(alpha[nonzero]) / alpha[nonzero]) ** 2

    return envelope


def main() -> None:
    """
    Generate an idealized diffraction envelope table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_diffraction_envelope.csv"

    theta_rad = np.linspace(-0.05, 0.05, 2000)

    table = pd.DataFrame(
        {
            "theta_rad": theta_rad,
            "theta_mrad": theta_rad * 1000,
            "relative_intensity": sinc_squared_envelope(
                theta_rad=theta_rad,
                wavelength_m=550e-9,
                slit_width_m=0.05e-3,
            ),
        }
    )

    table.to_csv(output_path, index=False)

    print("Diffraction envelope sample:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved diffraction envelope to: {output_path}")


if __name__ == "__main__":
    main()

"""
Spectral Band Summary

This workflow loads a compact spectral-band metadata table and computes
frequency and photon-energy ranges from wavelength ranges.

It is a reproducible metadata scaffold, not a formal standards table.
"""

from pathlib import Path

import numpy as np
import pandas as pd


SPEED_OF_LIGHT = 299_792_458.0
PLANCK_CONSTANT = 6.626_070_15e-34
JOULE_PER_EV = 1.602_176_634e-19


def main() -> None:
    """
    Compute frequency and photon-energy ranges for spectral bands.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "spectral_bands.csv"
    output_path = article_dir / "data" / "computed_spectral_band_summary.csv"

    bands = pd.read_csv(input_path)

    bands["max_frequency_hz"] = SPEED_OF_LIGHT / bands["approx_min_wavelength_m"]
    bands["min_frequency_hz"] = SPEED_OF_LIGHT / bands["approx_max_wavelength_m"]

    bands["max_photon_energy_ev"] = (
        PLANCK_CONSTANT * bands["max_frequency_hz"] / JOULE_PER_EV
    )
    bands["min_photon_energy_ev"] = (
        PLANCK_CONSTANT * bands["min_frequency_hz"] / JOULE_PER_EV
    )

    bands.to_csv(output_path, index=False)

    print("Spectral band summary:")
    print(bands.to_string(index=False))
    print(f"\nSaved spectral band summary to: {output_path}")


if __name__ == "__main__":
    main()

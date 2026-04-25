"""
Spectral Line Fit Scaffold

This workflow fits a simple Gaussian line shape:

    I(lambda) = baseline + amplitude exp[-(lambda - center)^2/(2 sigma^2)]

This is a teaching scaffold. Real spectroscopy may require Voigt profiles,
instrument response, background subtraction, calibration uncertainty, and
model comparison.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.optimize import curve_fit


def gaussian(wavelength_nm, baseline, amplitude, center_nm, sigma_nm):
    """
    Gaussian spectral line model.
    """
    return baseline + amplitude * np.exp(
        -((wavelength_nm - center_nm) ** 2) / (2.0 * sigma_nm**2)
    )


def main() -> None:
    """
    Fit the synthetic spectral line sample.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "spectral_line_samples.csv"
    output_path = article_dir / "data" / "computed_spectral_line_fit.csv"

    samples = pd.read_csv(input_path)

    x = samples["wavelength_nm"].to_numpy()
    y = samples["intensity"].to_numpy()

    parameters, covariance = curve_fit(
        gaussian,
        x,
        y,
        p0=[0.1, 0.9, 656.3, 0.5],
    )

    baseline, amplitude, center_nm, sigma_nm = parameters
    fitted = gaussian(x, *parameters)
    residual = y - fitted

    output = samples.copy()
    output["fitted_intensity"] = fitted
    output["residual"] = residual
    output["fit_baseline"] = baseline
    output["fit_amplitude"] = amplitude
    output["fit_center_nm"] = center_nm
    output["fit_sigma_nm"] = sigma_nm
    output["fit_fwhm_nm"] = 2.0 * np.sqrt(2.0 * np.log(2.0)) * sigma_nm

    output.to_csv(output_path, index=False)

    print("Spectral line fit:")
    print(output.round(8).to_string(index=False))
    print(f"\nSaved fit table to: {output_path}")


if __name__ == "__main__":
    main()

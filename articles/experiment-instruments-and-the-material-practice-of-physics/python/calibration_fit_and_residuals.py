"""
Calibration Fit and Residuals

This workflow fits a simple linear calibration model:

    reference_value = slope * instrument_reading + intercept

It then computes residuals between reference values and calibrated
predictions.

This is educational scaffolding for calibration and residual analysis.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy import stats


def main() -> None:
    """
    Fit a calibration curve and save residual diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "calibration_data.csv"
    output_path = article_dir / "data" / "computed_calibration_fit.csv"

    calibration = pd.read_csv(input_path)

    fit = stats.linregress(
        calibration["instrument_reading"],
        calibration["reference_value"],
    )

    calibration["calibrated_prediction"] = (
        fit.slope * calibration["instrument_reading"] + fit.intercept
    )
    calibration["residual"] = calibration["reference_value"] - calibration["calibrated_prediction"]

    calibration["slope"] = fit.slope
    calibration["intercept"] = fit.intercept
    calibration["r_value"] = fit.rvalue
    calibration["slope_standard_error"] = fit.stderr
    calibration["intercept_standard_error"] = fit.intercept_stderr

    calibration.to_csv(output_path, index=False)

    print("Calibration fit diagnostics:")
    print(f"slope = {fit.slope:.8f}")
    print(f"intercept = {fit.intercept:.8f}")
    print(f"r_value = {fit.rvalue:.8f}")

    print("\nCalibration residual table:")
    print(calibration.round(8).to_string(index=False))
    print(f"\nSaved calibration output to: {output_path}")


if __name__ == "__main__":
    main()

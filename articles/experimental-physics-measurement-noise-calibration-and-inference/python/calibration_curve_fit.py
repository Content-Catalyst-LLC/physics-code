"""
Calibration Curve Fit

This workflow fits a linear calibration curve:

    reference_value = alpha + beta * instrument_reading + error

and saves coefficient and residual diagnostics.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy import stats


def main() -> None:
    """
    Fit a linear calibration curve and save diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "calibration_points.csv"
    augmented_path = article_dir / "data" / "computed_calibration_augmented.csv"
    summary_path = article_dir / "data" / "computed_calibration_summary.csv"

    data = pd.read_csv(input_path)

    x = data["instrument_reading_v"].to_numpy()
    y = data["reference_value_v"].to_numpy()

    result = stats.linregress(x, y)

    fitted = result.intercept + result.slope * x
    residuals = y - fitted

    augmented = data.copy()
    augmented["fitted_reference_v"] = fitted
    augmented["residual_v"] = residuals

    n = len(data)
    residual_standard_error = np.sqrt(np.sum(residuals**2) / (n - 2))

    summary = pd.DataFrame(
        [
            {
                "intercept_alpha_v": result.intercept,
                "slope_beta": result.slope,
                "r_value": result.rvalue,
                "r_squared": result.rvalue**2,
                "p_value": result.pvalue,
                "slope_standard_error": result.stderr,
                "intercept_standard_error": result.intercept_stderr,
                "residual_standard_error_v": residual_standard_error,
                "mean_residual_v": np.mean(residuals),
                "max_abs_residual_v": np.max(np.abs(residuals)),
            }
        ]
    )

    augmented.to_csv(augmented_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Calibration summary:")
    print(summary.round(10).to_string(index=False))

    print("\nCalibration augmented data:")
    print(augmented.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

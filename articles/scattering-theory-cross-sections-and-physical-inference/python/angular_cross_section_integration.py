"""
Angular Cross-Section Integration

Computes:

    sigma_total = 2 pi integral_0^pi (d sigma / d Omega)(theta) sin(theta) d theta

for:

    d sigma / d Omega = sigma_0 * (1 + alpha cos^2(theta))
"""

from pathlib import Path

import numpy as np
import pandas as pd


def compute_total_cross_section(sigma_0: float, alpha: float, n_grid: int) -> dict:
    """
    Compute numeric and analytic total cross sections.
    """
    theta = np.linspace(0.0, np.pi, n_grid)

    differential = sigma_0 * (1.0 + alpha * np.cos(theta) ** 2)
    integrand = differential * np.sin(theta)

    numeric = 2.0 * np.pi * np.trapz(integrand, theta)
    analytic = 4.0 * np.pi * sigma_0 * (1.0 + alpha / 3.0)

    return {
        "sigma_total_numeric": numeric,
        "sigma_total_analytic": analytic,
        "absolute_error": abs(numeric - analytic),
        "relative_error": abs(numeric - analytic) / analytic,
    }


def main() -> None:
    """
    Run all configured angular distribution cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "angular_distribution_cases.csv")

    rows = []

    for _, case in cases.iterrows():
        result = compute_total_cross_section(
            sigma_0=float(case["sigma_0"]),
            alpha=float(case["alpha"]),
            n_grid=int(case["n_grid"]),
        )

        result.update(
            {
                "case_id": case["case_id"],
                "sigma_0": float(case["sigma_0"]),
                "alpha": float(case["alpha"]),
                "n_grid": int(case["n_grid"]),
                "notes": case["notes"],
            }
        )

        rows.append(result)

    output = pd.DataFrame(rows)
    output.to_csv(article_dir / "data" / "computed_angular_cross_section_integration.csv", index=False)

    print("Angular cross-section integration:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()

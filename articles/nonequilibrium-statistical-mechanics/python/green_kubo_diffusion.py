"""
Green-Kubo Diffusion Scaffold

For an exponential velocity autocorrelation:

    C_v(t) = variance * exp(-t / tau)

the diffusion coefficient in one dimension is:

    D = integral_0^infinity C_v(t) dt = variance * tau

This workflow compares finite numerical integration with the analytic value.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> dict:
    """
    Compute a Green-Kubo diffusion estimate for one exponential correlation.
    """
    tau = float(case["correlation_time"])
    variance = float(case["thermal_velocity_variance"])
    n_points = int(case["n_points"])
    time_max = float(case["time_max"])

    time = np.linspace(0.0, time_max, n_points)
    correlation = variance * np.exp(-time / tau)

    diffusion_numeric = np.trapz(correlation, time)
    diffusion_analytic = variance * tau

    return {
        "case_id": case["case_id"],
        "correlation_time": tau,
        "thermal_velocity_variance": variance,
        "diffusion_numeric": diffusion_numeric,
        "diffusion_analytic": diffusion_analytic,
        "relative_error": abs(diffusion_numeric - diffusion_analytic) / diffusion_analytic,
        "notes": case["notes"],
    }


def main() -> None:
    """
    Run configured Green-Kubo examples.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "green_kubo_cases.csv")

    output = pd.DataFrame([run_case(case) for _, case in cases.iterrows()])
    output.to_csv(article_dir / "data" / "computed_green_kubo_diffusion.csv", index=False)

    print("Green-Kubo diffusion scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

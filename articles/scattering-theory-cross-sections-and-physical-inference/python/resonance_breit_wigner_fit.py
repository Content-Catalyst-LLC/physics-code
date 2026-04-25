"""
Breit-Wigner Resonance Fitting

Generates synthetic data from:

    sigma(E) = background + amplitude * (Gamma^2/4) / ((E - E_R)^2 + Gamma^2/4)

and fits the resonance parameters.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.optimize import curve_fit


def breit_wigner(energy: np.ndarray, resonance_energy: float, width: float, amplitude: float, background: float) -> np.ndarray:
    """
    Compute a simple Breit-Wigner resonance cross section.
    """
    return background + amplitude * (width**2 / 4.0) / ((energy - resonance_energy) ** 2 + width**2 / 4.0)


def generate_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate synthetic resonance data for one case.
    """
    rng = np.random.default_rng(int(case["noise_seed"]))

    energy = np.linspace(float(case["energy_min"]), float(case["energy_max"]), int(case["n_points"]))

    true_cross_section = breit_wigner(
        energy=energy,
        resonance_energy=float(case["resonance_energy"]),
        width=float(case["width"]),
        amplitude=float(case["amplitude"]),
        background=float(case["background"]),
    )

    measurement_uncertainty = 0.25 + 0.05 * true_cross_section

    observed_cross_section = rng.normal(
        loc=true_cross_section,
        scale=measurement_uncertainty,
    )

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "energy": energy,
            "observed_cross_section": observed_cross_section,
            "measurement_uncertainty": measurement_uncertainty,
            "true_cross_section": true_cross_section,
            "notes": case["notes"],
        }
    )


def fit_case(data: pd.DataFrame) -> dict:
    """
    Fit a Breit-Wigner model to one case.
    """
    initial_guess = [
        float(data.loc[data["observed_cross_section"].idxmax(), "energy"]),
        0.1,
        max(float(data["observed_cross_section"].max() - data["observed_cross_section"].min()), 1.0),
        max(float(data["observed_cross_section"].min()), 0.0),
    ]

    bounds = (
        [data["energy"].min(), 0.001, 0.0, 0.0],
        [data["energy"].max(), 2.0, 100.0, 20.0],
    )

    params, covariance = curve_fit(
        f=breit_wigner,
        xdata=data["energy"].to_numpy(),
        ydata=data["observed_cross_section"].to_numpy(),
        sigma=data["measurement_uncertainty"].to_numpy(),
        p0=initial_guess,
        bounds=bounds,
        absolute_sigma=True,
        maxfev=20000,
    )

    errors = np.sqrt(np.diag(covariance))

    return {
        "case_id": data["case_id"].iloc[0],
        "resonance_energy_estimate": params[0],
        "resonance_energy_error": errors[0],
        "width_estimate": params[1],
        "width_error": errors[1],
        "amplitude_estimate": params[2],
        "amplitude_error": errors[2],
        "background_estimate": params[3],
        "background_error": errors[3],
    }


def main() -> None:
    """
    Generate and fit all configured resonance cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "resonance_cases.csv")

    datasets = [generate_case(case) for _, case in cases.iterrows()]
    data = pd.concat(datasets, ignore_index=True)

    fit_summary = pd.DataFrame([fit_case(group) for _, group in data.groupby("case_id")])

    data.to_csv(article_dir / "data" / "computed_resonance_synthetic_data.csv", index=False)
    fit_summary.to_csv(article_dir / "data" / "computed_resonance_fit_summary.csv", index=False)

    print("Breit-Wigner resonance fit summary:")
    print(fit_summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

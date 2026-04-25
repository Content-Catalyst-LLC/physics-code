"""
Monte Carlo Uncertainty Propagation for a Reduced Climate Response Model

This workflow samples:
    - albedo
    - feedback parameter
    - CO2 concentration

and computes:
    - absorbed shortwave radiation
    - effective emission temperature
    - CO2 forcing
    - equilibrium warming
"""

from pathlib import Path

import numpy as np
import pandas as pd


SOLAR_CONSTANT_W_M2 = 1361.0
STEFAN_BOLTZMANN = 5.670374419e-8
CO2_REFERENCE_PPM = 280.0


def main() -> None:
    """
    Run Monte Carlo uncertainty propagation.
    """
    article_dir = Path(__file__).resolve().parents[1]
    samples_path = article_dir / "data" / "computed_climate_uncertainty_samples.csv"
    summary_path = article_dir / "data" / "computed_climate_uncertainty_summary.csv"

    rng = np.random.default_rng(42)
    n_samples = 20000

    albedo = np.clip(rng.normal(loc=0.30, scale=0.03, size=n_samples), 0.05, 0.90)
    feedback = np.clip(rng.normal(loc=1.2, scale=0.25, size=n_samples), 0.3, 3.0)
    co2_ppm = np.clip(rng.normal(loc=560.0, scale=40.0, size=n_samples), 280.0, 900.0)

    asr = SOLAR_CONSTANT_W_M2 * (1.0 - albedo) / 4.0
    te = (asr / STEFAN_BOLTZMANN) ** 0.25
    forcing = 5.35 * np.log(co2_ppm / CO2_REFERENCE_PPM)
    warming = forcing / feedback

    samples = pd.DataFrame(
        {
            "sample_id": np.arange(1, n_samples + 1),
            "planetary_albedo": albedo,
            "feedback_parameter_w_m2_k": feedback,
            "co2_ppm": co2_ppm,
            "absorbed_shortwave_w_m2": asr,
            "effective_emission_temperature_k": te,
            "co2_forcing_w_m2": forcing,
            "equilibrium_warming_k": warming,
        }
    )

    summary = samples.describe(percentiles=[0.05, 0.5, 0.95]).transpose()

    samples.to_csv(samples_path, index=False)
    summary.to_csv(summary_path)

    print("Monte Carlo climate uncertainty sample:")
    print(samples.head(12).round(6).to_string(index=False))
    print("\nSummary:")
    print(summary.round(6).to_string())


if __name__ == "__main__":
    main()

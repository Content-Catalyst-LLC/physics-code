"""
Resonance Parameter Sweep

This workflow computes the steady-state amplitude of a driven damped oscillator:

    A(omega) = (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2 gamma omega)^2)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def response_amplitude(
    mass_kg: float,
    spring_constant_n_per_m: float,
    damping_coefficient_kg_per_s: float,
    driving_force_n: float,
    driving_angular_frequency_rad_per_s: np.ndarray,
) -> np.ndarray:
    """
    Compute steady-state driven oscillator amplitude.
    """
    omega0 = np.sqrt(spring_constant_n_per_m / mass_kg)
    gamma = damping_coefficient_kg_per_s / (2.0 * mass_kg)

    denominator = np.sqrt(
        (omega0**2 - driving_angular_frequency_rad_per_s**2) ** 2
        + (2.0 * gamma * driving_angular_frequency_rad_per_s) ** 2
    )

    return (driving_force_n / mass_kg) / denominator


def main() -> None:
    """
    Generate resonance curves for several damping values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_resonance_parameter_sweep.csv"
    summary_path = article_dir / "data" / "computed_resonance_peak_summary.csv"

    mass_kg = 1.0
    spring_constant_n_per_m = 25.0
    driving_force_n = 1.0
    omega0 = np.sqrt(spring_constant_n_per_m / mass_kg)

    damping_values = [0.2, 0.6, 1.2]
    omega_values = np.linspace(0.1, 12.0, 400)

    rows = []

    for damping in damping_values:
        amplitudes = response_amplitude(
            mass_kg,
            spring_constant_n_per_m,
            damping,
            driving_force_n,
            omega_values,
        )

        for omega, amplitude in zip(omega_values, amplitudes):
            rows.append(
                {
                    "damping_coefficient_kg_per_s": damping,
                    "driving_angular_frequency_rad_per_s": omega,
                    "frequency_ratio": omega / omega0,
                    "response_amplitude_m": amplitude,
                }
            )

    table = pd.DataFrame(rows)

    summary = (
        table.sort_values("response_amplitude_m", ascending=False)
        .groupby("damping_coefficient_kg_per_s")
        .head(1)
        .sort_values("damping_coefficient_kg_per_s")
        .reset_index(drop=True)
    )

    table.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Resonance peak summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved sweep to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

"""
Born Approximation for a Gaussian Potential

For a model Gaussian potential:

    V(r) = V0 exp(-r^2/(2a^2))

the three-dimensional Fourier transform is proportional to:

    V_tilde(q) = V0 (2 pi)^(3/2) a^3 exp(-q^2 a^2 / 2)

The first Born amplitude is:

    f(q) = -m/(2 pi hbar^2) V_tilde(q)

This workflow uses dimensionless units by default.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Compute Born approximation amplitude and differential cross section.
    """
    q_values = np.linspace(float(case["q_min"]), float(case["q_max"]), int(case["n_points"]))

    v0 = float(case["potential_strength"])
    a = float(case["potential_range"])
    mass = float(case["mass"])
    hbar = float(case["hbar"])

    v_tilde = v0 * (2.0 * np.pi) ** 1.5 * a**3 * np.exp(-0.5 * (q_values * a) ** 2)
    amplitude = -mass / (2.0 * np.pi * hbar**2) * v_tilde
    differential_cross_section = np.abs(amplitude) ** 2

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "q": q_values,
            "born_amplitude": amplitude,
            "differential_cross_section": differential_cross_section,
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Compute Born approximation scaffolds for configured Gaussian potentials.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "born_potential_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_born_gaussian_potential.csv", index=False)

    print("Born approximation sample:")
    print(output.groupby("case_id").head(6).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

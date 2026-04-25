"""
Bose and Fermi Occupation Statistics

This workflow compares ideal Fermi-Dirac and Bose-Einstein occupation
functions across energy and temperature.
"""

from pathlib import Path

import numpy as np
import pandas as pd


K_B_EV_K = 8.617333262e-5


def fermi_occupation(energy_ev: np.ndarray, mu_ev: float, temperature_k: float) -> np.ndarray:
    """
    Compute Fermi-Dirac occupation.
    """
    x = (energy_ev - mu_ev) / (K_B_EV_K * temperature_k)
    return 1.0 / (np.exp(x) + 1.0)


def bose_occupation(energy_ev: np.ndarray, mu_ev: float, temperature_k: float) -> np.ndarray:
    """
    Compute Bose-Einstein occupation where E > mu.
    """
    x = (energy_ev - mu_ev) / (K_B_EV_K * temperature_k)
    values = np.full_like(energy_ev, np.nan, dtype=float)
    valid = energy_ev > mu_ev
    values[valid] = 1.0 / (np.exp(x[valid]) - 1.0)
    return values


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Compute occupation table for one parameter case.
    """
    energies = np.linspace(
        float(case["energy_min_ev"]),
        float(case["energy_max_ev"]),
        int(case["n_points"]),
    )

    mu = float(case["chemical_potential_ev"])
    temperature = float(case["temperature_k"])

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "temperature_k": temperature,
            "chemical_potential_ev": mu,
            "energy_ev": energies,
            "fermi_occupation": fermi_occupation(energies, mu, temperature),
            "bose_occupation": bose_occupation(energies, mu, temperature),
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Generate occupation statistics tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "occupation_cases.csv"
    output_path = article_dir / "data" / "computed_occupation_statistics.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    output.to_csv(output_path, index=False)

    print("Occupation statistics sample:")
    print(output.groupby("case_id").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

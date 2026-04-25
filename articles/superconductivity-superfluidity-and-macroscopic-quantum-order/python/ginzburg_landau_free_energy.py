"""
Ginzburg-Landau Free Energy

This workflow evaluates the uniform Ginzburg-Landau free-energy density:

    f = alpha(T) |Psi|^2 + beta/2 |Psi|^4

with:

    alpha(T) = alpha_0 (T - T_c)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Compute free-energy curves and equilibrium amplitude for one case.
    """
    temperatures = np.linspace(
        float(case["temperature_min_k"]),
        float(case["temperature_max_k"]),
        80,
    )
    amplitudes = np.linspace(0.0, 4.0, 300)

    rows = []

    for temperature in temperatures:
        alpha = float(case["alpha_0"]) * (temperature - float(case["critical_temperature_k"]))
        free_energy = alpha * amplitudes**2 + 0.5 * float(case["beta"]) * amplitudes**4

        min_index = int(np.argmin(free_energy))

        rows.append(
            {
                "case_id": case["case_id"],
                "temperature_k": temperature,
                "critical_temperature_k": float(case["critical_temperature_k"]),
                "alpha": alpha,
                "beta": float(case["beta"]),
                "equilibrium_amplitude_numeric": amplitudes[min_index],
                "minimum_free_energy_density": free_energy[min_index],
                "equilibrium_amplitude_analytic": np.sqrt(-alpha / float(case["beta"]))
                if alpha < 0
                else 0.0,
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate Ginzburg-Landau equilibrium amplitude tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "gl_parameter_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_gl_equilibrium_amplitudes.csv", index=False)

    print("Ginzburg-Landau equilibrium amplitude summary:")
    print(output.groupby("case_id").head(6).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

"""
Nernst Potential

This workflow computes the equilibrium potential for an ion gradient:

    E = (RT/zF) ln(c_out/c_in)
"""

from pathlib import Path

import numpy as np
import pandas as pd


GAS_CONSTANT = 8.314462618
FARADAY_CONSTANT = 96485.33212


def nernst_potential_v(c_out_mM: float, c_in_mM: float, z: int, temperature_k: float) -> float:
    """
    Compute Nernst equilibrium potential in volts.
    """
    return (GAS_CONSTANT * temperature_k / (z * FARADAY_CONSTANT)) * np.log(
        c_out_mM / c_in_mM
    )


def main() -> None:
    """
    Compute Nernst potentials for sample ion gradients.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "ion_gradient_cases.csv"
    output_path = article_dir / "data" / "computed_nernst_potentials.csv"

    cases = pd.read_csv(input_path)

    cases["nernst_potential_v"] = cases.apply(
        lambda row: nernst_potential_v(
            row["c_out_mM"],
            row["c_in_mM"],
            int(row["z"]),
            row["temperature_k"],
        ),
        axis=1,
    )

    cases["nernst_potential_mV"] = 1000.0 * cases["nernst_potential_v"]

    cases.to_csv(output_path, index=False)

    print("Nernst potential table:")
    print(cases.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

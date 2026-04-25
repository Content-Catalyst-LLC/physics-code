"""
Finite-Size Scaling Scaffold

At criticality, finite-size scaling predicts:

    M(L) ~ L^(-beta/nu)
    chi(L) ~ L^(gamma/nu)

This workflow generates scaling tables using selected exponent cases.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate finite-size scaling tables for sample universality classes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "critical_exponent_cases.csv"
    output_path = article_dir / "data" / "computed_finite_size_scaling.csv"

    exponent_cases = pd.read_csv(input_path)
    sizes = np.array([8, 16, 32, 64, 128, 256])

    rows = []

    for _, case in exponent_cases.iterrows():
        beta_over_nu = case["beta_exponent"] / case["nu_exponent"]
        gamma_over_nu = case["gamma_exponent"] / case["nu_exponent"]

        for size in sizes:
            rows.append(
                {
                    "universality_class": case["universality_class"],
                    "dimension": case["dimension"],
                    "lattice_size": size,
                    "beta_over_nu": beta_over_nu,
                    "gamma_over_nu": gamma_over_nu,
                    "critical_magnetization_scale": size ** (-beta_over_nu),
                    "critical_susceptibility_scale": size ** gamma_over_nu,
                    "notes": case["notes"],
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Finite-size scaling scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

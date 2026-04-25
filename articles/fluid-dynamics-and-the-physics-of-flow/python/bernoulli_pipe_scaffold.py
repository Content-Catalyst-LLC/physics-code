"""
Bernoulli and Pipe-Flow Scaffold

This workflow computes ideal Bernoulli outlet pressure:

    p2 = p1 + 1/2 rho(v1^2 - v2^2) + rho g(z1 - z2)

It also computes Reynolds number for each case.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 9.80665


def main() -> None:
    """
    Load Bernoulli cases and compute ideal pressure changes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    fluid_path = article_dir / "data" / "fluid_properties.csv"
    case_path = article_dir / "data" / "bernoulli_cases.csv"
    output_path = article_dir / "data" / "computed_bernoulli_pipe_scaffold.csv"

    fluids = pd.read_csv(fluid_path)
    cases = pd.read_csv(case_path)

    table = cases.merge(fluids, on="fluid", how="left")

    table["p2_ideal_pa"] = (
        table["p1_pa"]
        + 0.5 * table["density_kg_per_m3"] * (
            table["v1_m_per_s"]**2 - table["v2_m_per_s"]**2
        )
        + table["density_kg_per_m3"] * G * (
            table["z1_m"] - table["z2_m"]
        )
    )

    table["pressure_change_pa"] = table["p2_ideal_pa"] - table["p1_pa"]
    table["dynamic_pressure_1_pa"] = 0.5 * table["density_kg_per_m3"] * table["v1_m_per_s"]**2
    table["dynamic_pressure_2_pa"] = 0.5 * table["density_kg_per_m3"] * table["v2_m_per_s"]**2

    table.to_csv(output_path, index=False)

    print("Bernoulli scaffold:")
    print(table.round(6).to_string(index=False))
    print(f"\nSaved Bernoulli table to: {output_path}")


if __name__ == "__main__":
    main()

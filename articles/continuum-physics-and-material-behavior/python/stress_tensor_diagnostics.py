"""
Stress Tensor Diagnostics and von Mises Stress

This workflow analyzes three-dimensional Cauchy stress tensors.

It computes:
    - principal stresses
    - hydrostatic stress
    - deviatoric stress tensor
    - von Mises equivalent stress
    - yield ratio relative to a specified yield strength
"""

from pathlib import Path

import numpy as np
import pandas as pd


def stress_tensor_from_row(row: pd.Series) -> np.ndarray:
    """
    Build a symmetric 3x3 stress tensor from MPa components.
    """
    stress_mpa = np.array(
        [
            [row["s11_mpa"], row["s12_mpa"], row["s13_mpa"]],
            [row["s12_mpa"], row["s22_mpa"], row["s23_mpa"]],
            [row["s13_mpa"], row["s23_mpa"], row["s33_mpa"]],
        ],
        dtype=float,
    )
    return stress_mpa * 1.0e6


def von_mises_from_stress_tensor(stress_pa: np.ndarray) -> float:
    """
    Compute von Mises equivalent stress from a 3x3 stress tensor.
    """
    identity = np.eye(3)
    mean_stress = np.trace(stress_pa) / 3.0
    deviatoric_stress = stress_pa - mean_stress * identity

    return float(np.sqrt(1.5 * np.sum(deviatoric_stress * deviatoric_stress)))


def main() -> None:
    """
    Analyze all stress tensor cases and save diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "stress_tensor_cases.csv"
    output_path = article_dir / "data" / "computed_stress_tensor_diagnostics.csv"

    cases = pd.read_csv(input_path)
    rows = []

    for _, row in cases.iterrows():
        stress_pa = stress_tensor_from_row(row)
        principal_pa = np.linalg.eigvalsh(stress_pa)
        principal_mpa = principal_pa / 1.0e6

        hydrostatic_mpa = np.trace(stress_pa) / 3.0 / 1.0e6
        von_mises_mpa = von_mises_from_stress_tensor(stress_pa) / 1.0e6
        yield_ratio = von_mises_mpa / row["yield_strength_mpa"]

        rows.append(
            {
                "case_id": row["case_id"],
                "principal_stress_1_mpa": principal_mpa[0],
                "principal_stress_2_mpa": principal_mpa[1],
                "principal_stress_3_mpa": principal_mpa[2],
                "hydrostatic_stress_mpa": hydrostatic_mpa,
                "von_mises_stress_mpa": von_mises_mpa,
                "yield_strength_mpa": row["yield_strength_mpa"],
                "yield_ratio": yield_ratio,
                "yield_flag": yield_ratio >= 1.0,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Stress tensor diagnostics:")
    print(output.round(6).to_string(index=False))
    print(f"\nSaved diagnostics to: {output_path}")


if __name__ == "__main__":
    main()

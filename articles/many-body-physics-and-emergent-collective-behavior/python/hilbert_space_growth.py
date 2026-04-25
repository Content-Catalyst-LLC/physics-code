"""
Hilbert-Space Growth

This workflow computes many-body Hilbert-space dimensions:

    dimension = local_dimension ** n_sites

and approximate memory requirements for storing a dense complex state vector.
"""

from pathlib import Path

import pandas as pd


BYTES_PER_COMPLEX128 = 16


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate Hilbert-space scaling rows for one local dimension.
    """
    rows = []

    for n_sites in range(int(case["n_min"]), int(case["n_max"]) + 1):
        dimension = int(case["local_dimension"]) ** n_sites
        memory_bytes = dimension * BYTES_PER_COMPLEX128

        rows.append(
            {
                "case_id": case["case_id"],
                "local_dimension": int(case["local_dimension"]),
                "n_sites": n_sites,
                "hilbert_dimension": dimension,
                "state_vector_memory_bytes_complex128": memory_bytes,
                "state_vector_memory_gb_complex128": memory_bytes / 1e9,
                "state_vector_memory_tb_complex128": memory_bytes / 1e12,
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Compute Hilbert-space growth tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "hilbert_space_cases.csv"
    output_path = article_dir / "data" / "computed_hilbert_space_growth.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    output.to_csv(output_path, index=False)

    print("Hilbert-space growth sample:")
    print(output.groupby("case_id").tail(5).to_string(index=False))


if __name__ == "__main__":
    main()

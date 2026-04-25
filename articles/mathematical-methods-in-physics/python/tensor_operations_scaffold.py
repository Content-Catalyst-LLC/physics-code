"""
Tensor Operations Scaffold

This workflow demonstrates simple tensor operations using a stress-like
symmetric matrix:

    - eigenvalues as principal values
    - trace as invariant
    - deviatoric part
    - Frobenius norm
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Compute tensor diagnostics for a symmetric 3x3 tensor.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_tensor_diagnostics.csv"

    tensor = np.array(
        [
            [120.0, 35.0, 10.0],
            [35.0, 80.0, 15.0],
            [10.0, 15.0, 50.0],
        ]
    )

    principal_values = np.linalg.eigvalsh(tensor)
    trace = np.trace(tensor)
    identity = np.eye(3)
    deviatoric = tensor - (trace / 3.0) * identity
    frobenius_norm = np.sqrt(np.sum(tensor * tensor))

    table = pd.DataFrame(
        [
            {
                "principal_value_1": principal_values[0],
                "principal_value_2": principal_values[1],
                "principal_value_3": principal_values[2],
                "trace": trace,
                "deviatoric_trace": np.trace(deviatoric),
                "frobenius_norm": frobenius_norm,
            }
        ]
    )

    table.to_csv(output_path, index=False)

    print("Tensor diagnostics:")
    print(table.round(8).to_string(index=False))
    print(f"\nSaved tensor diagnostics to: {output_path}")


if __name__ == "__main__":
    main()

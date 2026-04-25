"""
Tensor Product Scaffold for Angular Momentum

This workflow stores angular-momentum tensor-product decompositions:

    j1 tensor j2 = direct sum from |j1-j2| to j1+j2
"""

from pathlib import Path

import numpy as np
import pandas as pd


def angular_momentum_product(j1: float, j2: float) -> list[float]:
    """
    Return allowed total angular momentum values.
    """
    j_min = abs(j1 - j2)
    j_max = j1 + j2
    n_steps = int(round(j_max - j_min))

    return [j_min + step for step in range(n_steps + 1)]


def main() -> None:
    """
    Generate tensor-product decomposition scaffold.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_angular_momentum_tensor_products.csv"

    product_cases = [
        (0.5, 0.5),
        (0.5, 1.0),
        (1.0, 1.0),
        (1.5, 0.5),
        (2.0, 1.0),
    ]

    rows = []

    for j1, j2 in product_cases:
        components = angular_momentum_product(j1, j2)
        input_dimension = int((2 * j1 + 1) * (2 * j2 + 1))
        output_dimension = int(sum(2 * j + 1 for j in components))

        rows.append(
            {
                "j1": j1,
                "j2": j2,
                "decomposition": " + ".join(str(j) for j in components),
                "input_tensor_product_dimension": input_dimension,
                "output_sum_dimension": output_dimension,
                "dimension_check_error": input_dimension - output_dimension,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Angular-momentum tensor-product scaffold:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()

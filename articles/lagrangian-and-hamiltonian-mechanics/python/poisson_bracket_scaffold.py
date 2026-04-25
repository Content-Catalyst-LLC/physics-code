"""
Poisson Bracket Scaffold

This workflow uses SymPy to compute simple Poisson brackets.

For one degree of freedom:

    {A,B} = dA/dq dB/dp - dA/dp dB/dq
"""

from pathlib import Path

import pandas as pd
import sympy as sp


q, p, m, k = sp.symbols("q p m k", positive=True)
H = p**2 / (2 * m) + k * q**2 / 2


def poisson_bracket(A, B):
    """
    Compute the one-dimensional canonical Poisson bracket.
    """
    return sp.diff(A, q) * sp.diff(B, p) - sp.diff(A, p) * sp.diff(B, q)


def main() -> None:
    """
    Compute Poisson brackets for basic observables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_poisson_brackets.csv"

    observables = {
        "q": q,
        "p": p,
        "H": H,
        "q_squared": q**2,
        "p_squared": p**2,
    }

    rows = []

    for name, observable in observables.items():
        bracket_with_h = sp.simplify(poisson_bracket(observable, H))
        rows.append(
            {
                "observable": name,
                "expression": str(observable),
                "poisson_bracket_with_H": str(bracket_with_h),
                "interpretation": "time derivative if no explicit time dependence",
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Poisson bracket scaffold:")
    print(table.to_string(index=False))
    print(f"\nSaved brackets to: {output_path}")


if __name__ == "__main__":
    main()

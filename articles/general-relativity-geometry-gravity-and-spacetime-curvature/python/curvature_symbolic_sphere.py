"""
Symbolic Curvature Example: Two-Sphere

This workflow uses a simple two-dimensional sphere to demonstrate
curvature metadata in a manageable symbolic example.

This is not a spacetime solution of Einstein's field equation. It is a
pedagogical geometry example showing that curvature can be computed from
a metric.
"""

from pathlib import Path

import pandas as pd
import sympy as sp


def main() -> None:
    """
    Save known curvature quantities for a 2-sphere of radius a.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_symbolic_sphere_curvature.csv"

    a = sp.symbols("a", positive=True)

    rows = [
        {
            "geometry": "two_sphere",
            "metric_line_element": "ds^2 = a^2 dtheta^2 + a^2 sin(theta)^2 dphi^2",
            "dimension": 2,
            "ricci_scalar": str(2 / a**2),
            "gaussian_curvature": str(1 / a**2),
            "notes": "Pedagogical curved Riemannian geometry example.",
        }
    ]

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Symbolic curvature example:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()

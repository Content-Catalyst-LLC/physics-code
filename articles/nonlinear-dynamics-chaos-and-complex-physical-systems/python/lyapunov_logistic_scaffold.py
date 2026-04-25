"""
Logistic Map Lyapunov Exponent Scaffold

For a one-dimensional map:

    x_{n+1} = f(x_n)

the Lyapunov exponent can be estimated as:

    lambda ≈ (1/N) sum log |f'(x_n)|

after discarding transients.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def estimate_logistic_lyapunov(
    r: float,
    x0: float = 0.2,
    n_iter: int = 5000,
    burn_in: int = 1000,
) -> float:
    """
    Estimate the Lyapunov exponent of the logistic map.
    """
    x = x0
    log_derivatives = []

    for i in range(n_iter):
        derivative = abs(r * (1.0 - 2.0 * x))

        if i >= burn_in:
            log_derivatives.append(np.log(max(derivative, 1.0e-300)))

        x = r * x * (1.0 - x)

    return float(np.mean(log_derivatives))


def main() -> None:
    """
    Estimate Lyapunov exponents across logistic-map r values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_logistic_lyapunov_estimates.csv"

    r_values = np.arange(2.5, 4.0001, 0.01)

    table = pd.DataFrame(
        {
            "r": r_values,
            "lyapunov_estimate_per_iteration": [
                estimate_logistic_lyapunov(float(r))
                for r in r_values
            ],
        }
    )

    table["chaos_indicator"] = table["lyapunov_estimate_per_iteration"] > 0.0

    table.to_csv(output_path, index=False)

    print("Logistic Lyapunov estimates:")
    print(table.head(20).round(8).to_string(index=False))
    print(table.tail(20).round(8).to_string(index=False))
    print(f"\nSaved estimates to: {output_path}")


if __name__ == "__main__":
    main()

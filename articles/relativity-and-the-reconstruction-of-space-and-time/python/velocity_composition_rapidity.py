"""
Velocity Composition and Rapidity

This workflow compares relativistic velocity composition with rapidity.

Collinear velocity composition in dimensionless units:

    beta_prime = (beta_u - beta_v) / (1 - beta_u * beta_v)

Rapidity:

    beta = tanh(eta)

For collinear boosts, rapidities compose additively.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def compose_beta(beta_u: float, beta_v: float) -> float:
    """
    Compose collinear velocities using the relativistic rule.
    """
    if abs(beta_u) >= 1 or abs(beta_v) >= 1:
        raise ValueError("Both velocities must satisfy |beta| < 1.")

    return (beta_u - beta_v) / (1.0 - beta_u * beta_v)


def rapidity_from_beta(beta: float) -> float:
    """
    Convert beta to rapidity eta.
    """
    if abs(beta) >= 1:
        raise ValueError("beta must satisfy |beta| < 1.")

    return np.arctanh(beta)


def beta_from_rapidity(eta: float) -> float:
    """
    Convert rapidity eta to beta.
    """
    return np.tanh(eta)


def main() -> None:
    """
    Generate a velocity-composition and rapidity table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_velocity_composition_rapidity.csv"

    rows = []

    for beta_u in [0.1, 0.3, 0.5, 0.8, 0.95]:
        for beta_v in [0.1, 0.3, 0.5, 0.8]:
            composed = compose_beta(beta_u, beta_v)
            eta_u = rapidity_from_beta(beta_u)
            eta_v = rapidity_from_beta(beta_v)
            eta_composed = eta_u - eta_v

            rows.append(
                {
                    "beta_u": beta_u,
                    "beta_v": beta_v,
                    "composed_beta_direct": composed,
                    "eta_u": eta_u,
                    "eta_v": eta_v,
                    "eta_u_minus_eta_v": eta_composed,
                    "composed_beta_from_rapidity": beta_from_rapidity(eta_composed),
                }
            )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Velocity composition and rapidity table:")
    print(table.round(8).head(20).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()

"""
Operator-Learning Dataset Generator

Generates toy datasets for the heat equation solution operator:

    initial condition a(x) -> solution u(x,t)

using random sinusoidal initial conditions.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def generate_initial_condition(x: np.ndarray, rng: np.random.Generator) -> np.ndarray:
    """
    Generate a smooth random initial condition from sine modes.
    """
    coefficients = rng.normal(0.0, 1.0, size=4)

    initial = np.zeros_like(x)

    for mode, coefficient in enumerate(coefficients, start=1):
        initial += coefficient * np.sin(mode * np.pi * x)

    return initial


def heat_solution_from_modes(x: np.ndarray, t: np.ndarray, initial_coeffs: np.ndarray, diffusion: float) -> np.ndarray:
    """
    Generate heat-equation solution for sine-mode coefficients.
    """
    xx, tt = np.meshgrid(x, t, indexing="ij")
    solution = np.zeros_like(xx)

    for mode, coeff in enumerate(initial_coeffs, start=1):
        solution += coeff * np.exp(-diffusion * (mode * np.pi) ** 2 * tt) * np.sin(mode * np.pi * xx)

    return solution


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate one operator-learning toy dataset.
    """
    rng = np.random.default_rng(int(case["seed"]))

    n_functions = int(case["n_functions"])
    n_x = int(case["n_x"])
    n_t = int(case["n_t"])
    diffusion = float(case["diffusion"])

    x = np.linspace(0.0, 1.0, n_x)
    t = np.linspace(0.0, 1.0, n_t)

    rows = []

    for function_id in range(n_functions):
        coeffs = rng.normal(0.0, 1.0, size=4)
        solution = heat_solution_from_modes(x, t, coeffs, diffusion)

        for i, x_value in enumerate(x):
            for j, t_value in enumerate(t):
                rows.append(
                    {
                        "case_id": case["case_id"],
                        "function_id": function_id,
                        "x": x_value,
                        "t": t_value,
                        "u": solution[i, j],
                        "diffusion": diffusion,
                        "coeff_1": coeffs[0],
                        "coeff_2": coeffs[1],
                        "coeff_3": coeffs[2],
                        "coeff_4": coeffs[3],
                        "notes": case["notes"],
                    }
                )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate configured operator-learning datasets.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "operator_learning_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_operator_learning_dataset.csv", index=False)

    print("Operator-learning dataset sample:")
    print(output.groupby("case_id").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

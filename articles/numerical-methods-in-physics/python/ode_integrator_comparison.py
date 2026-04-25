"""
ODE Integrator Comparison

Compares forward Euler and classical RK4 for:

    y' = lambda y

with exact solution:

    y(t) = y0 exp(lambda t)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def euler_step(y: float, time_step: float, lambda_value: float) -> float:
    """
    Forward Euler step.
    """
    return y + time_step * lambda_value * y


def rk4_step(y: float, time_step: float, lambda_value: float) -> float:
    """
    Classical fourth-order Runge-Kutta step.
    """
    def f(value: float) -> float:
        return lambda_value * value

    k1 = f(y)
    k2 = f(y + 0.5 * time_step * k1)
    k3 = f(y + 0.5 * time_step * k2)
    k4 = f(y + time_step * k3)

    return y + (time_step / 6.0) * (k1 + 2.0 * k2 + 2.0 * k3 + k4)


def run_case(case: pd.Series) -> dict:
    """
    Run one ODE case and compare errors.
    """
    lambda_value = float(case["lambda_value"])
    y0 = float(case["y0"])
    t_final = float(case["t_final"])
    dt = float(case["time_step"])

    n_steps = int(round(t_final / dt))

    y_euler = y0
    y_rk4 = y0

    for _ in range(n_steps):
        y_euler = euler_step(y_euler, dt, lambda_value)
        y_rk4 = rk4_step(y_rk4, dt, lambda_value)

    exact = y0 * np.exp(lambda_value * n_steps * dt)

    return {
        "case_id": case["case_id"],
        "lambda_value": lambda_value,
        "time_step": dt,
        "t_final_actual": n_steps * dt,
        "exact_solution": exact,
        "euler_solution": y_euler,
        "rk4_solution": y_rk4,
        "euler_absolute_error": abs(y_euler - exact),
        "rk4_absolute_error": abs(y_rk4 - exact),
        "notes": case["notes"],
    }


def main() -> None:
    """
    Run configured ODE comparisons.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "ode_cases.csv")

    output = pd.DataFrame([run_case(case) for _, case in cases.iterrows()])
    output.to_csv(article_dir / "data" / "computed_ode_integrator_comparison.csv", index=False)

    print("ODE integrator comparison:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()

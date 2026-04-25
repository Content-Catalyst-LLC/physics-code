"""
Physics-Informed Neural Network for Exponential Decay

Solves:

    du/dt = -lambda u
    u(0) = u0

with a small neural network trained by physics residual and initial-condition loss.
"""

from __future__ import annotations

from pathlib import Path
import random

import numpy as np
import pandas as pd
import torch
from torch import nn


RANDOM_SEED = 42


class DecayPINN(nn.Module):
    """
    Small fully connected neural network for u_theta(t).
    """

    def __init__(self, hidden_width: int = 32) -> None:
        super().__init__()

        self.network = nn.Sequential(
            nn.Linear(1, hidden_width),
            nn.Tanh(),
            nn.Linear(hidden_width, hidden_width),
            nn.Tanh(),
            nn.Linear(hidden_width, 1),
        )

    def forward(self, t: torch.Tensor) -> torch.Tensor:
        """
        Evaluate u_theta(t).
        """
        return self.network(t)


def exact_solution(t: torch.Tensor, lambda_value: float, u0: float) -> torch.Tensor:
    """
    Analytic solution for exponential decay.
    """
    return u0 * torch.exp(-lambda_value * t)


def residual(model: nn.Module, t: torch.Tensor, lambda_value: float) -> torch.Tensor:
    """
    Compute residual r(t) = du_theta/dt + lambda u_theta.
    """
    t = t.clone().detach().requires_grad_(True)
    u = model(t)

    du_dt = torch.autograd.grad(
        outputs=u,
        inputs=t,
        grad_outputs=torch.ones_like(u),
        create_graph=True,
    )[0]

    return du_dt + lambda_value * u


def train_case(case: pd.Series) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Train one PINN case.
    """
    torch.manual_seed(RANDOM_SEED)
    np.random.seed(RANDOM_SEED)
    random.seed(RANDOM_SEED)

    lambda_value = float(case["lambda_value"])
    u0 = float(case["u0"])
    t_min = float(case["t_min"])
    t_max = float(case["t_max"])
    n_collocation = int(case["n_collocation"])
    n_epochs = int(case["n_epochs"])
    learning_rate = float(case["learning_rate"])

    model = DecayPINN()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

    t_collocation = torch.linspace(t_min, t_max, n_collocation).reshape(-1, 1)
    t_initial = torch.tensor([[t_min]], dtype=torch.float32)
    u_initial = torch.tensor([[u0]], dtype=torch.float32)

    history = []

    for epoch in range(n_epochs + 1):
        optimizer.zero_grad()

        r = residual(model, t_collocation, lambda_value)
        residual_loss = torch.mean(r**2)

        initial_loss = torch.mean((model(t_initial) - u_initial) ** 2)

        total_loss = residual_loss + 10.0 * initial_loss

        total_loss.backward()
        optimizer.step()

        if epoch % max(1, n_epochs // 20) == 0:
            history.append(
                {
                    "case_id": case["case_id"],
                    "epoch": epoch,
                    "total_loss": float(total_loss.detach()),
                    "residual_loss": float(residual_loss.detach()),
                    "initial_loss": float(initial_loss.detach()),
                    "notes": case["notes"],
                }
            )

    t_eval = torch.linspace(t_min, t_max, 201).reshape(-1, 1)

    with torch.no_grad():
        u_pred = model(t_eval)
        u_exact = exact_solution(t_eval, lambda_value, u0)
        absolute_error = torch.abs(u_pred - u_exact)

    validation = pd.DataFrame(
        {
            "case_id": case["case_id"],
            "t": t_eval.numpy().reshape(-1),
            "u_pred": u_pred.numpy().reshape(-1),
            "u_exact": u_exact.numpy().reshape(-1),
            "absolute_error": absolute_error.numpy().reshape(-1),
            "notes": case["notes"],
        }
    )

    return pd.DataFrame(history), validation


def main() -> None:
    """
    Run all configured PINN cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "decay_pinn_cases.csv")

    histories = []
    validations = []

    for _, case in cases.iterrows():
        history, validation = train_case(case)
        histories.append(history)
        validations.append(validation)

    history_output = pd.concat(histories, ignore_index=True)
    validation_output = pd.concat(validations, ignore_index=True)

    summary = (
        validation_output.groupby("case_id", as_index=False)
        .agg(
            mean_absolute_error=("absolute_error", "mean"),
            max_absolute_error=("absolute_error", "max"),
            root_mean_squared_error=("absolute_error", lambda x: float(np.sqrt(np.mean(x**2)))),
        )
    )

    history_output.to_csv(article_dir / "data" / "computed_pinn_decay_history.csv", index=False)
    validation_output.to_csv(article_dir / "data" / "computed_pinn_decay_validation.csv", index=False)
    summary.to_csv(article_dir / "data" / "computed_pinn_decay_summary.csv", index=False)

    print("PINN decay validation summary:")
    print(summary.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

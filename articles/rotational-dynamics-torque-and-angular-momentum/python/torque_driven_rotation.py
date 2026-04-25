"""
Torque-Driven Rigid-Body Rotation

This workflow models fixed-axis rotation for a rigid disk.

Core relations:
    I = 1/2 M R^2
    tau_net = I * alpha
    alpha = tau_net / I
    L = I * omega
    K_rot = 1/2 I omega^2

The model includes applied torque, damping torque, angular momentum, and
rotational kinetic energy.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


MASS_KG = 2.0
RADIUS_M = 0.25
DAMPING_N_M_S = 0.03
MOMENT_OF_INERTIA_KG_M2 = 0.5 * MASS_KG * RADIUS_M**2


def applied_torque(time_s: float) -> float:
    """
    Time-varying applied torque in newton metres.
    """
    if time_s < 1.0:
        return 0.8 * time_s
    if time_s < 4.0:
        return 0.8
    if time_s < 6.0:
        return 0.8 * (1.0 - (time_s - 4.0) / 2.0)
    return 0.0


def rotational_dynamics(time_s: float, state: np.ndarray) -> list[float]:
    """
    Fixed-axis rotational dynamics.

    State vector:
        state[0] = angular position theta in radians
        state[1] = angular velocity omega in radians per second
    """
    theta_rad, omega_rad_per_s = state

    torque_applied_n_m = applied_torque(time_s)
    torque_damping_n_m = -DAMPING_N_M_S * omega_rad_per_s
    torque_net_n_m = torque_applied_n_m + torque_damping_n_m

    angular_acceleration_rad_per_s2 = (
        torque_net_n_m / MOMENT_OF_INERTIA_KG_M2
    )

    return [omega_rad_per_s, angular_acceleration_rad_per_s2]


def main() -> None:
    """
    Simulate torque-driven rotation and save angular quantities.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_torque_driven_rotation.csv"
    summary_path = article_dir / "data" / "computed_torque_driven_rotation_summary.csv"

    time_eval_s = np.linspace(0.0, 8.0, 1000)

    solution = solve_ivp(
        rotational_dynamics,
        (0.0, 8.0),
        [0.0, 0.0],
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    theta_rad = solution.y[0]
    omega_rad_per_s = solution.y[1]

    torque_applied = np.array([applied_torque(t) for t in solution.t])
    torque_damping = -DAMPING_N_M_S * omega_rad_per_s
    torque_net = torque_applied + torque_damping

    angular_momentum = MOMENT_OF_INERTIA_KG_M2 * omega_rad_per_s
    rotational_kinetic_energy = 0.5 * MOMENT_OF_INERTIA_KG_M2 * omega_rad_per_s**2

    table = pd.DataFrame(
        {
            "time_s": solution.t,
            "theta_rad": theta_rad,
            "omega_rad_per_s": omega_rad_per_s,
            "applied_torque_n_m": torque_applied,
            "damping_torque_n_m": torque_damping,
            "net_torque_n_m": torque_net,
            "angular_momentum_kg_m2_per_s": angular_momentum,
            "rotational_kinetic_energy_j": rotational_kinetic_energy,
        }
    )

    summary = pd.DataFrame(
        [
            {
                "moment_of_inertia_kg_m2": MOMENT_OF_INERTIA_KG_M2,
                "max_angular_velocity_rad_per_s": table["omega_rad_per_s"].max(),
                "max_angular_momentum_kg_m2_per_s": table[
                    "angular_momentum_kg_m2_per_s"
                ].max(),
                "max_rotational_kinetic_energy_j": table[
                    "rotational_kinetic_energy_j"
                ].max(),
                "final_theta_rad": table["theta_rad"].iloc[-1],
            }
        ]
    )

    table.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Torque-driven rotation sample:")
    print(table.head(12).round(8).to_string(index=False))
    print("\nRotation summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

"""
Two-Body Orbit Integration

This workflow integrates the Newtonian two-body equation:

    d r / dt = v
    d v / dt = -mu r / |r|^3

It tracks radius, speed, specific orbital energy, and specific angular
momentum as conservation diagnostics.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


EARTH_MU_M3_PER_S2 = 3.986_004_418e14
EARTH_RADIUS_M = 6.371e6
ALTITUDE_M = 700e3

ORBITAL_RADIUS_M = EARTH_RADIUS_M + ALTITUDE_M
CIRCULAR_SPEED_M_PER_S = np.sqrt(EARTH_MU_M3_PER_S2 / ORBITAL_RADIUS_M)


def two_body_equations(time_s: float, state: np.ndarray) -> list[float]:
    """
    Return derivatives for planar two-body motion.

    State vector:
        state[0] = x position in meters
        state[1] = y position in meters
        state[2] = x velocity in meters per second
        state[3] = y velocity in meters per second
    """
    x_m, y_m, vx_m_per_s, vy_m_per_s = state
    radius_m = np.sqrt(x_m**2 + y_m**2)

    ax_m_per_s2 = -EARTH_MU_M3_PER_S2 * x_m / radius_m**3
    ay_m_per_s2 = -EARTH_MU_M3_PER_S2 * y_m / radius_m**3

    return [vx_m_per_s, vy_m_per_s, ax_m_per_s2, ay_m_per_s2]


def compute_orbit_diagnostics(solution) -> pd.DataFrame:
    """
    Convert integration output into an orbital diagnostics table.
    """
    x_m = solution.y[0]
    y_m = solution.y[1]
    vx_m_per_s = solution.y[2]
    vy_m_per_s = solution.y[3]

    radius_m = np.sqrt(x_m**2 + y_m**2)
    speed_m_per_s = np.sqrt(vx_m_per_s**2 + vy_m_per_s**2)

    specific_energy_j_per_kg = (
        0.5 * speed_m_per_s**2 - EARTH_MU_M3_PER_S2 / radius_m
    )

    specific_angular_momentum_m2_per_s = x_m * vy_m_per_s - y_m * vx_m_per_s

    return pd.DataFrame(
        {
            "time_s": solution.t,
            "x_m": x_m,
            "y_m": y_m,
            "vx_m_per_s": vx_m_per_s,
            "vy_m_per_s": vy_m_per_s,
            "radius_m": radius_m,
            "speed_m_per_s": speed_m_per_s,
            "specific_energy_j_per_kg": specific_energy_j_per_kg,
            "specific_angular_momentum_m2_per_s":
                specific_angular_momentum_m2_per_s,
        }
    )


def main() -> None:
    """
    Integrate a near-circular low Earth orbit and save diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    orbit_output = article_dir / "data" / "computed_two_body_orbit.csv"
    summary_output = article_dir / "data" / "computed_two_body_orbit_summary.csv"

    orbital_period_s = 2.0 * np.pi * np.sqrt(
        ORBITAL_RADIUS_M**3 / EARTH_MU_M3_PER_S2
    )

    initial_state = [
        ORBITAL_RADIUS_M,
        0.0,
        0.0,
        CIRCULAR_SPEED_M_PER_S,
    ]

    solution = solve_ivp(
        two_body_equations,
        (0.0, orbital_period_s),
        initial_state,
        t_eval=np.linspace(0.0, orbital_period_s, 1000),
        rtol=1e-10,
        atol=1e-3,
    )

    orbit_table = compute_orbit_diagnostics(solution)

    summary = pd.DataFrame(
        [
            {
                "orbital_radius_m": ORBITAL_RADIUS_M,
                "circular_speed_m_per_s": CIRCULAR_SPEED_M_PER_S,
                "orbital_period_s": orbital_period_s,
                "min_radius_m": orbit_table["radius_m"].min(),
                "max_radius_m": orbit_table["radius_m"].max(),
                "energy_relative_range": (
                    orbit_table["specific_energy_j_per_kg"].max()
                    - orbit_table["specific_energy_j_per_kg"].min()
                ) / abs(orbit_table["specific_energy_j_per_kg"].mean()),
                "angular_momentum_relative_range": (
                    orbit_table["specific_angular_momentum_m2_per_s"].max()
                    - orbit_table["specific_angular_momentum_m2_per_s"].min()
                ) / abs(
                    orbit_table["specific_angular_momentum_m2_per_s"].mean()
                ),
            }
        ]
    )

    orbit_table.to_csv(orbit_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Orbit diagnostics sample:")
    print(orbit_table.head(12).round(6).to_string(index=False))

    print("\nConservation summary:")
    print(summary.round(10).to_string(index=False))

    print(f"\nSaved orbit table to: {orbit_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()

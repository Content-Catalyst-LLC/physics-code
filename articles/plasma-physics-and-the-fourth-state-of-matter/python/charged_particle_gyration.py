"""
Charged Particle Gyration in a Uniform Magnetic Field

This workflow integrates the Lorentz force equation:

    m dv/dt = q (E + v x B)

for a single charged particle in a uniform magnetic field.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


ELEMENTARY_CHARGE_C = 1.602176634e-19
ELECTRON_MASS_KG = 9.1093837015e-31

PARTICLE_CHARGE_C = -ELEMENTARY_CHARGE_C
PARTICLE_MASS_KG = ELECTRON_MASS_KG

ELECTRIC_FIELD_V_M = np.array([0.0, 0.0, 0.0])
MAGNETIC_FIELD_T = np.array([0.0, 0.0, 0.01])

INITIAL_POSITION_M = np.array([0.0, 0.0, 0.0])
INITIAL_VELOCITY_M_S = np.array([1.0e5, 0.0, 2.0e4])


def lorentz_rhs(time_s: float, state: np.ndarray) -> np.ndarray:
    """
    Return derivatives for position and velocity.

    state = [x, y, z, vx, vy, vz]
    """
    velocity = state[3:6]

    acceleration = (
        PARTICLE_CHARGE_C / PARTICLE_MASS_KG
    ) * (
        ELECTRIC_FIELD_V_M + np.cross(velocity, MAGNETIC_FIELD_T)
    )

    return np.concatenate([velocity, acceleration])


def main() -> None:
    """
    Integrate charged-particle gyration and save orbital diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_charged_particle_gyration.csv"
    diagnostics_path = article_dir / "data" / "computed_charged_particle_gyration_diagnostics.csv"

    cyclotron_angular_frequency = (
        abs(PARTICLE_CHARGE_C)
        * np.linalg.norm(MAGNETIC_FIELD_T)
        / PARTICLE_MASS_KG
    )

    cyclotron_period_s = 2.0 * np.pi / cyclotron_angular_frequency
    initial_perpendicular_speed = np.linalg.norm(INITIAL_VELOCITY_M_S[:2])

    larmor_radius_m = (
        PARTICLE_MASS_KG
        * initial_perpendicular_speed
        / (abs(PARTICLE_CHARGE_C) * np.linalg.norm(MAGNETIC_FIELD_T))
    )

    initial_state = np.concatenate([INITIAL_POSITION_M, INITIAL_VELOCITY_M_S])
    time_values_s = np.linspace(0.0, 5.0 * cyclotron_period_s, 1000)

    solution = solve_ivp(
        lorentz_rhs,
        (time_values_s[0], time_values_s[-1]),
        initial_state,
        t_eval=time_values_s,
        rtol=1e-9,
        atol=1e-12,
    )

    if not solution.success:
        raise RuntimeError(solution.message)

    output = pd.DataFrame(
        {
            "time_s": solution.t,
            "x_m": solution.y[0],
            "y_m": solution.y[1],
            "z_m": solution.y[2],
            "vx_m_s": solution.y[3],
            "vy_m_s": solution.y[4],
            "vz_m_s": solution.y[5],
        }
    )

    output["perpendicular_radius_m"] = np.sqrt(output["x_m"]**2 + output["y_m"]**2)
    output["speed_m_s"] = np.sqrt(
        output["vx_m_s"]**2 + output["vy_m_s"]**2 + output["vz_m_s"]**2
    )

    diagnostics = pd.DataFrame(
        [
            {
                "magnetic_field_t": np.linalg.norm(MAGNETIC_FIELD_T),
                "cyclotron_angular_frequency_rad_s": cyclotron_angular_frequency,
                "cyclotron_frequency_hz": cyclotron_angular_frequency / (2.0 * np.pi),
                "cyclotron_period_s": cyclotron_period_s,
                "initial_perpendicular_speed_m_s": initial_perpendicular_speed,
                "estimated_larmor_radius_m": larmor_radius_m,
                "parallel_speed_m_s": INITIAL_VELOCITY_M_S[2],
            }
        ]
    )

    output.to_csv(output_path, index=False)
    diagnostics.to_csv(diagnostics_path, index=False)

    print("Trajectory sample:")
    print(output.iloc[::100, :].round(10).to_string(index=False))

    print("\nDiagnostics:")
    print(diagnostics.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

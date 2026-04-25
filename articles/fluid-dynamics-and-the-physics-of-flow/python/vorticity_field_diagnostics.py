"""
Two-Dimensional Incompressible Vorticity Field

This workflow constructs a streamfunction-based velocity field:

    psi(x, y) = sin(pi x) sin(pi y)

For two-dimensional incompressible flow, velocity can be defined as:

    u =  d psi / dy
    v = -d psi / dx

This automatically satisfies:

    div(u, v) = 0

The workflow computes velocity, speed, divergence, and vorticity.
"""

from pathlib import Path

import numpy as np
import pandas as pd


NX = 101
NY = 101

x = np.linspace(0.0, 1.0, NX)
y = np.linspace(0.0, 1.0, NY)

dx = x[1] - x[0]
dy = y[1] - y[0]

X, Y = np.meshgrid(x, y, indexing="ij")


def main() -> None:
    """
    Build a velocity field from a streamfunction and save diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    sample_path = article_dir / "data" / "computed_vorticity_field_sample.csv"
    summary_path = article_dir / "data" / "computed_vorticity_field_summary.csv"

    streamfunction = np.sin(np.pi * X) * np.sin(np.pi * Y)

    u_velocity = np.gradient(streamfunction, dy, axis=1)
    v_velocity = -np.gradient(streamfunction, dx, axis=0)

    speed = np.sqrt(u_velocity**2 + v_velocity**2)

    du_dx = np.gradient(u_velocity, dx, axis=0)
    dv_dy = np.gradient(v_velocity, dy, axis=1)

    divergence = du_dx + dv_dy

    dv_dx = np.gradient(v_velocity, dx, axis=0)
    du_dy = np.gradient(u_velocity, dy, axis=1)

    vorticity = dv_dx - du_dy

    summary = pd.DataFrame(
        [
            {
                "nx": NX,
                "ny": NY,
                "dx": dx,
                "dy": dy,
                "max_speed_m_per_s_like": float(np.max(speed)),
                "mean_speed_m_per_s_like": float(np.mean(speed)),
                "max_abs_divergence": float(np.max(np.abs(divergence))),
                "max_vorticity_s_inverse_like": float(np.max(vorticity)),
                "min_vorticity_s_inverse_like": float(np.min(vorticity)),
                "mean_abs_vorticity_s_inverse_like":
                    float(np.mean(np.abs(vorticity))),
            }
        ]
    )

    sample = pd.DataFrame(
        {
            "x": X.ravel(),
            "y": Y.ravel(),
            "u_velocity": u_velocity.ravel(),
            "v_velocity": v_velocity.ravel(),
            "speed": speed.ravel(),
            "divergence": divergence.ravel(),
            "vorticity": vorticity.ravel(),
        }
    ).iloc[::500, :]

    sample.to_csv(sample_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Velocity-field diagnostic summary:")
    print(summary.round(8).to_string(index=False))

    print("\nSample field values:")
    print(sample.head(12).round(8).to_string(index=False))

    print(f"\nSaved sample to: {sample_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

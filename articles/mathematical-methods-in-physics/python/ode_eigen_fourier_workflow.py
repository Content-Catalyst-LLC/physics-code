"""
ODE Integration, Eigenvalues, and Fourier Spectrum

This workflow demonstrates three core mathematical methods in physics:

1. ODE integration for a harmonic oscillator.
2. Eigenvalue analysis for a coupled oscillator matrix.
3. Fourier analysis of the simulated displacement signal.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp
from scipy.linalg import eigh


MASS_KG = 1.0
SPRING_CONSTANT_N_PER_M = 25.0
OMEGA0_RAD_PER_S = np.sqrt(SPRING_CONSTANT_N_PER_M / MASS_KG)


def harmonic_oscillator(time_s: float, state: np.ndarray) -> list[float]:
    """
    Return derivatives for a simple harmonic oscillator.
    """
    displacement_m, velocity_m_per_s = state
    acceleration_m_per_s2 = -OMEGA0_RAD_PER_S**2 * displacement_m
    return [velocity_m_per_s, acceleration_m_per_s2]


def compute_ode_solution() -> pd.DataFrame:
    """
    Integrate the harmonic oscillator and return a time-domain table.
    """
    time_eval_s = np.linspace(0.0, 10.0, 2000)

    solution = solve_ivp(
        harmonic_oscillator,
        (0.0, 10.0),
        [1.0, 0.0],
        t_eval=time_eval_s,
        rtol=1e-10,
        atol=1e-12,
    )

    displacement_m = solution.y[0]
    velocity_m_per_s = solution.y[1]

    total_energy_j = (
        0.5 * MASS_KG * velocity_m_per_s**2
        + 0.5 * SPRING_CONSTANT_N_PER_M * displacement_m**2
    )

    return pd.DataFrame(
        {
            "time_s": solution.t,
            "displacement_m": displacement_m,
            "velocity_m_per_s": velocity_m_per_s,
            "total_energy_j": total_energy_j,
        }
    )


def compute_eigenvalue_example() -> pd.DataFrame:
    """
    Solve a two-degree-of-freedom normal-mode eigenvalue problem.
    """
    mass_matrix = np.array(
        [
            [1.0, 0.0],
            [0.0, 1.5],
        ]
    )

    stiffness_matrix = np.array(
        [
            [14.0, -4.0],
            [-4.0, 10.0],
        ]
    )

    eigenvalues, eigenvectors = eigh(stiffness_matrix, mass_matrix)
    omega_rad_per_s = np.sqrt(eigenvalues)

    return pd.DataFrame(
        {
            "mode": [1, 2],
            "omega_rad_per_s": omega_rad_per_s,
            "frequency_hz": omega_rad_per_s / (2.0 * np.pi),
            "mode_shape_component_1": eigenvectors[0, :],
            "mode_shape_component_2": eigenvectors[1, :],
        }
    )


def compute_fourier_spectrum(trajectory: pd.DataFrame) -> pd.DataFrame:
    """
    Compute the Fourier spectrum of the oscillator displacement.
    """
    time_s = trajectory["time_s"].to_numpy()
    displacement = trajectory["displacement_m"].to_numpy()

    dt = time_s[1] - time_s[0]
    frequencies_hz = np.fft.rfftfreq(len(displacement), d=dt)
    spectrum = np.abs(np.fft.rfft(displacement)) / len(displacement)

    return pd.DataFrame(
        {
            "frequency_hz": frequencies_hz,
            "fft_magnitude": spectrum,
        }
    ).sort_values("fft_magnitude", ascending=False)


def main() -> None:
    """
    Run the three mathematical-method examples and save outputs.
    """
    article_dir = Path(__file__).resolve().parents[1]
    trajectory_path = article_dir / "data" / "computed_ode_trajectory.csv"
    modes_path = article_dir / "data" / "computed_eigenvalue_modes.csv"
    spectrum_path = article_dir / "data" / "computed_fourier_spectrum.csv"
    summary_path = article_dir / "data" / "computed_ode_energy_summary.csv"

    trajectory = compute_ode_solution()
    modes = compute_eigenvalue_example()
    spectrum = compute_fourier_spectrum(trajectory)

    energy_summary = pd.DataFrame(
        [
            {
                "initial_energy_j": trajectory["total_energy_j"].iloc[0],
                "final_energy_j": trajectory["total_energy_j"].iloc[-1],
                "max_abs_energy_error_j": (
                    trajectory["total_energy_j"]
                    - trajectory["total_energy_j"].iloc[0]
                ).abs().max(),
                "expected_frequency_hz": OMEGA0_RAD_PER_S / (2.0 * np.pi),
            }
        ]
    )

    trajectory.to_csv(trajectory_path, index=False)
    modes.to_csv(modes_path, index=False)
    spectrum.to_csv(spectrum_path, index=False)
    energy_summary.to_csv(summary_path, index=False)

    print("ODE trajectory sample:")
    print(trajectory.head(10).round(8).to_string(index=False))
    print("\nEnergy summary:")
    print(energy_summary.round(10).to_string(index=False))
    print("\nNormal-mode eigenvalue example:")
    print(modes.round(8).to_string(index=False))
    print("\nDominant Fourier components:")
    print(spectrum.head(8).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

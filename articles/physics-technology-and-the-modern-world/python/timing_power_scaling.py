"""
Timing Error and Power Scaling

This workflow demonstrates two foundational technology relations:

1. Timing-derived position uncertainty:
       delta_d = c * delta_t

2. Power as energy per unit time:
       P = E / t

The examples are intentionally simple, but they capture core constraints
behind navigation, communication, energy systems, sensing, and instrumentation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


SPEED_OF_LIGHT_M_PER_S = 299_792_458.0


def timing_error_to_position_error(timing_error_ns: np.ndarray) -> np.ndarray:
    """
    Convert timing uncertainty in nanoseconds to position uncertainty in meters.

    Parameters
    ----------
    timing_error_ns:
        Timing uncertainty in nanoseconds.

    Returns
    -------
    np.ndarray
        Position uncertainty in meters.
    """
    timing_error_s = timing_error_ns * 1e-9
    return SPEED_OF_LIGHT_M_PER_S * timing_error_s


def power_from_energy(energy_j: np.ndarray, time_s: float) -> np.ndarray:
    """
    Compute power from energy and time.

    Parameters
    ----------
    energy_j:
        Energy in joules.
    time_s:
        Time interval in seconds.

    Returns
    -------
    np.ndarray
        Power in watts.
    """
    if time_s <= 0:
        raise ValueError("time_s must be positive.")

    return energy_j / time_s


def main() -> None:
    """
    Generate reproducible timing and power tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    timing_input = article_dir / "data" / "timing_error_examples.csv"
    timing_output = article_dir / "data" / "computed_timing_position_error.csv"
    power_output = article_dir / "data" / "computed_power_scaling.csv"

    timing_examples = pd.read_csv(timing_input)
    timing_examples["position_error_m"] = timing_error_to_position_error(
        timing_examples["timing_error_ns"].to_numpy(dtype=float)
    )

    energy_j = np.array([1, 10, 25, 50, 100, 250, 500], dtype=float)
    time_s = 5.0

    power_table = pd.DataFrame(
        {
            "energy_j": energy_j,
            "time_s": time_s,
            "power_w": power_from_energy(energy_j, time_s),
        }
    )

    timing_examples.to_csv(timing_output, index=False)
    power_table.to_csv(power_output, index=False)

    print("Timing uncertainty mapped to position uncertainty:")
    print(timing_examples.round(5).to_string(index=False))

    print("\nEnergy-to-power scaling:")
    print(power_table.round(5).to_string(index=False))

    print(f"\nSaved: {timing_output}")
    print(f"Saved: {power_output}")


if __name__ == "__main__":
    main()

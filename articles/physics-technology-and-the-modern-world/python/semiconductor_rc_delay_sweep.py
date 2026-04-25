"""
Semiconductor-Style RC Delay Parameter Sweep

This workflow models a simplified RC delay relation:

    tau = R * C

where:
    tau = characteristic delay in seconds
    R = resistance in ohms
    C = capacitance in farads

This is not a full semiconductor device model. It is a transparent
scaffolding example showing how physical parameters can be swept to
understand technology-relevant timing behavior.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def rc_delay_s(resistance_ohm: np.ndarray, capacitance_f: np.ndarray) -> np.ndarray:
    """
    Compute RC delay.

    Parameters
    ----------
    resistance_ohm:
        Resistance in ohms.
    capacitance_f:
        Capacitance in farads.

    Returns
    -------
    np.ndarray
        Characteristic delay in seconds.
    """
    return resistance_ohm * capacitance_f


def main() -> None:
    """
    Generate a small parameter sweep for resistance and capacitance.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "rc_delay_parameter_sweep.csv"

    resistance_values_ohm = np.array([10, 50, 100, 500, 1000], dtype=float)
    capacitance_values_f = np.array([1e-15, 5e-15, 1e-14, 5e-14, 1e-13], dtype=float)

    rows = []

    for resistance_ohm in resistance_values_ohm:
        for capacitance_f in capacitance_values_f:
            delay_s = rc_delay_s(resistance_ohm, capacitance_f)
            rows.append(
                {
                    "resistance_ohm": resistance_ohm,
                    "capacitance_f": capacitance_f,
                    "delay_s": delay_s,
                    "delay_ps": delay_s * 1e12,
                }
            )

    sweep = pd.DataFrame(rows)
    sweep.to_csv(output_path, index=False)

    print(sweep.to_string(index=False))
    print(f"\nSaved parameter sweep to: {output_path}")


if __name__ == "__main__":
    main()

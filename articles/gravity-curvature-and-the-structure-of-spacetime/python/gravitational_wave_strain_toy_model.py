"""
Gravitational-Wave Strain Toy Model

This workflow generates a simple sinusoidal strain signal:

    h(t) = h0 sin(2*pi*f*t)

This is not a waveform template, merger model, or detector-analysis pipeline.
It is only a compact scaffold for understanding strain as a tiny fractional
change in length.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def strain_signal(time_s: np.ndarray, amplitude: float, frequency_hz: float) -> np.ndarray:
    """
    Generate a simple sinusoidal strain signal.
    """
    return amplitude * np.sin(2.0 * np.pi * frequency_hz * time_s)


def main() -> None:
    """
    Generate a toy strain time series.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_gravitational_wave_strain_toy.csv"

    time_s = np.linspace(0.0, 0.1, 2000)
    amplitude = 1.0e-21
    frequency_hz = 150.0

    table = pd.DataFrame(
        {
            "time_s": time_s,
            "strain": strain_signal(time_s, amplitude, frequency_hz),
            "amplitude": amplitude,
            "frequency_hz": frequency_hz,
        }
    )

    table.to_csv(output_path, index=False)

    print("Toy gravitational-wave strain table:")
    print(table.head(12).to_string(index=False))
    print(f"\nSaved strain table to: {output_path}")


if __name__ == "__main__":
    main()

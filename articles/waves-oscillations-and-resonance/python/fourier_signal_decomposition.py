"""
Fourier Signal Decomposition

This workflow builds a synthetic signal from known sinusoidal components and
uses an FFT to recover dominant frequencies.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate a synthetic multi-frequency signal and compute FFT magnitudes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_fourier_signal_spectrum.csv"

    sample_rate_hz = 200.0
    duration_s = 4.0
    time_s = np.arange(0.0, duration_s, 1.0 / sample_rate_hz)

    signal = (
        1.0 * np.sin(2.0 * np.pi * 5.0 * time_s)
        + 0.4 * np.sin(2.0 * np.pi * 10.0 * time_s + 0.2)
        + 0.25 * np.sin(2.0 * np.pi * 15.0 * time_s - 0.3)
        + 0.15 * np.sin(2.0 * np.pi * 1.0 * time_s)
    )

    fft_values = np.fft.rfft(signal)
    frequencies_hz = np.fft.rfftfreq(len(signal), d=1.0 / sample_rate_hz)
    magnitudes = np.abs(fft_values) / len(signal)

    spectrum = pd.DataFrame(
        {
            "frequency_hz": frequencies_hz,
            "fft_magnitude": magnitudes,
        }
    )

    dominant = spectrum.sort_values("fft_magnitude", ascending=False).head(12)
    spectrum.to_csv(output_path, index=False)

    print("Dominant FFT components:")
    print(dominant.round(8).to_string(index=False))
    print(f"\nSaved spectrum to: {output_path}")


if __name__ == "__main__":
    main()

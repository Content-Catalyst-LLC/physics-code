"""
Fourier Noise Diagnostics

This workflow computes a simple single-sided amplitude spectrum
for simulated noisy measurement signals.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def compute_spectrum(group: pd.DataFrame, sampling_rate_hz: float) -> pd.DataFrame:
    """
    Compute single-sided amplitude spectrum for one signal group.
    """
    signal = group["measured_signal_v"].to_numpy()
    n_samples = len(signal)

    centered_signal = signal - np.mean(signal)
    frequencies = np.fft.rfftfreq(n_samples, d=1.0 / sampling_rate_hz)
    spectrum = np.fft.rfft(centered_signal)

    amplitude = 2.0 * np.abs(spectrum) / n_samples

    return pd.DataFrame(
        {
            "case_id": group["case_id"].iloc[0],
            "frequency_hz": frequencies,
            "amplitude_v": amplitude,
        }
    )


def main() -> None:
    """
    Compute spectra from generated signal data.
    """
    article_dir = Path(__file__).resolve().parents[1]
    signal_path = article_dir / "data" / "computed_noise_signals.csv"
    cases_path = article_dir / "data" / "noise_signal_cases.csv"
    output_path = article_dir / "data" / "computed_fourier_noise_diagnostics.csv"

    if not signal_path.exists():
        raise FileNotFoundError(
            "Run noise_snr_uncertainty.py before fourier_noise_diagnostics.py."
        )

    signals = pd.read_csv(signal_path)
    cases = pd.read_csv(cases_path).set_index("case_id")

    spectra = []

    for case_id, group in signals.groupby("case_id"):
        sampling_rate_hz = float(cases.loc[case_id, "sampling_rate_hz"])
        spectra.append(compute_spectrum(group, sampling_rate_hz))

    output = pd.concat(spectra, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Fourier diagnostics sample:")
    print(output.groupby("case_id").head(8).round(8).to_string(index=False))


if __name__ == "__main__":
    main()

"""
Noise, Signal-to-Noise Ratio, and Uncertainty Propagation

This workflow demonstrates:
1. noisy signal simulation
2. signal-to-noise ratio estimation
3. uncertainty propagation for R = V / I
"""

from pathlib import Path

import numpy as np
import pandas as pd


def simulate_signal(case: pd.Series) -> pd.DataFrame:
    """
    Simulate a sinusoidal voltage signal with additive Gaussian noise.
    """
    rng = np.random.default_rng(int(case["random_seed"]))

    n_samples = int(case["n_samples"])
    sampling_rate_hz = float(case["sampling_rate_hz"])

    time_s = np.arange(n_samples) / sampling_rate_hz

    clean_signal_v = float(case["signal_amplitude_v"]) * np.sin(
        2.0 * np.pi * float(case["signal_frequency_hz"]) * time_s
    )

    noise_v = rng.normal(
        loc=0.0,
        scale=float(case["noise_standard_deviation_v"]),
        size=n_samples,
    )

    measured_signal_v = clean_signal_v + noise_v

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "time_s": time_s,
            "clean_signal_v": clean_signal_v,
            "noise_v": noise_v,
            "measured_signal_v": measured_signal_v,
        }
    )


def estimate_signal_to_noise(signal_table: pd.DataFrame) -> pd.DataFrame:
    """
    Estimate signal-to-noise ratio by case.
    """
    rows = []

    for case_id, group in signal_table.groupby("case_id"):
        signal_rms = np.sqrt(np.mean(group["clean_signal_v"] ** 2))
        noise_rms = np.sqrt(np.mean(group["noise_v"] ** 2))
        snr_linear = signal_rms / noise_rms
        snr_db = 20.0 * np.log10(snr_linear)

        rows.append(
            {
                "case_id": case_id,
                "signal_rms_v": signal_rms,
                "noise_rms_v": noise_rms,
                "snr_linear": snr_linear,
                "snr_db": snr_db,
            }
        )

    return pd.DataFrame(rows)


def propagate_resistance_uncertainty(
    voltage_v: float,
    voltage_uncertainty_v: float,
    current_a: float,
    current_uncertainty_a: float,
) -> dict:
    """
    Propagate uncertainty for R = V / I.
    """
    resistance_ohm = voltage_v / current_a

    relative_uncertainty = np.sqrt(
        (voltage_uncertainty_v / voltage_v) ** 2
        + (current_uncertainty_a / current_a) ** 2
    )

    resistance_uncertainty_ohm = resistance_ohm * relative_uncertainty

    return {
        "voltage_v": voltage_v,
        "voltage_uncertainty_v": voltage_uncertainty_v,
        "current_a": current_a,
        "current_uncertainty_a": current_uncertainty_a,
        "resistance_ohm": resistance_ohm,
        "relative_uncertainty": relative_uncertainty,
        "resistance_uncertainty_ohm": resistance_uncertainty_ohm,
        "expanded_uncertainty_k2_ohm": 2.0 * resistance_uncertainty_ohm,
    }


def main() -> None:
    """
    Run signal simulation and uncertainty propagation.
    """
    article_dir = Path(__file__).resolve().parents[1]
    signal_cases_path = article_dir / "data" / "noise_signal_cases.csv"
    signal_output_path = article_dir / "data" / "computed_noise_signals.csv"
    snr_output_path = article_dir / "data" / "computed_snr_summary.csv"
    uncertainty_output_path = article_dir / "data" / "computed_resistance_uncertainty.csv"

    signal_cases = pd.read_csv(signal_cases_path)
    signal_tables = [simulate_signal(case) for _, case in signal_cases.iterrows()]
    signal_output = pd.concat(signal_tables, ignore_index=True)

    snr_summary = estimate_signal_to_noise(signal_output)

    resistance_summary = pd.DataFrame(
        [
            propagate_resistance_uncertainty(
                voltage_v=10.00,
                voltage_uncertainty_v=0.02,
                current_a=2.000,
                current_uncertainty_a=0.005,
            )
        ]
    )

    signal_output.to_csv(signal_output_path, index=False)
    snr_summary.to_csv(snr_output_path, index=False)
    resistance_summary.to_csv(uncertainty_output_path, index=False)

    print("Signal sample:")
    print(signal_output.groupby("case_id").head(3).round(6).to_string(index=False))

    print("\nSignal-to-noise summary:")
    print(snr_summary.round(6).to_string(index=False))

    print("\nResistance uncertainty summary:")
    print(resistance_summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

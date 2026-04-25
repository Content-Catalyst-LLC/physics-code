"""
Detector Signal Chain Simulation

This workflow simulates a simplified detector-style signal chain:

    measured_signal = gain * (true_signal + background_noise) + offset

It also applies a simple threshold decision.

The goal is to show how physical signal, background, gain, offset, and
thresholding create a measurement chain.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Load sample detector data and apply a simple signal-chain model.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "detector_signal_samples.csv"
    output_path = article_dir / "data" / "computed_detector_signal_chain.csv"

    signals = pd.read_csv(input_path)

    signals["analog_output"] = (
        signals["gain"] * (signals["true_signal"] + signals["background_noise"])
        + signals["offset"]
    )

    signals["triggered"] = signals["analog_output"] >= signals["threshold"]
    signals["signal_to_noise_ratio"] = signals["true_signal"] / signals["background_noise"]

    signals.to_csv(output_path, index=False)

    print("Detector-style signal-chain table:")
    print(signals.round(6).to_string(index=False))
    print(f"\nSaved signal-chain output to: {output_path}")


if __name__ == "__main__":
    main()

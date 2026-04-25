"""
Diode Current-Voltage Curve

This workflow computes the ideal diode equation:

    I = I_s [ exp(q V / (n k_B T)) - 1 ]

The model is intentionally idealized. Real diodes may require series
resistance, recombination current, high-level injection, breakdown,
temperature-dependent saturation current, and geometry-specific modeling.
"""

from pathlib import Path

import numpy as np
import pandas as pd


ELEMENTARY_CHARGE_C = 1.602176634e-19
BOLTZMANN_CONSTANT_J_K = 1.380649e-23


def diode_current_a(
    voltage_v: np.ndarray,
    saturation_current_a: float,
    ideality_factor: float,
    temperature_k: float,
) -> np.ndarray:
    """
    Compute ideal diode current for an array of voltages.
    """
    thermal_voltage_v = BOLTZMANN_CONSTANT_J_K * temperature_k / ELEMENTARY_CHARGE_C
    exponent = voltage_v / (ideality_factor * thermal_voltage_v)

    # Clip exponent to avoid numerical overflow in exploratory calculations.
    exponent = np.clip(exponent, -100.0, 100.0)

    return saturation_current_a * (np.exp(exponent) - 1.0)


def main() -> None:
    """
    Generate ideal diode current-voltage tables for sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "diode_parameter_cases.csv"
    output_path = article_dir / "data" / "computed_diode_iv_curves.csv"
    summary_path = article_dir / "data" / "computed_diode_iv_summary.csv"

    cases = pd.read_csv(input_path)
    frames = []

    for _, row in cases.iterrows():
        voltage_v = np.linspace(
            row["voltage_min_v"],
            row["voltage_max_v"],
            int(row["n_points"]),
        )

        current_a = diode_current_a(
            voltage_v,
            row["saturation_current_a"],
            row["ideality_factor"],
            row["temperature_k"],
        )

        thermal_voltage_v = (
            BOLTZMANN_CONSTANT_J_K * row["temperature_k"] / ELEMENTARY_CHARGE_C
        )

        frames.append(
            pd.DataFrame(
                {
                    "case_id": row["case_id"],
                    "voltage_v": voltage_v,
                    "current_a": current_a,
                    "current_density_a_cm2": current_a / row["area_cm2"],
                    "temperature_k": row["temperature_k"],
                    "thermal_voltage_v": thermal_voltage_v,
                    "ideality_factor": row["ideality_factor"],
                    "saturation_current_a": row["saturation_current_a"],
                    "area_cm2": row["area_cm2"],
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)

    summary = (
        output
        .groupby("case_id", as_index=False)
        .agg(
            min_current_a=("current_a", "min"),
            max_current_a=("current_a", "max"),
            thermal_voltage_v=("thermal_voltage_v", "first"),
            ideality_factor=("ideality_factor", "first"),
            saturation_current_a=("saturation_current_a", "first"),
        )
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Selected ideal diode I-V values:")
    selected = output[
        output["voltage_v"].round(2).isin([-0.5, -0.2, 0.0, 0.2, 0.4, 0.6, 0.8])
    ]
    print(selected.head(28).round(8).to_string(index=False))

    print("\nSummary:")
    print(summary.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

"""
Albedo Sensitivity

This workflow computes absorbed shortwave radiation and effective emission
temperature across albedo values.
"""

from pathlib import Path

import numpy as np
import pandas as pd


SOLAR_CONSTANT_W_M2 = 1361.0
STEFAN_BOLTZMANN = 5.670374419e-8


def main() -> None:
    """
    Compute albedo sensitivity table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_albedo_sensitivity.csv"

    albedo_values = np.linspace(0.10, 0.70, 121)

    absorbed_shortwave = SOLAR_CONSTANT_W_M2 * (1.0 - albedo_values) / 4.0
    emission_temperature = (absorbed_shortwave / STEFAN_BOLTZMANN) ** 0.25

    table = pd.DataFrame(
        {
            "planetary_albedo": albedo_values,
            "absorbed_shortwave_w_m2": absorbed_shortwave,
            "effective_emission_temperature_k": emission_temperature,
            "effective_emission_temperature_c": emission_temperature - 273.15,
        }
    )

    table.to_csv(output_path, index=False)

    print("Albedo sensitivity sample:")
    print(table.iloc[::20, :].round(6).to_string(index=False))
    print(f"\nSaved albedo sensitivity table to: {output_path}")


if __name__ == "__main__":
    main()

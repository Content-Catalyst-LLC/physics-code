"""
One-Layer Energy-Balance Model

This workflow integrates:

    C dT/dt = F(t) - lambda_feedback T

with approximate CO2 forcing:

    F = 5.35 ln(CO2 / CO2_reference)

This is a reduced climate-physics scaffold, not a comprehensive climate model.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


CO2_REFERENCE_PPM = 280.0
SECONDS_PER_YEAR = 365.25 * 24.0 * 3600.0


def co2_concentration_ppm(
    year: float,
    co2_initial_ppm: float,
    co2_final_ppm: float,
    years_end: float,
) -> float:
    """
    Return a linear CO2 pathway from initial to final concentration.
    """
    fraction = np.clip(year / years_end, 0.0, 1.0)
    return co2_initial_ppm + fraction * (co2_final_ppm - co2_initial_ppm)


def co2_forcing_w_m2(co2_ppm: float) -> float:
    """
    Compute approximate CO2 radiative forcing.
    """
    return 5.35 * np.log(co2_ppm / CO2_REFERENCE_PPM)


def integrate_case(row: pd.Series) -> pd.DataFrame:
    """
    Integrate one one-layer energy-balance case.
    """
    heat_capacity = row["heat_capacity_j_m2_k"]
    feedback = row["feedback_parameter_w_m2_k"]
    years_end = row["years_end"]

    def rhs(time_seconds: float, state: np.ndarray) -> list[float]:
        temperature = state[0]
        year = time_seconds / SECONDS_PER_YEAR
        co2_ppm = co2_concentration_ppm(
            year,
            row["co2_initial_ppm"],
            row["co2_final_ppm"],
            years_end,
        )
        forcing = co2_forcing_w_m2(co2_ppm)
        dtemperature_dt = (forcing - feedback * temperature) / heat_capacity
        return [dtemperature_dt]

    time_years = np.linspace(0.0, years_end, int(years_end * 4) + 1)
    time_seconds = time_years * SECONDS_PER_YEAR

    solution = solve_ivp(
        rhs,
        (time_seconds[0], time_seconds[-1]),
        y0=[0.0],
        t_eval=time_seconds,
        rtol=1e-9,
        atol=1e-11,
    )

    if not solution.success:
        raise RuntimeError(solution.message)

    temperature = solution.y[0]
    co2_values = np.array(
        [
            co2_concentration_ppm(
                year,
                row["co2_initial_ppm"],
                row["co2_final_ppm"],
                years_end,
            )
            for year in time_years
        ]
    )
    forcing = co2_forcing_w_m2(co2_values)
    imbalance = forcing - feedback * temperature

    return pd.DataFrame(
        {
            "case_id": row["case_id"],
            "year": time_years,
            "co2_ppm": co2_values,
            "forcing_w_m2": forcing,
            "temperature_anomaly_k": temperature,
            "equilibrium_temperature_for_current_forcing_k": forcing / feedback,
            "energy_imbalance_w_m2": imbalance,
        }
    )


def main() -> None:
    """
    Integrate all one-layer energy-balance cases and save results.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "energy_balance_parameters.csv"
    output_path = article_dir / "data" / "computed_one_layer_ebm_trajectories.csv"
    summary_path = article_dir / "data" / "computed_one_layer_ebm_summary.csv"

    cases = pd.read_csv(input_path)

    outputs = [
        integrate_case(row)
        for _, row in cases.iterrows()
    ]

    trajectory = pd.concat(outputs, ignore_index=True)

    summary = (
        trajectory
        .groupby("case_id", as_index=False)
        .tail(1)
        .loc[
            :,
            [
                "case_id",
                "co2_ppm",
                "forcing_w_m2",
                "temperature_anomaly_k",
                "equilibrium_temperature_for_current_forcing_k",
                "energy_imbalance_w_m2",
            ],
        ]
    )

    trajectory.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("One-layer EBM sample:")
    print(trajectory.head(12).round(6).to_string(index=False))
    print("\nFinal-year summary:")
    print(summary.round(6).to_string(index=False))
    print(f"\nSaved trajectories to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

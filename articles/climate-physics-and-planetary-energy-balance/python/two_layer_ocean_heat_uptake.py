"""
Two-Layer Ocean Heat Uptake Energy-Balance Model

This workflow integrates:

    Cu dTu/dt = F(t) - lambda Tu - kappa(Tu - Td)
    Cd dTd/dt = kappa(Tu - Td)

where:
    Tu = upper-layer temperature anomaly
    Td = deep-ocean temperature anomaly
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


CO2_REFERENCE_PPM = 280.0
SECONDS_PER_YEAR = 365.25 * 24.0 * 3600.0


def co2_pathway(year: float, initial: float, final: float, years_end: float) -> float:
    """
    Return a linear CO2 pathway.
    """
    fraction = np.clip(year / years_end, 0.0, 1.0)
    return initial + fraction * (final - initial)


def forcing_from_co2(co2_ppm: float) -> float:
    """
    Approximate CO2 forcing in W/m^2.
    """
    return 5.35 * np.log(co2_ppm / CO2_REFERENCE_PPM)


def integrate_case(row: pd.Series) -> pd.DataFrame:
    """
    Integrate one two-layer energy-balance case.
    """
    cu = row["upper_heat_capacity_j_m2_k"]
    cd = row["deep_heat_capacity_j_m2_k"]
    feedback = row["feedback_parameter_w_m2_k"]
    kappa = row["ocean_exchange_w_m2_k"]
    years_end = row["years_end"]

    def rhs(time_seconds: float, state: np.ndarray) -> list[float]:
        tu, td = state
        year = time_seconds / SECONDS_PER_YEAR
        co2 = co2_pathway(
            year,
            row["co2_initial_ppm"],
            row["co2_final_ppm"],
            years_end,
        )
        forcing = forcing_from_co2(co2)

        dtu_dt = (forcing - feedback * tu - kappa * (tu - td)) / cu
        dtd_dt = kappa * (tu - td) / cd

        return [dtu_dt, dtd_dt]

    time_years = np.linspace(0.0, years_end, int(years_end * 4) + 1)
    time_seconds = time_years * SECONDS_PER_YEAR

    solution = solve_ivp(
        rhs,
        (time_seconds[0], time_seconds[-1]),
        y0=[0.0, 0.0],
        t_eval=time_seconds,
        rtol=1e-9,
        atol=1e-11,
    )

    if not solution.success:
        raise RuntimeError(solution.message)

    tu = solution.y[0]
    td = solution.y[1]
    co2 = np.array(
        [
            co2_pathway(
                year,
                row["co2_initial_ppm"],
                row["co2_final_ppm"],
                years_end,
            )
            for year in time_years
        ]
    )
    forcing = forcing_from_co2(co2)
    ocean_heat_uptake = kappa * (tu - td)
    imbalance = forcing - feedback * tu - ocean_heat_uptake

    return pd.DataFrame(
        {
            "case_id": row["case_id"],
            "year": time_years,
            "co2_ppm": co2,
            "forcing_w_m2": forcing,
            "upper_layer_temperature_k": tu,
            "deep_layer_temperature_k": td,
            "ocean_heat_uptake_w_m2": ocean_heat_uptake,
            "upper_layer_energy_imbalance_w_m2": imbalance,
        }
    )


def main() -> None:
    """
    Integrate two-layer model cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "two_layer_parameters.csv"
    output_path = article_dir / "data" / "computed_two_layer_ebm_trajectories.csv"
    summary_path = article_dir / "data" / "computed_two_layer_ebm_summary.csv"

    cases = pd.read_csv(input_path)
    trajectory = pd.concat(
        [integrate_case(row) for _, row in cases.iterrows()],
        ignore_index=True,
    )

    summary = trajectory.groupby("case_id", as_index=False).tail(1)

    trajectory.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Two-layer EBM sample:")
    print(trajectory.head(12).round(6).to_string(index=False))
    print("\nFinal-year summary:")
    print(summary.round(6).to_string(index=False))


if __name__ == "__main__":
    main()

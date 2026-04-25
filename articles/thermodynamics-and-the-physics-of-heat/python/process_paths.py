"""
Thermodynamic Process Paths for an Ideal Gas

This workflow compares three ideal-gas process paths:

1. Reversible isothermal expansion
2. Reversible adiabatic expansion
3. Constant-pressure heating

It writes reusable CSV outputs for article, notebook, and dashboard work.
"""

from pathlib import Path

import numpy as np
import pandas as pd


R = 8.314_462_618


def isothermal_path(volume_m3: np.ndarray, amount_mol: float, temperature_k: float) -> pd.DataFrame:
    """
    Compute a reversible isothermal ideal-gas path.
    """
    pressure_pa = amount_mol * R * temperature_k / volume_m3

    return pd.DataFrame(
        {
            "process": "isothermal",
            "volume_m3": volume_m3,
            "temperature_k": temperature_k,
            "pressure_pa": pressure_pa,
        }
    )


def adiabatic_path(
    volume_m3: np.ndarray,
    initial_volume_m3: float,
    initial_pressure_pa: float,
    gamma: float,
) -> pd.DataFrame:
    """
    Compute a reversible adiabatic ideal-gas path using P V^gamma = constant.
    """
    constant = initial_pressure_pa * initial_volume_m3**gamma
    pressure_pa = constant / volume_m3**gamma

    return pd.DataFrame(
        {
            "process": "adiabatic",
            "volume_m3": volume_m3,
            "pressure_pa": pressure_pa,
        }
    )


def process_summary(
    amount_mol: float,
    initial_volume_m3: float,
    final_volume_m3: float,
    temperature_k: float,
    gamma: float,
    cv_j_per_mol_k: float,
) -> pd.DataFrame:
    """
    Compute compact summaries for idealized thermodynamic paths.
    """
    initial_pressure_pa = amount_mol * R * temperature_k / initial_volume_m3

    isothermal_work_j = amount_mol * R * temperature_k * np.log(final_volume_m3 / initial_volume_m3)
    isothermal_entropy_j_per_k = amount_mol * R * np.log(final_volume_m3 / initial_volume_m3)

    adiabatic_final_temperature_k = temperature_k * (
        initial_volume_m3 / final_volume_m3
    ) ** (gamma - 1.0)
    adiabatic_delta_u_j = amount_mol * cv_j_per_mol_k * (
        adiabatic_final_temperature_k - temperature_k
    )
    adiabatic_work_j = -adiabatic_delta_u_j

    constant_pressure_final_temperature_k = temperature_k * (
        final_volume_m3 / initial_volume_m3
    )
    constant_pressure_work_j = initial_pressure_pa * (final_volume_m3 - initial_volume_m3)
    constant_pressure_delta_u_j = amount_mol * cv_j_per_mol_k * (
        constant_pressure_final_temperature_k - temperature_k
    )
    constant_pressure_heat_j = constant_pressure_delta_u_j + constant_pressure_work_j

    return pd.DataFrame(
        [
            {
                "process": "reversible_isothermal",
                "work_done_by_gas_j": isothermal_work_j,
                "heat_added_j": isothermal_work_j,
                "delta_internal_energy_j": 0.0,
                "entropy_change_j_per_k": isothermal_entropy_j_per_k,
            },
            {
                "process": "reversible_adiabatic",
                "work_done_by_gas_j": adiabatic_work_j,
                "heat_added_j": 0.0,
                "delta_internal_energy_j": adiabatic_delta_u_j,
                "entropy_change_j_per_k": 0.0,
            },
            {
                "process": "constant_pressure_heating",
                "work_done_by_gas_j": constant_pressure_work_j,
                "heat_added_j": constant_pressure_heat_j,
                "delta_internal_energy_j": constant_pressure_delta_u_j,
                "entropy_change_j_per_k": np.nan,
            },
        ]
    )


def main() -> None:
    """
    Compute thermodynamic process paths and summary values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    path_output = article_dir / "data" / "computed_process_paths.csv"
    summary_output = article_dir / "data" / "computed_process_summary.csv"

    amount_mol = 1.0
    temperature_k = 300.0
    gamma = 1.4
    cv_j_per_mol_k = 20.786
    initial_volume_m3 = 0.02
    final_volume_m3 = 0.08

    volume_m3 = np.linspace(initial_volume_m3, final_volume_m3, 300)
    initial_pressure_pa = amount_mol * R * temperature_k / initial_volume_m3

    paths = pd.concat(
        [
            isothermal_path(volume_m3, amount_mol, temperature_k),
            adiabatic_path(volume_m3, initial_volume_m3, initial_pressure_pa, gamma),
        ],
        ignore_index=True,
    )

    summary = process_summary(
        amount_mol=amount_mol,
        initial_volume_m3=initial_volume_m3,
        final_volume_m3=final_volume_m3,
        temperature_k=temperature_k,
        gamma=gamma,
        cv_j_per_mol_k=cv_j_per_mol_k,
    )

    paths.to_csv(path_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Process path sample:")
    print(paths.head(12).round(6).to_string(index=False))

    print("\nProcess summary:")
    print(summary.round(6).to_string(index=False))

    print(f"\nSaved paths to: {path_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()

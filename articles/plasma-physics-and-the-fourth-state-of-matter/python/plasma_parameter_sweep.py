"""
Plasma Parameter Sweep

This workflow computes Debye length, plasma frequency, gyrofrequency,
gyroradius, plasma beta, and Alfven speed for sample plasma regimes.
"""

from pathlib import Path

import numpy as np
import pandas as pd


EPSILON_0 = 8.8541878128e-12
MU_0 = 1.25663706212e-6
E_CHARGE = 1.602176634e-19
ELECTRON_MASS = 9.1093837015e-31
AMU_KG = 1.66053906660e-27


def main() -> None:
    """
    Compute plasma parameters for sample regimes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "plasma_regime_cases.csv"
    output_path = article_dir / "data" / "computed_plasma_parameter_sweep.csv"

    cases = pd.read_csv(input_path)

    rows = []

    for _, row in cases.iterrows():
        ne = row["electron_density_m3"]
        te_j = row["electron_temperature_ev"] * E_CHARGE
        ti_j = row["ion_temperature_ev"] * E_CHARGE
        ion_mass = row["ion_mass_amu"] * AMU_KG
        b = row["magnetic_field_t"]
        z = row["charge_state"]

        debye_length = np.sqrt(EPSILON_0 * te_j / (ne * E_CHARGE**2))
        omega_pe = np.sqrt(ne * E_CHARGE**2 / (EPSILON_0 * ELECTRON_MASS))
        omega_ce = E_CHARGE * b / ELECTRON_MASS
        electron_thermal_speed = np.sqrt(te_j / ELECTRON_MASS)
        electron_larmor_radius = electron_thermal_speed / omega_ce if omega_ce > 0 else np.nan

        ion_density = ne / z
        mass_density = ion_density * ion_mass
        plasma_pressure = ne * te_j + ion_density * ti_j
        magnetic_pressure = b**2 / (2.0 * MU_0) if b > 0 else np.nan
        beta = plasma_pressure / magnetic_pressure if magnetic_pressure > 0 else np.nan
        alfven_speed = b / np.sqrt(MU_0 * mass_density) if mass_density > 0 else np.nan
        debye_sphere_particles = (4.0 * np.pi / 3.0) * ne * debye_length**3

        rows.append(
            {
                "case_id": row["case_id"],
                "electron_density_m3": ne,
                "electron_temperature_ev": row["electron_temperature_ev"],
                "magnetic_field_t": b,
                "debye_length_m": debye_length,
                "debye_sphere_particles": debye_sphere_particles,
                "electron_plasma_angular_frequency_rad_s": omega_pe,
                "electron_plasma_frequency_hz": omega_pe / (2.0 * np.pi),
                "electron_cyclotron_angular_frequency_rad_s": omega_ce,
                "electron_cyclotron_frequency_hz": omega_ce / (2.0 * np.pi),
                "electron_thermal_speed_m_s": electron_thermal_speed,
                "electron_larmor_radius_m": electron_larmor_radius,
                "plasma_pressure_pa": plasma_pressure,
                "magnetic_pressure_pa": magnetic_pressure,
                "plasma_beta": beta,
                "alfven_speed_m_s": alfven_speed,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Plasma parameter sweep:")
    print(output.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()

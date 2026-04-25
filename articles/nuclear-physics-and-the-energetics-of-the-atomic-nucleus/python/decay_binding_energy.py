"""
Decay Simulation and Binding Energy

This workflow demonstrates two foundational nuclear-physics calculations:

1. Exponential radioactive decay:
       N(t) = N0 * exp(-lambda * t)

2. Binding energy from mass defect:
       B = delta_m * c^2

For nuclear mass calculations in atomic mass units:
       1 u = 931.49410242 MeV/c^2

The values are educational examples. Use evaluated nuclear-mass and decay
data for precision work.
"""

from pathlib import Path

import numpy as np
import pandas as pd


U_TO_MEV = 931.49410242


def simulate_decay(initial_nuclei: float, decay_constant: float, time: np.ndarray) -> np.ndarray:
    """
    Simulate exponential radioactive decay.

    Parameters
    ----------
    initial_nuclei:
        Initial number of undecayed nuclei or normalized count value.
    decay_constant:
        Decay constant in inverse time units.
    time:
        Time values.

    Returns
    -------
    np.ndarray
        Number of undecayed nuclei at each time.
    """
    return initial_nuclei * np.exp(-decay_constant * time)


def half_life(decay_constant: float) -> float:
    """
    Convert decay constant to half-life.

    Parameters
    ----------
    decay_constant:
        Decay constant in inverse time units.

    Returns
    -------
    float
        Half-life in the same time unit used for the decay constant.
    """
    if decay_constant <= 0:
        raise ValueError("Decay constant must be positive.")

    return np.log(2.0) / decay_constant


def helium4_binding_energy_from_table(mass_table: pd.DataFrame) -> dict:
    """
    Compute a schematic helium-4 binding-energy estimate.

    Parameters
    ----------
    mass_table:
        Table containing proton_mass, neutron_mass, helium4_nuclear_mass,
        and u_to_mev rows.

    Returns
    -------
    dict
        Binding-energy calculation outputs.
    """
    values = dict(zip(mass_table["quantity"], mass_table["value_u"]))

    proton_mass_u = values["proton_mass"]
    neutron_mass_u = values["neutron_mass"]
    helium4_nuclear_mass_u = values["helium4_nuclear_mass"]
    u_to_mev = values["u_to_mev"]

    free_nucleon_mass_u = 2.0 * proton_mass_u + 2.0 * neutron_mass_u
    mass_defect_u = free_nucleon_mass_u - helium4_nuclear_mass_u
    binding_energy_mev = mass_defect_u * u_to_mev

    return {
        "free_nucleon_mass_u": free_nucleon_mass_u,
        "helium4_nuclear_mass_u": helium4_nuclear_mass_u,
        "mass_defect_u": mass_defect_u,
        "binding_energy_mev": binding_energy_mev,
        "binding_energy_per_nucleon_mev": binding_energy_mev / 4.0,
    }


def main() -> None:
    """
    Generate decay and binding-energy output tables.
    """
    article_dir = Path(__file__).resolve().parents[1]

    mass_input_path = article_dir / "data" / "helium4_mass_sample.csv"
    decay_output_path = article_dir / "data" / "computed_decay_simulation.csv"
    binding_output_path = article_dir / "data" / "computed_helium4_binding_energy.csv"

    time = np.linspace(0.0, 12.0, 49)
    decay_constant = 0.22
    initial_nuclei = 1000.0

    decay_table = pd.DataFrame(
        {
            "time": time,
            "decay_constant": decay_constant,
            "undecayed_nuclei": simulate_decay(initial_nuclei, decay_constant, time),
            "half_life": half_life(decay_constant),
        }
    )

    mass_table = pd.read_csv(mass_input_path)
    binding_table = pd.DataFrame([helium4_binding_energy_from_table(mass_table)])

    decay_table.to_csv(decay_output_path, index=False)
    binding_table.to_csv(binding_output_path, index=False)

    print("Radioactive decay simulation:")
    print(decay_table.head(10).round(6).to_string(index=False))

    print("\nHelium-4 binding-energy estimate:")
    print(binding_table.round(8).to_string(index=False))

    print(f"\nSaved decay table to: {decay_output_path}")
    print(f"Saved binding table to: {binding_output_path}")


if __name__ == "__main__":
    main()

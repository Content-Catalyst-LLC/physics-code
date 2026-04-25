"""
Hydrogen Spectral Lines and Photon Energies

This workflow computes hydrogen spectral wavelengths using the Rydberg formula:

    1 / lambda = R_H (1 / n_lower^2 - 1 / n_upper^2)

It then converts wavelength to photon energy:

    E = h c / lambda

The calculation is an introductory AMO scaffold. High-precision spectroscopy
requires reduced-mass corrections, fine structure, hyperfine structure,
Lamb shifts, isotope shifts, and uncertainty treatment.
"""

from pathlib import Path

import pandas as pd


RYDBERG_HYDROGEN_M_INV = 1.096775834e7
HC_EV_NM = 1239.841984


def wavelength_nm(n_lower: int, n_upper: int) -> float:
    """
    Compute transition wavelength in nanometers.

    The transition is from n_upper to n_lower, with n_upper > n_lower.
    """
    if n_upper <= n_lower:
        raise ValueError("n_upper must be greater than n_lower.")

    inverse_wavelength_m = RYDBERG_HYDROGEN_M_INV * (
        1.0 / n_lower**2 - 1.0 / n_upper**2
    )

    wavelength_m = 1.0 / inverse_wavelength_m
    return wavelength_m * 1.0e9


def photon_energy_ev(wavelength_nm_value: float) -> float:
    """
    Convert photon wavelength in nanometers to photon energy in electronvolts.
    """
    return HC_EV_NM / wavelength_nm_value


def photon_frequency_hz(wavelength_nm_value: float) -> float:
    """
    Convert wavelength in nanometers to photon frequency in hertz.
    """
    speed_of_light_m_s = 299792458.0
    wavelength_m = wavelength_nm_value * 1.0e-9
    return speed_of_light_m_s / wavelength_m


def classify_region(wavelength_nm_value: float) -> str:
    """
    Classify approximate electromagnetic spectral region by wavelength.
    """
    if wavelength_nm_value < 10:
        return "extreme_ultraviolet_or_xray"
    if wavelength_nm_value < 400:
        return "ultraviolet"
    if wavelength_nm_value < 700:
        return "visible"
    if wavelength_nm_value < 2500:
        return "near_infrared"
    return "infrared"


def main() -> None:
    """
    Build transition tables for selected hydrogen series.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases_path = article_dir / "data" / "hydrogen_series_cases.csv"
    output_path = article_dir / "data" / "computed_hydrogen_spectral_lines.csv"
    summary_path = article_dir / "data" / "computed_hydrogen_series_summary.csv"

    series_cases = pd.read_csv(cases_path)

    rows = []

    for _, row in series_cases.iterrows():
        for n_upper in range(int(row["n_upper_min"]), int(row["n_upper_max"]) + 1):
            n_lower = int(row["n_lower"])
            lambda_nm = wavelength_nm(n_lower, n_upper)
            energy_ev = photon_energy_ev(lambda_nm)

            rows.append(
                {
                    "series": row["series"],
                    "n_lower": n_lower,
                    "n_upper": n_upper,
                    "wavelength_nm": lambda_nm,
                    "photon_energy_ev": energy_ev,
                    "photon_frequency_hz": photon_frequency_hz(lambda_nm),
                    "spectral_region": classify_region(lambda_nm),
                }
            )

    transitions = pd.DataFrame(rows)

    summary = (
        transitions
        .groupby("series", as_index=False)
        .agg(
            min_wavelength_nm=("wavelength_nm", "min"),
            max_wavelength_nm=("wavelength_nm", "max"),
            min_photon_energy_ev=("photon_energy_ev", "min"),
            max_photon_energy_ev=("photon_energy_ev", "max"),
        )
    )

    transitions.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Hydrogen transition table:")
    print(transitions.round(6).to_string(index=False))

    print("\nSeries summary:")
    print(summary.round(6).to_string(index=False))

    print(f"\nSaved transitions to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()

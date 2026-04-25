"""
BAO Scale Scaffold

This workflow computes simple angular and radial BAO scalings using
a representative sound horizon and FLRW distances.
"""

from pathlib import Path

import numpy as np
import pandas as pd

from flrw_distances import C_KM_S, comoving_distance, e_z, load_parameters


def main() -> None:
    """
    Compute BAO angular and radial scale scaffolds.
    """
    article_dir = Path(__file__).resolve().parents[1]
    params = load_parameters(article_dir)

    h0 = float(params["H0"])
    omega_m = float(params["Omega_m"])
    omega_lambda = float(params["Omega_lambda"])

    bao_refs = pd.read_csv(article_dir / "data" / "bao_reference_scales.csv")
    sound_horizon = float(
        bao_refs.loc[bao_refs["quantity"] == "sound_horizon_rd", "value"].iloc[0]
    )

    redshifts = np.array([0.35, 0.5, 1.0, 2.0, 3.0])

    rows = []

    for z in redshifts:
        dm = comoving_distance(z, h0, omega_m, omega_lambda)
        hz = h0 * e_z(z, omega_m, omega_lambda)

        rows.append(
            {
                "redshift": z,
                "sound_horizon_mpc": sound_horizon,
                "transverse_comoving_distance_mpc": dm,
                "angular_bao_radians": sound_horizon / dm,
                "angular_bao_degrees": (sound_horizon / dm) * 180.0 / np.pi,
                "radial_delta_z_bao": hz * sound_horizon / C_KM_S,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(article_dir / "data" / "computed_bao_scale_scaffold.csv", index=False)

    print("BAO scale scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

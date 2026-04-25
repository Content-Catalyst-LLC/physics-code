"""
Diffusion Time Scale Grid

This workflow estimates diffusion time from:

    t ≈ L^2 / (2 d D)

where d is the spatial dimension.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Compute diffusion time scales for sample biological cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "diffusion_cases.csv"
    output_path = article_dir / "data" / "computed_diffusion_timescale_grid.csv"

    cases = pd.read_csv(input_path)

    cases["diffusion_time_s"] = (
        cases["length_um"] ** 2
        / (2.0 * cases["dimension"] * cases["diffusion_coefficient_um2_s"])
    )

    cases["diffusion_time_min"] = cases["diffusion_time_s"] / 60.0
    cases["diffusion_time_hr"] = cases["diffusion_time_s"] / 3600.0

    cases.to_csv(output_path, index=False)

    print("Diffusion time scale grid:")
    print(cases.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

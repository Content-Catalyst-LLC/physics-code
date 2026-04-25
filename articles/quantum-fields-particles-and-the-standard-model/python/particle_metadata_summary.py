"""
Standard Model Particle Metadata Summary

This workflow summarizes a small Standard Model particle metadata table by
category, spin, charge, and interaction flags.

It is designed as a reproducible data-organization scaffold, not as a
complete evaluated particle-property database.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Load and summarize sample Standard Model particle metadata.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "standard_model_particles.csv"
    output_path = article_dir / "data" / "computed_particle_metadata_summary.csv"

    particles = pd.read_csv(input_path)

    summary = (
        particles.groupby("category")
        .agg(
            n_particles=("particle", "count"),
            mean_spin=("spin", "mean"),
            min_charge_e=("charge_e", "min"),
            max_charge_e=("charge_e", "max"),
        )
        .reset_index()
    )

    summary.to_csv(output_path, index=False)

    print("Particle metadata:")
    print(particles.to_string(index=False))

    print("\nParticle summary by category:")
    print(summary.to_string(index=False))

    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()

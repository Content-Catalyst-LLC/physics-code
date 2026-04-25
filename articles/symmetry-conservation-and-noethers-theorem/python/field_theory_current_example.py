"""
Field-Theory Current Example

This workflow records the schematic Noether current for a complex scalar
field with global U(1) phase symmetry.

For a complex scalar field:
    L = partial_mu phi* partial^mu phi - m^2 phi* phi

Global phase symmetry:
    phi -> exp(i alpha) phi

Noether current:
    j^mu = i(phi* partial^mu phi - phi partial^mu phi*)
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Save field-theory current examples as structured metadata.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_field_theory_current_examples.csv"

    rows = [
        {
            "case_id": "complex_scalar_global_u1",
            "lagrangian_density": "partial_mu phi_star partial^mu phi - m^2 phi_star phi",
            "symmetry": "global U(1) phase",
            "transformation": "phi -> exp(i alpha) phi",
            "noether_current": "j^mu = i(phi_star partial^mu phi - phi partial^mu phi_star)",
            "conservation_law": "partial_mu j^mu = 0",
        },
        {
            "case_id": "spacetime_translation",
            "lagrangian_density": "generic spacetime-translation invariant field theory",
            "symmetry": "spacetime translation",
            "transformation": "x^mu -> x^mu + a^mu",
            "noether_current": "stress-energy tensor T^mu_nu",
            "conservation_law": "partial_mu T^mu_nu = 0",
        },
    ]

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Field-theory current examples:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()

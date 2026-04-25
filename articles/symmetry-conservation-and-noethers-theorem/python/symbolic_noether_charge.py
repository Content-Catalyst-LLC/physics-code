"""
Symbolic Noether Charge Examples

This workflow uses SymPy to show simple canonical momenta
and Hamiltonians for elementary systems.

It is a teaching scaffold, not a full variational-calculus engine.
"""

from pathlib import Path

import pandas as pd
import sympy as sp


def main() -> None:
    """
    Compute symbolic canonical momenta and Hamiltonians.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_symbolic_noether_examples.csv"

    m, k, q, qdot = sp.symbols("m k q qdot", positive=True)

    lagrangian_oscillator = sp.Rational(1, 2) * m * qdot**2 - sp.Rational(1, 2) * k * q**2
    canonical_momentum = sp.diff(lagrangian_oscillator, qdot)
    hamiltonian = sp.simplify(canonical_momentum * qdot - lagrangian_oscillator)

    theta, thetadot, I = sp.symbols("theta thetadot I", positive=True)
    lagrangian_rotor = sp.Rational(1, 2) * I * thetadot**2
    angular_momentum = sp.diff(lagrangian_rotor, thetadot)
    rotor_hamiltonian = sp.simplify(angular_momentum * thetadot - lagrangian_rotor)

    rows = [
        {
            "case_id": "harmonic_oscillator",
            "lagrangian": str(lagrangian_oscillator),
            "cyclic_coordinate": "none",
            "canonical_momentum": str(canonical_momentum),
            "hamiltonian": str(hamiltonian),
            "conserved_quantity": "energy if no explicit time dependence",
        },
        {
            "case_id": "free_rotor",
            "lagrangian": str(lagrangian_rotor),
            "cyclic_coordinate": "theta",
            "canonical_momentum": str(angular_momentum),
            "hamiltonian": str(rotor_hamiltonian),
            "conserved_quantity": "angular momentum conjugate to theta",
        },
    ]

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Symbolic Noether examples:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()

"""
Creation and Annihilation Operators in Truncated Fock Space

This workflow builds finite-dimensional matrix approximations to
harmonic oscillator ladder operators.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def annihilation_operator(dimension: int) -> np.ndarray:
    """
    Construct annihilation operator matrix in a truncated Fock basis.
    """
    operator = np.zeros((dimension, dimension), dtype=float)

    for n in range(1, dimension):
        operator[n - 1, n] = np.sqrt(n)

    return operator


def creation_operator(dimension: int) -> np.ndarray:
    """
    Construct creation operator as transpose of annihilation operator.
    """
    return annihilation_operator(dimension).T


def run_case(case: pd.Series) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Run one Fock-space truncation case.
    """
    dimension = int(case["fock_dimension"])
    hbar = float(case["hbar"])
    omega = float(case["omega"])

    a = annihilation_operator(dimension)
    adag = creation_operator(dimension)

    number_operator = adag @ a
    hamiltonian = hbar * omega * (number_operator + 0.5 * np.eye(dimension))
    commutator = a @ adag - adag @ a

    diagnostics = []

    for n in range(dimension):
        basis_state = np.zeros(dimension)
        basis_state[n] = 1.0

        lowered = a @ basis_state
        raised = adag @ basis_state

        diagnostics.append(
            {
                "case_id": case["case_id"],
                "n": n,
                "number_expectation": basis_state @ number_operator @ basis_state,
                "energy_expectation": basis_state @ hamiltonian @ basis_state,
                "lowered_norm": np.linalg.norm(lowered),
                "raised_norm": np.linalg.norm(raised),
                "commutator_diagonal": commutator[n, n],
            }
        )

    summary = pd.DataFrame(
        [
            {
                "case_id": case["case_id"],
                "fock_dimension": dimension,
                "omega": omega,
                "max_energy": np.max(np.linalg.eigvalsh(hamiltonian)),
                "commutator_trace": np.trace(commutator),
                "top_state_commutator_diagonal": commutator[-1, -1],
                "notes": case["notes"],
            }
        ]
    )

    return pd.DataFrame(diagnostics), summary


def main() -> None:
    """
    Build ladder operators for all sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "fock_mode_cases.csv"
    diagnostics_path = article_dir / "data" / "computed_fock_ladder_diagnostics.csv"
    summary_path = article_dir / "data" / "computed_fock_ladder_summary.csv"

    cases = pd.read_csv(input_path)

    diagnostics_frames = []
    summary_frames = []

    for _, case in cases.iterrows():
        diagnostics, summary = run_case(case)
        diagnostics_frames.append(diagnostics)
        summary_frames.append(summary)

    diagnostics_output = pd.concat(diagnostics_frames, ignore_index=True)
    summary_output = pd.concat(summary_frames, ignore_index=True)

    diagnostics_output.to_csv(diagnostics_path, index=False)
    summary_output.to_csv(summary_path, index=False)

    print("Fock ladder diagnostics sample:")
    print(diagnostics_output.groupby("case_id").head(4).round(8).to_string(index=False))

    print("\nFock ladder summary:")
    print(summary_output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

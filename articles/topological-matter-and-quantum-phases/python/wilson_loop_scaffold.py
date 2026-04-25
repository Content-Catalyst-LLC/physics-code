"""
Wilson Loop Scaffold

This simplified scaffold records phase winding for the SSH model as a
one-dimensional Wilson-loop-like Berry phase proxy.

For a full Wilson-loop calculation in multi-band systems, use a validated
band-topology workflow with smooth gauges or gauge-invariant link variables.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def ssh_phase_winding(t1: float, t2: float, n_grid: int = 2000) -> dict:
    """
    Compute phase winding of q(k)=t1+t2 exp(-ik).
    """
    k = np.linspace(-np.pi, np.pi, n_grid, endpoint=False)
    q = t1 + t2 * np.exp(-1j * k)

    phase = np.unwrap(np.angle(q))
    winding = (phase[-1] - phase[0]) / (2.0 * np.pi)

    return {
        "t1": t1,
        "t2": t2,
        "raw_winding": winding,
        "winding_rounded": int(np.round(winding)),
        "berry_phase_proxy_radians": float(phase[-1] - phase[0]),
    }


def main() -> None:
    """
    Generate Wilson-loop-like SSH winding proxy table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "ssh_parameter_cases.csv")

    rows = []

    for _, case in cases.iterrows():
        result = ssh_phase_winding(float(case["t1"]), float(case["t2"]))
        result.update({"case_id": case["case_id"], "notes": case["notes"]})
        rows.append(result)

    output = pd.DataFrame(rows)
    output.to_csv(article_dir / "data" / "computed_wilson_loop_scaffold.csv", index=False)

    print("Wilson-loop scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

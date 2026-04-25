"""
Renormalization Group Toy Flow

This workflow applies the linear RG scaling relation:

    u' = b^y u

where:
    u = perturbation amplitude
    b = scale factor
    y = RG eigenvalue
"""

from pathlib import Path

import pandas as pd


def run_flow(case: pd.Series) -> pd.DataFrame:
    """
    Run one RG toy flow case.
    """
    value = float(case["u_initial"])
    rows = []

    for step in range(int(case["n_steps"]) + 1):
        rows.append(
            {
                "case_id": case["case_id"],
                "step": step,
                "u_value": value,
                "y_exponent": case["y_exponent"],
                "scale_factor": case["scale_factor"],
                "notes": case["notes"],
            }
        )

        value = (case["scale_factor"] ** case["y_exponent"]) * value

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run RG toy flows.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "rg_flow_cases.csv"
    output_path = article_dir / "data" / "computed_rg_toy_flows.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_flow(case) for _, case in cases.iterrows()], ignore_index=True)

    output.to_csv(output_path, index=False)

    print("RG toy flows:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()

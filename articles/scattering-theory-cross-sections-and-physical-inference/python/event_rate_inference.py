"""
Event-Rate Inference

Computes expected counts:

    N_obs = L_int * sigma * efficiency * acceptance + background

where L_int is in inverse femtobarns and sigma is in femtobarns.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.stats import poisson


def run_case(case: pd.Series) -> dict:
    """
    Compute expected signal and observed-event scaffold for one case.
    """
    signal = (
        float(case["integrated_luminosity_inv_fb"])
        * float(case["cross_section_fb"])
        * float(case["efficiency"])
        * float(case["acceptance"])
    )

    background = float(case["background_events"])
    total_mean = signal + background

    # Asimov count: representative expected count without random fluctuation.
    observed_asimov = total_mean

    # Approximate discovery-like signal-to-root-background metric.
    s_over_sqrt_b = signal / np.sqrt(background) if background > 0 else np.inf

    # Probability of observing at least the Asimov rounded count under background only.
    rounded_count = int(round(observed_asimov))
    p_background_tail = 1.0 - poisson.cdf(rounded_count - 1, background)

    return {
        "case_id": case["case_id"],
        "expected_signal_events": signal,
        "background_events": background,
        "expected_total_events": total_mean,
        "asimov_observed_events": observed_asimov,
        "s_over_sqrt_b": s_over_sqrt_b,
        "background_only_tail_probability_at_asimov_count": p_background_tail,
        "notes": case["notes"],
    }


def main() -> None:
    """
    Compute event-rate inference scaffolds.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "event_rate_cases.csv")

    output = pd.DataFrame([run_case(case) for _, case in cases.iterrows()])
    output.to_csv(article_dir / "data" / "computed_event_rate_inference.csv", index=False)

    print("Event-rate inference summary:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()

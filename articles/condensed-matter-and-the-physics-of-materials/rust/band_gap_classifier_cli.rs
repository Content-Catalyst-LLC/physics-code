// Band-Gap Classifier CLI
//
// This Rust utility classifies materials using simplified band-gap thresholds.
// Real material classification depends on more than band gap alone.

fn classify_band_gap(band_gap_ev: f64) -> &'static str {
    if band_gap_ev <= 0.05 {
        "metal_or_semimetal_like"
    } else if band_gap_ev < 3.0 {
        "semiconductor_like"
    } else {
        "insulator_like"
    }
}

fn main() {
    let materials = [
        ("Copper", 0.0_f64),
        ("Silicon", 1.12_f64),
        ("Germanium", 0.66_f64),
        ("Gallium arsenide", 1.42_f64),
        ("Diamond", 5.47_f64),
        ("Sodium chloride", 8.5_f64),
    ];

    println!("material,band_gap_ev,simplified_classification");

    for (material, band_gap_ev) in materials {
        println!("{},{:.4},{}", material, band_gap_ev, classify_band_gap(band_gap_ev));
    }
}

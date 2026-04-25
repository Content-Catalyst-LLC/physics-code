// Group Theory CLI
//
// This Rust utility computes spin-j dimensions, Casimir eigenvalues,
// and basic C3 character-decomposition diagnostics.

fn spin_dimension(j_times_two: i32) -> i32 {
    j_times_two + 1
}

fn casimir_eigenvalue(j: f64, hbar: f64) -> f64 {
    hbar * hbar * j * (j + 1.0)
}

fn main() {
    let spin_values = [0.5_f64, 1.0, 1.5, 2.0, 3.0];

    println!("quantity,value");

    for j in spin_values {
        let j_times_two = (2.0 * j).round() as i32;
        println!("spin_{}_dimension,{}", j, spin_dimension(j_times_two));
        println!("spin_{}_casimir_hbar1,{:.12}", j, casimir_eigenvalue(j, 1.0));
    }

    println!("c3_regular_representation_multiplicity_each_irrep,1");
}

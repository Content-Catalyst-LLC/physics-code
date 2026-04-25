// Macroscopic Quantum Order CLI
//
// Computes flux quantum states and simple Josephson current values.

fn main() {
    let flux_quantum = 2.067833848e-15_f64;

    println!("quantity,index,value");
    for n in -5..=5 {
        println!("flux_state,{},{}", n, n as f64 * flux_quantum);
    }

    for step in 0..=8 {
        let phase = step as f64 * std::f64::consts::PI / 4.0;
        println!("josephson_current_phase,{:.6},{:.12}", phase, phase.sin());
    }
}

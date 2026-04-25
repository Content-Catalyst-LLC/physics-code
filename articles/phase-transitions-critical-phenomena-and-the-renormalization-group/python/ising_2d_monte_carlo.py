"""
2D Ising Model Monte Carlo Simulation

This workflow simulates a square-lattice Ising model:

    H = -J sum_<i,j> s_i s_j

with periodic boundary conditions and Metropolis updates.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def initialize_lattice(rng: np.random.Generator, size: int) -> np.ndarray:
    """
    Initialize spins randomly as +1 or -1.
    """
    return rng.choice([-1, 1], size=(size, size))


def local_energy_change(lattice: np.ndarray, i: int, j: int, coupling: float) -> float:
    """
    Compute energy change from flipping one spin.
    """
    size = lattice.shape[0]
    spin = lattice[i, j]

    neighbor_sum = (
        lattice[(i + 1) % size, j]
        + lattice[(i - 1) % size, j]
        + lattice[i, (j + 1) % size]
        + lattice[i, (j - 1) % size]
    )

    return 2.0 * coupling * spin * neighbor_sum


def metropolis_sweep(
    lattice: np.ndarray,
    temperature: float,
    coupling: float,
    rng: np.random.Generator,
) -> None:
    """
    Perform one Monte Carlo sweep using random single-spin updates.
    """
    size = lattice.shape[0]
    n_sites = size * size

    for _ in range(n_sites):
        i = rng.integers(0, size)
        j = rng.integers(0, size)

        delta_energy = local_energy_change(lattice, i, j, coupling)

        if delta_energy <= 0.0:
            lattice[i, j] *= -1
        else:
            if rng.random() < np.exp(-delta_energy / temperature):
                lattice[i, j] *= -1


def total_energy(lattice: np.ndarray, coupling: float) -> float:
    """
    Compute total Ising energy with periodic boundaries.
    """
    right_neighbors = np.roll(lattice, shift=-1, axis=1)
    down_neighbors = np.roll(lattice, shift=-1, axis=0)

    return -coupling * np.sum(lattice * right_neighbors + lattice * down_neighbors)


def run_temperature(
    temperature: float,
    lattice_size: int,
    coupling: float,
    n_thermalization_sweeps: int,
    n_measurement_sweeps: int,
    rng: np.random.Generator,
) -> dict:
    """
    Run simulation for one temperature and return summary statistics.
    """
    lattice = initialize_lattice(rng, lattice_size)
    n_sites = lattice_size * lattice_size

    for _ in range(n_thermalization_sweeps):
        metropolis_sweep(lattice, temperature, coupling, rng)

    energy_samples = []
    magnetization_samples = []

    for _ in range(n_measurement_sweeps):
        metropolis_sweep(lattice, temperature, coupling, rng)

        energy = total_energy(lattice, coupling)
        magnetization = np.sum(lattice)

        energy_samples.append(energy / n_sites)
        magnetization_samples.append(magnetization / n_sites)

    energy_array = np.array(energy_samples)
    magnetization_array = np.array(magnetization_samples)
    abs_magnetization_array = np.abs(magnetization_array)

    heat_capacity = n_sites * np.var(energy_array) / temperature**2
    susceptibility = n_sites * np.var(abs_magnetization_array) / temperature

    return {
        "temperature": temperature,
        "mean_energy_per_spin": np.mean(energy_array),
        "mean_abs_magnetization": np.mean(abs_magnetization_array),
        "heat_capacity": heat_capacity,
        "susceptibility": susceptibility,
        "energy_sd": np.std(energy_array),
        "abs_magnetization_sd": np.std(abs_magnetization_array),
    }


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Run all temperatures for one simulation case.
    """
    rng = np.random.default_rng(int(case["random_seed"]))
    temperatures = np.linspace(
        case["temperature_min"],
        case["temperature_max"],
        int(case["n_temperatures"]),
    )

    results = []

    for temperature in temperatures:
        result = run_temperature(
            temperature=temperature,
            lattice_size=int(case["lattice_size"]),
            coupling=float(case["coupling_j"]),
            n_thermalization_sweeps=int(case["n_thermalization_sweeps"]),
            n_measurement_sweeps=int(case["n_measurement_sweeps"]),
            rng=rng,
        )
        result["case_id"] = case["case_id"]
        result["lattice_size"] = int(case["lattice_size"])
        result["notes"] = case["notes"]
        results.append(result)

    return pd.DataFrame(results)


def main() -> None:
    """
    Run configured Ising simulations and save output.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "ising_simulation_cases.csv"
    output_path = article_dir / "data" / "computed_ising_2d_monte_carlo.csv"

    cases = pd.read_csv(input_path)
    outputs = [run_case(case) for _, case in cases.iterrows()]
    result_table = pd.concat(outputs, ignore_index=True)

    result_table.to_csv(output_path, index=False)

    print("2D Ising Monte Carlo summary:")
    print(result_table.round(6).to_string(index=False))


if __name__ == "__main__":
    main()

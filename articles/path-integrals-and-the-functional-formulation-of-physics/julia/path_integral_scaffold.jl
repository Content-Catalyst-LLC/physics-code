# Path Integral Scaffold
#
# This Julia workflow computes a discretized Euclidean harmonic oscillator action.

function euclidean_action(path, mass, omega, delta_tau)
    n = length(path)
    total = 0.0

    for i in 1:n
        j = i == n ? 1 : i + 1
        kinetic = mass / (2.0 * delta_tau) * (path[j] - path[i])^2
        potential = 0.5 * delta_tau * mass * omega^2 * path[i]^2
        total += kinetic + potential
    end

    return total
end

function main()
    n_steps = 100
    beta = 4.0
    delta_tau = beta / n_steps
    tau = [delta_tau * (i - 1) for i in 1:n_steps]

    zero_path = zeros(n_steps)
    sine_path = [sin(2.0 * pi * t / beta) for t in tau]
    rough_path = [sin(2.0 * pi * t / beta) + 0.25 * sin(10.0 * pi * t / beta) for t in tau]

    println("path_name,euclidean_action,path_weight")
    for (name, path) in [("zero_path", zero_path), ("sine_path", sine_path), ("rough_path", rough_path)]
        action = euclidean_action(path, 1.0, 1.0, delta_tau)
        println("$name,$action,$(exp(-action))")
    end
end

main()

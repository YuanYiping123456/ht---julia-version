# using DifferentialEquations
using OrdinaryDiffEq, ModelingToolkit, DiffEqOperators, DomainSets
using Plots

function ht_model(boundarydata, parameter, dx, dt)

    top_boundarydata = boundarydata
    left_boundarydata, bottom_boundarydata = 300, 300
    cₐ, kₐ, L = parameter[1, 1], parameter[1, 2], parameter[1, 3]
    if dx > L
        println("精度选择有误...")
    end

    @parameters t x
    @variables u(..)
    Dt = Differential(t)
    Dxx = Differential(x)^2

    eq  = Dt(u(t, x)) ~ (kₐ / cₐ) * Dxx(u(t, x))
    bcs = [u(0, x) ~ Float64(top_boundarydata[1]) * t .+ Float64(top_boundarydata[2]),
           u(t, 0) ~ Float64(left_boundarydata),
           u(t, Float64(1)) ~ Float64(bottom_boundarydata)]

    domains = [t ∈ Interval(0.0, 1.0), x ∈ Interval(0.0, Float64(L))]
    @named pdesys = PDESystem(eq, bcs, domains, [t, x], [u(t, x)])

    # dx = 0.00001
    order = 2
    discretization = MOLFiniteDifference([x => dx], t; centered_order = order)
    prob = discretize(pdesys, discretization)
    # dt = 0.02
    sol = solve(prob, Tsit5(); saveat = dt)

    return sol
    # return sol[Int64(round(L/dx) - 1),:]

end


# top_boundarydata, left_boundarydata, bottom_boundarydata = 3000, 300, 300

# @parameters t x
# @variables u(..)
# Dt = Differential(t)
# Dxx = Differential(x)^2

# eq  = Dt(u(t, x)) ~ 0.05 * Dxx(u(t, x))
# bcs = [u(0, x) ~ Float64(top_boundarydata), u(t, 0) ~ Float64(left_boundarydata), u(t, Float64(1)) ~ Float64(bottom_boundarydata)]

# domains = [t ∈ Interval(0.0, 1.0), x ∈ Interval(0.0, Float64(1))]
# @named pdesys = PDESystem(eq, bcs, domains, [t, x], [u(t, x)])
# dx = 0.1
# order = 2
# discretization = MOLFiniteDifference([x => dx], t; centered_order = order)
# prob = discretize(pdesys, discretization)

# sol = solve(prob, Tsit5(); saveat = 0.05)

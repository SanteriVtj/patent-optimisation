module PatentModel

import Base.@kwdef
export Data, patentparams, simulate_data, smm, hello

@kwdef struct Data
    y::Array{Float64}
    fee::Array{Real}
    sample::Array{Float64}
    T::Int
    P::Int
    ν::Float64
    s::Array{Float64}
end

@kwdef mutable struct patentparams
    δ::Float64
    θ::Float64
    ϕ::Float64
    σ::Real
    γ::Float64
end

function simulate_svdata(par::patentparams, data::Data)
    δ = par.δ
    logδ = log(δ)
    θ = par.θ
    ϕ = par.ϕ
    σ = par.σ
    γ = par.γ

    r̄ = data.fee
    sample = data.sample
    T = data.T
    P = data.P

    μ₁ = ϕ.^(1:T).*σ.*(1 - γ)
    σ²₁ = μ₁.^2

    μ = 2*log.(μ₁)-1/2*log.(σ²₁+μ₁.^2)
    σ² = -2*log.(μ₁)+log.(σ²₁+μ₁.^2)

    N = sample*σ²'.+μ'

    s = s .≤ θ

    r = zeros(size(N))
    r[:,1] = N[:,1]
    r_dum = zeros(size(N))
    r_dum[:,1] = Int.(N[:,1] .> r̄[1])

    for i in 2:T
        r[:,i] = s.*maximum(hcat(r[:,i-1], logδ+N[:,i]))
        r_dum[:,i] = Int.(r[:,i] .> r̄[i])
    end

    ll = cumsum(-log1p.((r.-log.(c))./ν))

    survive = sum(r̄, dims=1)
    lapse = P .- survive
    lapse_cumulative = 
end

function smm(par::patentparams, data::Data)
    println("hello")
end

hello() = println("hello")

end # module

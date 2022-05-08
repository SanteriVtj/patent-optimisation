module PatentModel

import Base.@kwdef
export Data, params, simulate_data, smm, hello

@kwdef struct Data
    y::Array{Float64}
    fee::Array{Real}
    sample::Array{Float64}
    T::Int
    P::Int
end

@kwdef mutable struct params
    δ::Float64
    θ::Float64
    ϕ::Float64
    σ::Real
    γ::Float64
end

function simulate_svdata(par::params, data::Data)
    δ = par.δ
    θ = par.θ
    ϕ = par.ϕ
    σ = par.σ
    γ = par.γ

    fee = data.fee
    sample = data.sample
    T = data.T
    P = data.P

    μ₁ = ϕ.^(1:T).*σ.*(1 - γ)
    σ²₁ = μ₁.^2

    μ = 2*log.(μ₁)-1/2*log.(σ²₁+μ₁.^2)
    σ² = -2*log.(μ₁)+log.(σ²₁+μ₁.^2)

    N = sample*σ²'.+μ'

    r = zeros(size(N))
    r[:,1] = N[:,1]
    r̄ = zeros(size(N))
    r̄[:,1] = Int.(N[:,1] .> fee[1])

    for i in 2:T
        r[:,i] = maximum(hcat(r[:,i-1], δ*N[:,i]))
        r̄[:,i] = Int.(r[:,i] .> fee[i])
    end

    survive = sum(r̄, dims=1)
    lapse = P .- survive
    lapse_cumulative = 
end

function smm(par::params, data::Data)
    println("hello")
end

hello() = println("hello")

end # module

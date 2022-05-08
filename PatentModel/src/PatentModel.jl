module PatentModel

export Data, params, simulate_data, smm, hello

struct Data
    y::Array{Float64}
    c::Array{Real}
    sample::Array{Float64}
    T::Int
end

mutable struct params
    δ::Float64
    θ::Float64
    ϕ::Float64
    σ::Float64
    γ::Float64
end

function simulate_data(par::params, data::Data)
    δ = par.δ
    θ = par.θ
    ϕ = par.ϕ
    σ = par.σ
    γ = par.γ

    c = data.c
    sample = data.sample

    μ₁ = ϕ.^(1:T).*σ.*(1 - γ)
    σ²₁ = μ₁.^2

    μ = 2*log.()
    σ² = 

    Nₛ = sample 
end

function smm(par::params, data::Data)
    println("hello")
end

hello() = println("hello")

end # module

## adding layers 
Base.@kwdef struct SoilLayersX{FT<:AbstractFloat}
    layer1::Array{FT,1} = [0.0,10.0] # in centimeter
    layer2::Array{FT,1} = [10.0,30.0]
    layer3::Array{FT,1} = [30.0,50.0]
    layer4::Array{FT,1} = [50.0,70.0]
    layer5::Array{FT,1} = [70.0,100.0]
end
## main program
"""
note: there are in total 5 soil layers;
however, I add the 6th layer as a default for whole soil porfile
for comparison.
"""
module Carbon
    using Plots
    using UnPack
    using DataFrames
    using StatsPlots
    using StaticArrays
    using UnPack
    using CSV 
    using DelimitedFiles

    # export public types 
    export SoilPar, Fluxes, Pools, vanGenuchtenPar
    export Flux_POMo, Flux_POMh, Flux_MOM, Flux_DOM, Flux_MBA, Flux_MBD
    export abs_pools, abs_fluxes    
    # export public functions 
    export InitCPools, InitCFluxes, InitCInputs, inp_gpp, inp_swc, inp_stp, inp_ph 
    export MM, Flux!, CPools!, EnzymeProduction, EnzymeTurnover, create_dataframe
    export fSWP2SWC, fSWC2SWP
    export TMPdep!, SWCdep!, PHdep!
    # export ModRunSL!
    

    include("types/SoilPar.jl")
    include("types/Fluxes.jl")
    include("types/Pools.jl")
    include("types/EmptyStruct.jl")
    include("types/vanGenuchtenPar.jl")

    include("functions/WaterDependency.jl")
    include("functions/MM.jl")
    include("functions/Enzyme.jl")
    include("functions/Flux.jl")
    include("functions/Pool.jl")
    include("functions/InitModel.jl")
    # include("functions/Model.jl")
    include("functions/Outputs.jl")
    # include("functions/Plot.jl")
    include("functions/TemDependency.jl")
    include("functions/WaterDependency.jl")
    include("functions/PhDependency.jl")


    # nyear=10;ncycle=1;
    # # parameters to be added 
    # LF0 = 0.1
    # r0 = 0.01
    # fQOM = 0.05
    # Temp = 20.0 + 2.0

    # par = SoilPar();
    # cpools  = InitCPools()
    # cfluxes = InitCFluxes()
    # input_c = InitCInputs(par);

    # output = create_dataframe(AbstractFloat,ncycle,nyear); 

    # ModRunSL!(par,cpools,cfluxes,input_c,output) #single layer model  

    # output[:,"SOM"] = output[:,"POMh"] + output[:,"POMo"] + output[:,"MOM"];

    # ## plots
    # soc_total = output.POMo + output.POMh + output.MOM + output.DOM 
    # x=1:length(soc_total); y = soc_total[1:end] 
    # plot(x[1:end], y,label=false)
    # savefig("socSL_testagain2.png")

end # module
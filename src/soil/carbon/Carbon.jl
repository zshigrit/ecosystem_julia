## main program
"""
note: there are in total 5 soil layers;
however, I add the 6th layer as a default for whole soil porfile
for comparison.
"""
module main

    using Plots
    using UnPack
    using DataFrames
    using StatsPlots

    include("types/SoilPar.jl")
    include("types/SoilLayersX.jl")
    include("types/CFluxes.jl")
    include("types/CPools.jl")
    include("types/EmptyStruct.jl")

    include("functions/DepthDependencePar.jl")
    include("functions/TempDependencePar.jl")
    include("functions/MM.jl")
    include("functions/Enzyme.jl")
    include("functions/Flux.jl")
    include("functions/Pool.jl")
    include("functions/InitModel.jl")
    include("functions/ModelRun.jl")
    include("functions/Outputs.jl")
    # include("functions/Plot.jl")


    nyear=10;ncycle=10;nlayer=5;
    par_scenarios = ["con","dec","inc"]
    # parameters to be added 
    LF0 = 0.1
    r0 = 0.01
    fQOM = 0.05


    # flux initilization (default values are 0s)
    flux_pomo = Flux_POMo();flux_pomh = Flux_POMh();
    flux_mom = Flux_MOM(); 
    flux_dom = Flux_DOM(); # note: qom is wrapped in dom
    flux_mba = Flux_MBA(); flux_mbd = Flux_MBD();

    for par_scenario in par_scenarios
        @eval $(Symbol(:output_ly,"_",par_scenario)) = create_dataframe(AbstractFloat,nlayer);
        # output_ly = create_dataframe(AbstractFloat,nlayer);
        par_vary = @eval $(Symbol(:par,"_",par_scenario))
        output_ly = @eval $(Symbol(:output_ly,"_",par_scenario))
        
        for ilayer = 1:nlayer+1
            println(ilayer)
            par = SoilPar();
            InitParDepth!(par,ilayer,par_vary)
            cpools = InitCPools(ilayer)
            input_c = InitCInputs(ilayer,par);
            ModRunDepth!(par,cpools,ilayer,output_ly,input_c,depth_output)
        end
    end


    output_ly_con[:,"SOM"] = output_ly_con[:,"POMh"] + output_ly_con[:,"POMo"] + output_ly_con[:,"MOM"];
    output_ly_dec[:,"SOM"] = output_ly_dec[:,"POMh"] + output_ly_dec[:,"POMo"] + output_ly_dec[:,"MOM"];
    output_ly_inc[:,"SOM"] = output_ly_inc[:,"POMh"] + output_ly_inc[:,"POMo"] + output_ly_inc[:,"MOM"];

    ## convert concentration to content
    sl = SoilLayersX();
    sl_dif = [(sl.layer1[2]-sl.layer1[1]),
                (sl.layer2[2]-sl.layer2[1]),
                (sl.layer3[2]-sl.layer3[1]),
                (sl.layer4[2]-sl.layer4[1]),
                (sl.layer5[2]-sl.layer5[1]),
                100]
    output_ly_con[:,"SOM_gm-2"] = output_ly_con[:,"SOM"] .* sl_dif * 100.0 * 100.0 * 10^(-3)
    output_ly_dec[:,"SOM_gm-2"] = output_ly_dec[:,"SOM"] .* sl_dif * 100.0 * 100.0 * 10^(-3)
    output_ly_inc[:,"SOM_gm-2"] = output_ly_inc[:,"SOM"] .* sl_dif * 100.0 * 100.0 * 10^(-3);

    ## plotting
    ll = Array{Float64}(undef, 5, 3)
    for ilayer = 1:5
        # @eval $(Symbol(:l,ilayer)) = [output_ly_con[ilayer,"SOM"],
        #                               output_ly_dec[ilayer,"SOM"],
        #                               output_ly_inc[ilayer,"SOM"]]
        ll[ilayer,:]= [output_ly_con[ilayer,"SOM_gm-2"],
                        output_ly_dec[ilayer,"SOM_gm-2"],
                        output_ly_inc[ilayer,"SOM_gm-2"]]
    end

    
    label = ["0-10 cm" "10-30 cm" "30-50 cm" "50-70 cm" "70-100 cm"]
    groupedbar(par_scenarios,transpose(ll),
                bar_position = :stack,
                bar_width=0.4,label=label,guidefontsize=8,
                legend=:outertopright,legendfontsize=10,
                foreground_color_legend = nothing,
                ylabel = "Soil Carbon (g/m2)",
                size=(400,200),dpi=600)

    savefig("soc_CPools_layers_100yrs_x.png")

end # module
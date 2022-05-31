## main program



using Plots
using UnPack
using DataFrames
using StatsPlots
using StaticArrays
using UnPack
using CSV 

# export public types 
# export public functions
include("../carbon/CarbonSL.jl")
using .Carbon 
import .Carbon:ModRunSL! 

include("types/AddPar.jl")
include("types/DerPar.jl")
include("types/DiffusivityPar.jl")
include("types/vanGenuchtenPar.jl")
include("types/Enzyme_N.jl")
include("types/MNPools.jl")

include("functions/ENZNm.jl")
include("functions/fNLimit_MB.jl")
include("functions/InitModel.jl")
include("functions/Model.jl")
include("functions/NFixNitDen.jl")
include("functions/NGas.jl")
include("functions/NH4sorption.jl")
include("functions/NImmob.jl")
include("functions/NO3NO2Leaching.jl")
include("functions/NPool.jl")
include("functions/O2scalar.jl")
include("functions/Overflow.jl")
include("functions/SoilWaterScalar.jl")
# ========== test area: start ================
# par     = SoilPar();
# println(par.VNup_MB)

# ========== test area: end ================


# model timespan
nyear=10;ncycle=1;
# parameters to be added 
LF0 = 0.1
r0 = 0.01
fQOM = 0.05

## initial parameters 
par     = SoilPar();
par_add = AddPar();

## initial condition
cpools  = InitCPools();
cfluxes = InitCFluxes();
npools, mnpools, enzymes_c, enzymes_n = InitNPools(cpools, par_add);
rCN = InitCN()

## input (gpp, temperature, water, ph ...) (ARRAYS)
input_c = InitCInputs(par);
gpp = inp_gpp() # in InitModel.jl
swc = inp_swc()
tmp = inp_stp();
# GPP = gpp(t) # neede for plant uptaking mineral N
# SWC = swc(t)
# TMP = tmp(t)

## derived parameters
vG = vanGenuchtenPar()
par_der = DerPar() # Initialized with 0s
@unpack vg_SWCres,vg_SWCsat,vg_alpha,vg_n = vG
par_der.SWCFC = fSWP2SWC(vg_SWCres,vg_SWCsat,vg_alpha,vg_n)
# par_der.fNO3_Leaching = fracNO3_Leaching(TMP, SWC,par_add.porosity,par_der.SWCFC,
#                             par_add.Ksat,par_add.Lambda,par.rNleach,par_add.SoilDepth,1.0)
@unpack f_l_pomo,f_l_pomh,f_l_dom,rCN_LIG2LAB,CN_LITT_avg = par_add
par_der.CN_LITT_DOM = (f_l_pomo/rCN_LIG2LAB+f_l_dom)/(1.0/CN_LITT_avg-f_l_pomh/par_add.CN_LITT_POMh)
par_der.CN_LITT_POMo = par_der.CN_LITT_DOM*rCN_LIG2LAB

## store output
output = create_dataframe(AbstractFloat,ncycle,nyear); 

## model run
ModRunSL!(
par::SoilPar,par_add::AddPar,par_der::DerPar,vG::vanGenuchtenPar,
cpools::Pools,npools::Pools,rCN::Pools,mnpools::MNPools,
cfluxes::Fluxes,enzymes_n::Enzyme_N,enzymes_c::Enzyme_N,
input_c::DataFrame,output::DataFrame
)   

# plots
output[:,"SOM"] = output[:,"POMh"] + output[:,"POMo"] + output[:,"MOM"];

## plots
soc_total = output.POMo + output.POMh + output.MOM + output.DOM 
x=1:length(soc_total); y = soc_total[1:end] 
plot(x[1:end], y,label=false)
# savefig("son_test.png")



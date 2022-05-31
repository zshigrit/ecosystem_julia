Base.@kwdef mutable struct SCE_PAR
    nPar ::Integer = 0
    nOpt ::Integer = 0
    nRun ::Integer = 0
    maxn ::Integer = 0 
    kstop ::Integer = 0 
    ngs ::Integer = 0 
    npt ::Integer = 0
    npg ::Integer = 0
    nps ::Integer = 0
    nspl ::Integer = 0
    mings ::Integer = 0 
    ideflt ::Integer = 0 # 0 for default parameters
    iniflg ::Integer = 0
    iprint ::Integer = 0
    iseed ::Integer = 0
    pcento ::Float64 = 0.0
    bestObj ::Float64 = 0.0
    iOpt ::Vector
    a ::Vector # initial parameter values
    bl ::Vector # lower bound
    bu ::Vector # upper bound 
    bestPar ::Vector
    parName ::Vector 
end
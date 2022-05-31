mutable struct SCE_PAR
    nPar ::Integer 
    nOpt ::Integer 
    nRun ::Integer 
    maxn ::Integer 
    kstop ::Integer 
    ngs ::Integer 
    npt ::Integer 
    npg ::Integer 
    nps ::Integer 
    nspl ::Integer 
    mings ::Integer  
    ideflt ::Integer  # 0 for default parameters
    iniflg ::Integer
    iprint ::Integer 
    iseed ::Integer 
    pcento ::Float64 
    bestObj ::Float64 
    iOpt ::Vector
    a ::Vector # initial parameter values
    bl ::Vector # lower bound
    bu ::Vector # upper bound 
    bestPar ::Vector
    parName ::Vector 
end
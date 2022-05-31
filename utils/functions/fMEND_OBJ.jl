function fMEND_OBJ_case(case)
    case == "NSEC" ? rOBJ = f1NSE(dOBS,dSIM) : 
    case == "MARE" ? rOBJ = tolerance * fMARE() + (1.0-tolerance)*f1RAVG_ratio() :
    case == "MARt" ? rOBJ = fMARE_tolerance() :
    case == "NSEn" ? rOBJ = f1NSE_norm() :
    case == "MARn" ? rOBJ = fMARE_norm() :
    case == "CORR" ? rOBJ = f1CORR() :
    case == "CORL" ? rOBJ = f1CORR(,"log10") :
    case == "AVGr" ? rOBJ = f1RAVG_ratio() :
    case == "SIGN" ? rOBJ = fSIGN() :
    error("no such case")

    return rOBJ
end


function fMEND_OBJ(W::Vector, vOBJ::Vector)
    return W./sum(W) .* vOBJ  
end
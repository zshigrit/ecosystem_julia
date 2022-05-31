# function rOBJ()
function f1NSE(dOBS,dSIM)
    a = sum((dSIM - dOBS).^2)
    b = sum((dOBS .- mean(dOBS)) .^2)
    return a/b 
end

function fMARE(dOBS,dSIM)
    return sum(abs.(dOBS-dSIM)./dOBS)
end

function f1RAVG_ratio(dOBS,dSIM,ratio)

    return abs(ratio-mean(dSIM)/mean(dOBS))
end

function fMARE_tolerance(dOBS,dSIM,tolerance)
    fRE = fMARE(dOBS,dSIM)
    if abs(fRE)<=abs(tolerance)
        fMARE_tolerance = 0.0
    else
        fMARE_tolerance = abs(fRE)
    end
    return fMARE_tolerance
end

function f1NSE_norm(dOBS::Vector,dSIM::Vector)
    dOBS = dOBS ./ maximum(dOBS)
    dSIM = dSIM ./ maximum(dSIM)

    a = sum((dSIM - dOBS).^2)
    b = sum((dOBS .- mean(dOBS)) .^2)

    return a/b 

end

function fMARE_norm(dOBS::Vector,dSIM::Vector)
    dOBS = dOBS ./ maximum(dOBS)
    dSIM = dSIM ./ maximum(dSIM)
    return sum(abs.(dSIM-dOBS)./abs.(dOBS))

    #DABS(sim(j) - obs(j))/max(DABS(obs(j)), dLOW)
end

function f1CORR(dOBS::Vector,dSIM::Vector)
    # case == "log" ? (dOBS,dSIM) = (log10.(dOBS),log10.(dSIM)) :
    # (dOBS,dSIM) = (dOBS,dSIM)

    aLxx = sum(dOBS.^2) - sum(dOBS)*mean(dOBS)
    aLyy = sum(dSIM.^2) - sum(dSIM)*mean(dSIM)
    aLxy = sum(dOBS .* dSIM) - sum(dOBS)*mean(dSIM)
    f1CORR = 1.0 - aLxy/sqrt(aLxx * aLyy)
    return f1CORR
    # fLxy = sumxy - sumx * sumy/dble(k)
end

function f1CORR(dOBS::Vector,dSIM::Vector,case::String)
    dOBS = log10.(dOBS)
    dSIM = log10.(dSIM)

    aLxx = sum(dOBS.^2) - sum(dOBS)*mean(dOBS)
    aLyy = sum(dSIM.^2) - sum(dSIM)*mean(dSIM)
    aLxy = sum(dOBS .* dSIM) - sum(dOBS)*mean(dSIM)
    f1CORR = 1.0 - aLxy/sqrt(aLxx * aLyy)
    return f1CORR
    # fLxy = sumxy - sumx * sumy/dble(k)
end

function f1RAVG_ratio(dOBS::Vector,dSIM::Vector, ratio)
    return f1RAVG_ratio = abs(ratio - mean(dSIM)/mean(dOBS))
end

function fSIGN(dOBS::Vector,dSIM::Vector, dSign)
    dtemp = (mean(dSIM) - mean(dOBS))*dSign
    if dtemp > 0
        fSign = 0  # satisfy the objective
    else
        fSign = 1  # fail to satisfy the objective
    end
end

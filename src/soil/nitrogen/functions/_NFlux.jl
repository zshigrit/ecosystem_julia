##2 develop functions: Fluxes
function NFlux!(par::SoilPar,pools::Pools,flux::Fluxes,rCN::Pools,::Type{Flux_POMo})
    pomo_dom,pomo_mom  = Flux!(par,pools,flux,Flux_POMo)
    flux.pomo_dom = pomo_dom/rCN.POMo
    flux.pomo_mom = pomo_mom/rCN.POMo 
    return pomo_dom/rCN.POMo, pomo_mom/rCN.POMo
end

function NFlux!(par::SoilPar,pools::Pools,flux::Fluxes,rCN::Pools,::Type{Flux_POMh})
    pomh_dom,pomh_mom  = Flux!(par,pools,flux,Flux_POMh)
    flux.pomh_dom = pomh_dom/rCN.POMh
    flux.pomh_mom = pomh_mom/rCN.POMh 
    return pomh_dom/rCN.POMh, pomh_mom/rCN.POMh
end

function NFlux!(par::SoilPar,pools::Pools,flux::Fluxes,rCN::Pools,::Type{Flux_MOM})
    mom_dom = Flux!()
end
function Flux!(par::SoilPar,pools::Pools,flux::Fluxes,::Type{Flux_MOM})
    mom_dec      = MM(par,pools,Flux_MOM)
    mom_dom      = mom_dec

    flux.mom_dom = mom_dom
    return mom_dom 
end

function Flux!(par::SoilPar,pools::Pools,flux::Fluxes,::Type{Flux_DOM})
    @unpack DOM,QOM = pools 
    @unpack Kads,Qmax,Kdes = par
    dom_dec = MM(par,pools,Flux_DOM)
    dom_mba = dom_dec 
    
    # ========================
    # ads,des = AdsDesorption(par,pools) 
    _DOM = DOM - dom_mba # the preference given to microbial uptake then ad_de
    adsorbate = _DOM
    adsorbent = QOM
    ads = Kads * adsorbate * (1.0 - adsorbent/Qmax)
    des = Kdes * adsorbent / Qmax
    if des > (adsorbent + ads)
        des = adsorbent + ads 
    elseif ads > adsorbate + des 
        ads = adsorbate + des
    end 
    # ========================
    dom_qom = ads  
    qom_dom = des

    flux.dom_mba = dom_mba
    flux.dom_qom = dom_qom
    flux.qom_dom = qom_dom
    return dom_mba, dom_qom, qom_dom 
end

function Flux!(par::SoilPar,pools::Pools,flux::Fluxes,::Type{Flux_MBA})
    @unpack rMORT, frMB2DOM, frMBA_to_POMh, frMBA_to_POMo, KsDOM, VmA2D = par
    @unpack MBA,DOM = pools 
    mb = MBA
    mba_mortality= rMORT * mb
    mba_dom   = frMB2DOM * mba_mortality
    mba_pomh   = (1.0 - frMB2DOM) * mba_mortality * frMBA_to_POMh
    mba_pomo   = (1.0 - frMB2DOM) * mba_mortality * frMBA_to_POMo
    
    phi = DOM/(DOM + KsDOM)
    mba_mbd = (1.0 - phi) * VmA2D * mb
    mba_CO2_growth, mba_CO2_maintn = MM(par,pools,Flux_MBA) # Respiration of MBA

    flux.mba_dom        = mba_dom
    flux.mba_pomo       = mba_pomo
    flux.mba_pomh       = mba_pomh
    flux.mba_mbd        = mba_mbd
    flux.co2_growth = mba_CO2_growth
    flux.co2_maintn_mba = mba_CO2_maintn
    return mba_mortality,mba_dom,mba_pomo,mba_pomh,mba_mbd,mba_CO2_growth,mba_CO2_maintn
end

function Flux!(par::SoilPar,pools::Pools,flux::Fluxes,::Type{Flux_MBD}) # Respiration of MBD and resurcitaion
    @unpack KsDOM,VmD2A,VmD = par
    @unpack DOM,MBD = pools
    phi = DOM/(DOM + KsDOM)
    mbd_mba = phi * VmD2A * MBD
    mbd_CO2_maintn = VmD * MBD 

    flux.mbd_mba        = mbd_mba
    flux.co2_maintn_mbd = mbd_CO2_maintn
    return mbd_mba, mbd_CO2_maintn
end



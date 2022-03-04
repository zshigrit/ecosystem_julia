struct Flux_POMo end 
struct Flux_POMh end 
struct Flux_MOM end
struct Flux_DOM end
struct Flux_MBA end
struct Flux_MBD end


mutable struct CFluxes{FT<:AbstractFloat}
    pomo_dom ::FT
    pomo_mom ::FT
    pomh_dom ::FT
    pomh_mom ::FT
    mom_dom ::FT
    dom_mba ::FT 
    dom_qom ::FT
    qom_dom ::FT 
    co2_maintn_mba ::FT 
    co2_growth     ::FT 
    mba_pomh ::FT 
    mba_pomo ::FT 
    mba_dom  ::FT
    mba_mbd  ::FT
    mba_eph  ::FT
    mba_epo  ::FT
    mba_em   ::FT
    mbd_mba  ::FT
    co2_maintn_mbd ::FT
end
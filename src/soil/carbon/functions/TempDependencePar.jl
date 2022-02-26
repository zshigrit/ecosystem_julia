# temperature dependence 
function fTQ10(T, Q10, Tref=20.0)
    fTQ10 = Q10^((T-Tref)/10.0)
end

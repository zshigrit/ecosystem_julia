function SCEUA(par::SCE_PAR,dSIM,dOBS)
    @unpack a,bl,bu = par
    @unpack nPar,nOpt,iOpt,maxn,kstop,iseed = par 
    @unpack ngs,npg,npt,nps,nspl,pcento,mings = par 
    @unpack iniflg,iprint 

    # dSIM; dOBS; "Rs","Weight","Tolerance","MARE"
    fa = fMEND_OBJ() # fMEND_OBJ(a, sPAR, sINI, sOUT)
end
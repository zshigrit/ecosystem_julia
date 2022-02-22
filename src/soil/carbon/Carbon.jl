## Initialize the model

# parameterization
par = SoilPar();

# flux initilization (default values are 0s)
flux_pomo = Flux_POMo();flux_pomh = Flux_POMh();
flux_mom = Flux_MOM(); 
flux_dom = Flux_DOM(); # note: qom is wrapped in dom
flux_mba = Flux_MBA(); flux_mbd = Flux_MBD();

# parameters to be added 
LF0 = 0.1
r0 = 0.01
fQOM = 0.05

# initial carbon pool
soc = 1.578 # mg/cm3 
poc = 0.377; poc_o = poc * LF0; poc_h = poc * (1.0 - LF0); 
moc = 1.064;qoc = moc * fQOM; 
doc = 0.137;
mbc = 0.033; mbc_a = mbc * r0; mbc_d = mbc * (1.0 - r0);
epo = 6.0e-5
eph = 6.0e-5
em  = 6.0e-5

# _CPools = CPools(10000.,10000.,2000.,200.,120.,100.,150.,0.1,0.1,0.1)
CPools1 = CPools(poc_o,poc_h,moc,doc,qoc,mbc_a,mbc_d,epo,eph,em)
pools = CPools1

## carbon input
# litter_pomo = 100000.0/365.0/24.0 * 0.5
# litter_pomh = 100000.0/365.0/24.0 * 0.25
# litter_dom = 100000.0/365.0/24.0 * 0.25

SIN_day_str = readlines("./test/SIN_day.dat") # unit: mgC-cm2-d

SIN_day = parse.(Float64, SIN_day_str) # string to numeric

SIN_day = SIN_day[3:end]

SIN_hour = SIN_day ./24

SIN_input = SIN_hour .* par.fINP;

depth = 100.0 # cm

# 0.07, 0.37, 0.56 # fraction type I
f_l_pomo = 0.07 # to be added to parameter list 
f_l_pomh = 0.37 # to be added to parameter list
f_l_dom = 0.56 # to be added to parameter list
litter_pomo_array = SIN_input .* f_l_pomo/depth;
litter_pomh_array = SIN_input .* f_l_pomh/depth;
litter_dom_array  = SIN_input .* f_l_dom/depth; 

## model run

record_POMh = [poc_h]
record_POMo = [poc_o]
record_MOM = [moc]
record_MBD = [mbc_d]
record_MBA = [mbc_a]
record_QOM = [qoc]
record_DOM = [doc]

# litter_pomo_record = []
# litter_pomh_record = []
# litter_dom_record = []

pomo_dec_record = []
pomh_dec_record = []
mom_dec_record = []
dom_dec_record = []

for iday = 1:365*10
    for ihour = 1:24
        global litter_pomo = litter_pomo_array[iday]
        global litter_pomh = litter_pomh_array[iday]
        global litter_dom = litter_dom_array[iday]

        # ========================
        # pomo_dec = MM_pomo(par,CPools1); pomh_dec = MM_pomh(par,CPools1);
        # mom_dec = MM_mom(par,CPools1); dom_dec = MM_dom(par,CPools1);

        # push!(pomo_dec_record,pomo_dec)
        # push!(pomh_dec_record,pomh_dec)
        # push!(mom_dec_record,mom_dec)
        # push!(dom_dec_record,dom_dec)
        
        CPools!(par,CPools1)
        # CPoolsy!(par,pools)
    end
    push!(record_POMo,CPools1.POMo)
    push!(record_POMh,CPools1.POMh)
    push!(record_MOM,CPools1.MOM)
    push!(record_QOM,CPools1.QOM)
    push!(record_DOM,CPools1.DOM)

    push!(record_MBD,CPools1.MBD)
    push!(record_MBA,CPools1.MBA)

    # push!(litter_pomo_record,litter_pomo)
    # push!(litter_pomh_record,litter_pomh)
    # push!(litter_dom_record,litter_dom)
end 


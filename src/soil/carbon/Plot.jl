## plots
soc_total = record_POMo + record_POMh + record_MOM + record_DOM 
x=1:length(record_POMo); y = soc_total[1:end] 
plot(x[1:end], y,label=false)
# savefig("test4_soc_CPools.png")
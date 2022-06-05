# plot
using CSV
using DataFrames
using Plots 


# df = CSV.File("outputy.csv")


df = DataFrame(CSV.File("outputy.csv"))

plot(df.cPOMo,legend=false)
plot(df.nMOM,legend=false)
plot(df.cEM,ylims=(0,0.0002),legend=false)
plot(df.cMBA,legend=false)
plot(df.cMOM,legend=false)

soc_total = df.cPOMo + df.cPOMh + df.cMOM + df.cDOM 
plot(soc_total,ylims=(1.2,2.2),yticks = 1.2:0.2:2.2,
grid="on",legend=false)
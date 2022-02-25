abstract type RangeStepStyle end

struct RangeStepRegular <: RangeStepStyle end
struct RangeStepIrregular <: RangeStepStyle end
struct xtest end 

range_step(n, ::Type{RangeStepRegular}) = println("regular step: $n")
range_step(n, ::Type{RangeStepIrregular}) = println("not a normal step: $n")
range_step(n,::Type{xtest}) = println("test in progress")
abc = xtest()
range_step(3, xtest)
# range_step(6, RangeStepIrregular)

for i = 1:3
    @eval $(Symbol(:yy,i)) = i 
end

for i in 785:785
    println(i)
    eval(:($(Symbol(:v,"_",i)) = i ))#rand(1,1)
    println(v_785)
end

println(xx1)
println(xx2)
println(xx3)
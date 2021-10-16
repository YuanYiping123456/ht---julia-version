# ---------------------------------------------------------------------------- #
#                            heat transfer function                            #
# ---------------------------------------------------------------------------- #

# 导入package
include("read_inputdata.jl")
include("fdm_ht_calculation.jl")
include("fdm_ht_boundarysetting.jl")

# 读取传热数据
inputdata = read_ht_parameter()
# show(inputdata)

# 计算外面4层（不含皮肤层）
sol = []
for i in 1:1
    # 计算当前层导热参数
    tem = read_ht_eachlayer_parameter(inputdata, i)
    boundarydata, parameter, dx, dt = ht_boundarydata(sol, tem, i) # 可以自定义差分参数
    sol = ht_model(boundarydata, parameter, dx, dt) # 传递边界温度数据
    # println(sol[3,:])
    # println(sol[:,3])
end

# only for test
# # 设置有限差分边界值
# cₐ, cₚ, k, k_fab, L, T, H₀, ρ, ϵ = read_ht_eachlayer_parameter(inputdata, i)
# boundarydata = [2000 300 300]
# parameter = [cₐ k L]
# dx, dt = 0.0001, 0.05
# bottom_boundarydata = ht_model(boundarydata, parameter, dx, dt)
# # println(bottom_boundarydata)

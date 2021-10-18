# ------------------------ read input data from excel. ----------------------- #
using XLSX, DataFrames

# 读取excel 表单数据
function read_ht_parameter()
    df = XLSX.readxlsx("D:/Remote_GitHub_repositiories/ht/ht---julia-version/HTM_parameter.xlsx")

    # part-1: read frequency data
    unitsfreqparam = df["heat transfer model_info"]

    Sheet1_list = string("B2", ":", "H18")

    ht_inputdata = convert(Array{Float64, 2}, unitsfreqparam[Sheet1_list])
    inputdata = DataFrame(ht_inputdata, :auto)

    return inputdata
end

# 读取当前层导热数据
function read_ht_eachlayer_parameter(inputdata, i)
    cₐ, cₚ, k, k_fab, L, T, H₀, ρ, ϵ = inputdata[2, i],
    inputdata[3, i],
    inputdata[4, i],
    inputdata[5, i],
    inputdata[6, i],
    inputdata[7, i],
    inputdata[8, i],
    inputdata[9, i],
    inputdata[10, i]
    return [cₐ cₚ k k_fab L T H₀ ρ ϵ]
end

# read_ht_parameter()

function ht_boundarydata(sol, tem, i)

    # parameter：显热容  传热率   厚度
    parameters = [tem[1, 1] tem[1, 3] tem[1, 5]]

    # 自定义不同层传热参数：
    # 上边界参数 fitting_parameters
    # 左边界参数 默认300
    # 下边界参数 默认300
    # dt
    # dx

    if i == 1 # 第一层
        dt, dx = 0.1, 0.0001
        fitting_parameters = [0 2000]
    end

    return fitting_parameters, parameters, dx, dt
end
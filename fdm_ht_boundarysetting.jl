function ht_boundarydata(sol, tem, i)
    parameters = [tem[1,1] tem[1,3] tem[1,5]]
    if i == 1
        dt, dx = 0.1, 0.0001
        fitting_parameters = [0 2000]
    end
    return fitting_parameters, parameters, dx, dt
end
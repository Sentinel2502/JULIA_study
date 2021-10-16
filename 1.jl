using HorizonSideRobots
include("functions.jl")

function taskOne(r::Robot)
    for i in 0:3
        putMarkersReturn!(r, HorizonSide(i))
    end
    putmarker!(r)
end

taskOne(r)

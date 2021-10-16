using HorizonSideRobots
include("functions.jl")

function taskTwo(r::Robot)
    coord = toBottomRightCorner(r)
    for i in 0:3
        putMarkersStopOnBorder!(r, HorizonSide(i))
    end

    for i in 1:coord[1]
        move!(r, West)
    end

    for i in 1:coord[2]
        move!(r, Nord)
    end
end

taskTwo(r)
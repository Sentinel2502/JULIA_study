using HorizonSideRobots
include("functions.jl")

function taskFour(r)
    coord = toBottomRightCorner(r::Robot)
    putmarker!(r)

    ident = 0 #ident value

    while !isborder(r, Nord)
        putMarkersReturn!(r, West)
        putmarker!(r)
        move!(r, Nord)
        if !isborder(r, West)
            move!(r, West)
        else
            break
        end
    end

    putMarkersReturn!(r, West)
    putmarker!(r)

    toBottomRightCorner(r)

    returnFromBottomRightCorner(r, coord)

end

taskFour(r)
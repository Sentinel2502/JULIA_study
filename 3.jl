using HorizonSideRobots
include("functions.jl")

function taskThree(r)
    coord = toBottomRightCorner(r::Robot)
    while !ismarker(r) #creates marker rings untinl where is no mare space
        i = 0 #side number
        while i < 4 #creates marker ring around the border
            println(i)
            putMarkersStopOnMarker!(r, HorizonSide(i))
            i = (i+1)
        end

        move!(r, Nord) #moves robot diagonally to the center
        #move!(r, West)
        println("moving into another ring!")
    end

    toBottomRightCorner(r)

    for i in 1:coord[1]
        move!(r, West)
    end

    for i in 1:coord[2]
        move!(r, Nord)
    end

end

taskThree(r)
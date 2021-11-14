using HorizonSideRobots
include("functions.jl")

function findRectangle(r::Robot) # From bottom right corner moves west on each step checking for Nord wall. If robot reaches west border it moves Nord and then starts moving east checking for Nord border too
    while true
        while !isborder(r, West) # Moves west until Nord border is found (rectangle border) or west wall is hit
            if isborder(r, Nord)
                return 1
            end
            move!(r, West)
        end
        move!(r, Nord)
        while !isborder(r, Ost) # Moves east until Nord border is found (rectangle border) or east wall is hit
            if isborder(r, Nord)
                return 1
            end
            move!(r, Ost)
        end
        move!(r, Nord)
    end
end

function moveUntilRectangleCorner!(r::Robot, side::HorizonSide, location::HorizonSide, putmarkers) # Moves robot in the set direction until corner is detected (robot will end up in the outer corner). args - robot, side (in wich we robot moves), location (where robot should look?), putmarkers (optional)
    if putmarkers # Puts markers :D
        while isborder(r, location)
            putmarker!(r)
            move!(r, side)
        end
    else # Doesn't put markers D:
        while isborder(r, location)
            move!(r, side)
        end
    end
end

function taskSix(r)
    steps = toBottomRightCornerFive!(r)
    findRectangle(r)
    moveUntilRectangleCorner!(r, Ost, Nord, false)
    putmarker!(r)
    move!(r, Nord)
    moveUntilRectangleCorner!(r, Nord, West, true)
    putmarker!(r)
    move!(r, West)
    moveUntilRectangleCorner!(r, West, Sud, true)
    putmarker!(r)
    move!(r, Sud)
    moveUntilRectangleCorner!(r, Sud, Ost, true)
    putmarker!(r)
    move!(r, Ost)
    moveUntilRectangleCorner!(r, Ost, Nord, true)
    toBottomRightCornerFive!(r)
    returnFromBottomRightCornerBySteps(r, steps)
end

taskSix(r)

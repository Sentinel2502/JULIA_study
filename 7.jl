using HorizonSideRobots
include("functions.jl")

function stepIfPossible(r::Robot, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        return true
    else
        return false
    end
end

function moveChessque(r::Robot, side::HorizonSide)
    while true
        putmarker!(r)
        if !stepIfPossible(r, side)
            break
        end
        if !stepIfPossible(r, side)
            break
        end
    end
end

function taskSeven(r::Robot)
    coords = toBottomRightCorner(r)
    # even, even - nothing
    # even, uneven - step right
    # uneven, uneven - step right
    # uneven, even - step right
    if !(coords[1]%2==0 && coords[2]%2==0)
        while true
            move!(r, West)
            moveChessque(r, West)
            if isborder(r, Nord)
                break
            end
            move!(r, Nord)
            move!(r, Ost)
            moveChessque(r, Ost)
            if isborder(r, Nord)
                break
            end
            move!(r, Nord)
        end
    else
        while true
            moveChessque(r, West)
            if isborder(r, Nord)
                break
            end
            move!(r, Nord)
            moveChessque(r, Ost)
            if isborder(r, Nord)
                break
            end
            move!(r, Nord)
        end
    end
    toBottomRightCorner(r)
    returnFromBottomRightCorner(r, coords)
end
taskSeven(r)

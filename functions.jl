using HorizonSideRobots

function reverseSide(side::HorizonSide) #Инвертирует сторону света
    if side == Nord
        return Sud
    elseif side == Sud
        return Nord
    elseif side == Ost
        return West
    else
        return Ost

    end
end

function putMarkersReturn!(r::Robot, side::HorizonSide) #Идет в заданном направлении, ставя маркеры на своем пути. Встретив преграду, возвращается в исходную точку
    steps = 0
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
        steps += 1
    end

    new_side = reverseSide(side)

    for i in 1:steps
        move!(r, new_side)
    end

end

function putMarkersStopOnBorder!(r::Robot, side::HorizonSide) #Идет в заданном направлении, ставя маркеры на своем пути. Встретив преграду, останавливается
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

function putMarkersStopOnMarker!(r::Robot, side::HorizonSide) #Идет в заданном направлении, ставя маркеры на своем пути. Встретив преграду или маркер, останавливается
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
        if ismarker(r)
            move!(r, reverseSide(side))
            break
        end
    end
end

function toBottomRightCorner(r::Robot) #Перемещает робота в нижний правый угол. Возвращает количество шагов нужное, чтобы вернуться в исходную позицию
    x = 0
    y = 0
    while !isborder(r, Ost)
        move!(r, Ost)
        x += 1
    end

    while !isborder(r, Sud)
        move!(r, Sud)
        y += 1
    end

    return [x, y]
end

function returnFromBottomRightCorner(r::Robot, coords) #Возвращает робота в исходную позицию из правого нижнего угла
    for i in 1:coords[1]
        move!(r, West)
    end

    for i in 1:coords[2]
        move!(r, Nord)
    end
end

function returnFromBottomRightCornerBySteps(r::Robot, steps) #Возвращает робота в исходную позицию из нижнего правого угла по шагам
    for i in length(steps):-1:1
        move!(r, reverseSide(steps[i]))
    end
end

function moveUntilBorder!(r::Robot, side::HorizonSide) #Робот двигается в выбранном направлении, пока не встретит преграду
    while !isborder(r, side)
        move!(r, side)
    end
end

function toBottomRightCornerFive!(r::Robot) # Robot moves to bottom right corner, but suitable for fith tasks. Saves path by steps
    steps = HorizonSide[]
    while !(isborder(r, Sud) && isborder(r, Ost))
        while !isborder(r, Sud)
            move!(r, Sud)
            push!(steps, Sud)
        end

        while !isborder(r, Ost)
            move!(r, Ost)
            push!(steps, Ost)
        end
    end

    return steps
end

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

function intToBool(num) # Converts int to bool
    if num==0
        return false
    else
        return true
    end
end

function stepIfPossible(r::Robot, side::HorizonSide) #Take one step is possible and return true, if it's not return false
    if !isborder(r, side)
        move!(r, side)
        return true
    else
        return false
    end
end

function stepXTimes(r::Robot, side::HorizonSide, x) #Take x steps into one direction (checks for walls)
    for i in 1:x
        if !isborder(r, side)
            move!(r, side)
        end
    end
end

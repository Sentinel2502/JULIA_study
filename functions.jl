using HorizonSideRobots;

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
    for i in 1:coord[1]
        move!(r, West)
    end

    for i in 1:coord[2]
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

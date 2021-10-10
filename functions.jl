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

function putMarkers!(r::Robot, side::HorizonSide) #Идет в заданном направлении, ставя маркеры на своем пути
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

function toBottomRightCorner(r) #Перемещает робота в нижний правый угол. Возвращает количество шагов нужное, чтобы вернуться в исходную позицию
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
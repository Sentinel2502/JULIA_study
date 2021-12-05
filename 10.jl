using HorizonSideRobots
include("functions.jl")

function averageFieldTemp(r)
    if ismarker(r)
        global amount+=temperature(r)
        global total+=1
    end
end

function taskTen(r)
    global amount = 0
    global total = 0
    toBottomRightCorner(r)
    while true
        while !isborder(r, West)
            averageFieldTemp(r)
            move!(r, West)
        end
        if !isborder(r, Nord)
            averageFieldTemp(r)
            move!(r, Nord)
        else
            averageFieldTemp(r)
            break
        end
        while !isborder(r, Ost)
            averageFieldTemp(r)
            move!(r, Ost)
        end
        if !isborder(r, Nord)
            averageFieldTemp(r)
            move!(r, Nord)
        else
            averageFieldTemp(r)
            break
        end
    end
    println(amount/total)
end

taskTen(r)

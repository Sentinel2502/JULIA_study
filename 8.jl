using HorizonSideRobots
include("functions.jl")

function taskEight(r)
    steps = 1
    while true
        for i in 1:steps
            move!(r, Ost)
            if !isborder(r, Nord)
                return nothing
            end
        end
        steps+=1
        for i in 1:steps
            move!(r, West)
            if !isborder(r, Nord)
                return nothing
            end
        end
        steps+=1
    end
end

taskEight(r)

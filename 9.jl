using HorizonSideRobots
include("functions.jl")

function taskNine(r)
    steps = 1
    if ismarker(r)
        return nothing
    end
    while true
        for i in 1:steps
            move!(r, Ost)
            if ismarker(r)
                return nothing
            end
        end
        for i in 1:steps
            move!(r, Nord)
            if ismarker(r)
                return nothing
            end
        end
        steps+=1
        for i in 1:steps
            move!(r, West)
            if ismarker(r)
                return nothing
            end
        end
        for i in 1:steps
            move!(r, Sud)
            if ismarker(r)
                return nothing
            end
        end
        steps+=1
    end
end

taskNine(r)

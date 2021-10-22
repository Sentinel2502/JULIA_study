using HorizonSideRobots
include("functions.jl")

function toBottomRightCornerFive!(r)
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

function taskFive(r)
    steps = toBottomRightCornerFive!(r)
    
    for i in 0:3
        moveUntilBorder!(r, HorizonSide(i))
        putmarker!(r)
    end

    returnFromBottomRightCornerBySteps(r, steps)

end

taskFive(r)
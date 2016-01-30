it = {}

function it.enum(iter)
    local i = 0
    return function()
        local val = iter()
        if val ~= nil then
            i = i + 1
            return i, val
        end
    end
end

function it.range(first, last)
    local i = first
    return function()
        if i <= last then
            i = i + 1
            return i - 1
        end
    end
end

return it

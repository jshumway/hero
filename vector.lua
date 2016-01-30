local vector = {}

function vector.normalize(x, y)
    local mag = vector.magnitude(x, y)
    return x / mag, y / mag
end

function vector.magnitude(x, y)
    return math.sqrt(x*x + y*y)
end

return vector

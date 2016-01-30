local vector = {}

function vector.normalize(v)
    local mag = vector.magnitude(v)
    return { x = v.x / mag, y = v.y / mag }
end

function vector.magnitude(v)
    return math.sqrt(v.x*v.x + v.y*v.y)
end

function vector.scale(v, s)
    return { x = v.x * s, y = v.y * s }
end

function vector.add(a, b)
    return { x = a.x + b.x, y = a.y + b.y }
end

return vector

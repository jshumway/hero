local vector = require('vector')

DebugUtil = {
    queue = {},
    grid_width = 0,
    grid_height = 0
}

function DebugUtil:set_grid(width, height)
    self.grid_width = width
    self.grid_height = height
end

function DebugUtil:to_screen(p)
    return {
        x = p.x * self.grid_width + math.floor(self.grid_width / 2),
        y = p.y * self.grid_height + math.floor(self.grid_width / 2) }
end

function DebugUtil:highlight_rect(rx, y, w, h)
    -- Takes either a table { x = , y = , w = , h = } or x, y, w, and h as
    -- arguments

    if type(rx) == "table" then
        table.insert(self.queue, function ()
            love.graphics.rectangle("line", rx.x, rx.y, rx.w, rx.h)
        end)
    elseif rx ~= nil and y ~= nil and w ~= nil and h ~= nil then
        table.insert(self.queue, function ()
            love.graphics.rectangle("line", rx, y, w, h)
        end)
    end
end

function DebugUtil:grid_vec(point, vec, scale)
    scale = scale or 1
    local point = DebugUtil:to_screen(point)
    local dest = vector.add(point, vector.scale(vec, scale))

    table.insert(self.queue, function ()
        love.graphics.circle("line", point.x, point.y, 5, 10)
        love.graphics.line(point.x, point.y, dest.x, dest.y)
    end)
end

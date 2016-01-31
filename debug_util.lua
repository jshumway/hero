DebugUtil = {
    queue = {}
}

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

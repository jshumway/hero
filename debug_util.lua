DebugUtil = {
    queue = {}
}

function DebugUtil:highlight_rect(r)
    table.insert(self.queue, function ()
        love.graphics.rectangle("line", r.x, r.y, r.w, r.h)
    end)
end

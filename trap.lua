local Trap = {}
Trap.__index = Trap

local vector = require('vector')

function Trap:new(x, y, dir, freq, start_delay)
    local newTrap = {
        pos = { x = x, y = y },
        dir = vector.from_deg(dir),
        freq = freq,
        start_delay = start_delay,

        color = { 255, 255, 255 },
        fired_at = nil,
        started_at = nil,
        active = false
    }
    return setmetatable(newTrap, self)
end

function Trap:start(time)
    self.started_at = time
    self.active = true
end

function Trap:should_shoot(time)
    if not self.active then return false end

    if self.fired_at == nil then
        if self.started_at + self.start_delay <= time then
            self.fired_at = time
            return true
        end
    else
        if time - self.fired_at >= self.freq then
            self.fired_at = time
            return true
        end
    end

    return false
end

return Trap

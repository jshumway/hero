local vector = require('vector')

local Hero = {}

function Hero:new()
    local newHero = {
        text = 'hero',
        x = 200, -- TODO(evan) set location based on diary text
        y = 200,
        speed = 150,
        frozen = false
    }
    self.__index = self
    return setmetatable(newHero, self)
end

function Hero:update(dt)
    self:move(dt)
end

function Hero:move(dt)
    if self.frozen then
        return
    end

    local xMag = 0
    local yMag = 0

    if love.keyboard.isDown('w', 'up') then
        yMag = yMag - 1
    end
    if love.keyboard.isDown('s', 'down') then
        yMag = yMag + 1
    end
    if love.keyboard.isDown('a', 'left') then
        xMag = xMag - 1
    end
    if love.keyboard.isDown('d', 'right') then
        xMag = xMag + 1
    end

    if xMag ~= 0 or yMag ~= 0 then
        xMag, yMag = vector.normalize(xMag, yMag)
        self.x = self.x + (self.speed * xMag * dt)
        self.y = self.y + (self.speed * yMag * dt)
    end
end

function Hero:freeze()
    self.frozen = true
end

function Hero:unfreeze()
    self.frozen = false
end

return Hero

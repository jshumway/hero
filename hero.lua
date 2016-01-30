local vector = require('vector')

local Hero = {}

function Hero:new()
    newHero = {
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

    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        yMag = yMag + 1
    end
    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        yMag = yMag - 1
    end
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        xMag = xMag - 1
    end
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        xMag = xMag + 1
    end

    xMag, yMag = vector.normalize(xMag, yMag)

    self.x = self.x + (self.speed * xMag)
    self.x = self.y + (self.speed * yMag)
end

function Hero:freeze()
    self.frozen = true
end

function Hero:unfreeze()
    self.frozen = false
end

return Hero

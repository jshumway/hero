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

    if love.keyboard.isDown('w') then
        -- move up
        self.y = self.y - (self.speed * dt)
    end
    if love.keyboard.isDown('s') then
        -- move down
        self.y = self.y + (self.speed * dt)
    end
    if love.keyboard.isDown('a') then
        -- move left
        self.x = self.x - (self.speed * dt)
    end
    if love.keyboard.isDown('d') then
        -- move right
        self.x = self.x + (self.speed * dt)
    end
end

function Hero:freeze()
    self.frozen = true
end

function Hero:unfreeze()
    self.frozen = false
end

return Hero

local vector = require('vector')

local Hero = {}
Hero.__index = Hero

function Hero:new(initial_location)
    local newHero = {
        text = 'HERO',

        -- Physics components
        -- TODO(evan) set location based on diary text
        pos = initial_location,
        dir = { x = 0, y = 0 },
        speed = 200,

        frozen = false,
        lives = 4
    }
    return setmetatable(newHero, self)
end

function Hero:update(dt)
    self:move()
end

function Hero:move()
    if self.frozen then
        return
    end

    local dir = { x = 0, y = 0 }

    if love.keyboard.isDown('w', 'up') then
        dir.y = dir.y - 1
    end
    if love.keyboard.isDown('s', 'down') then
        dir.y = dir.y + 1
    end
    if love.keyboard.isDown('a', 'left') then
        dir.x = dir.x - 1
    end
    if love.keyboard.isDown('d', 'right') then
        dir.x = dir.x + 1
    end

    self.dir = dir
end

function Hero:freeze()
    self.frozen = true
end

function Hero:unfreeze()
    self.frozen = false
end

function Hero:loseLife()
   self.lives = self.lives - 1

   -- TODO(jared): make this use substring
   if (self.lives == 1) then self.text = 'H' end
   if (self.lives == 2) then self.text = 'HE' end
   if (self.lives == 3) then self.text = 'HER' end
end

return Hero

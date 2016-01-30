local vector = require('vector')
local lives
local Hero = {}
Hero.__index = Hero

function Hero:new(inital_location)
    local newHero = {
        text = 'HERO',
        x = inital_location.x, -- TODO(evan) set location based on diary text
        y = inital_location.y,
        speed = 200,
        frozen = false
    }
    lives = 4
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

function Hero:loseLife()
   lives = lives - 1
   if (lives == 1) then hero.text = 'H'
   end
   if (lives == 2) then hero.text = 'HE'
   end
   if (lives == 3) then hero.text = 'HER'
   end
end

return Hero

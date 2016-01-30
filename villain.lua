local vector = require('vector')
local lives
local Villain = {}

function Villain:new()
    local newVillain = {
        text = 'VILLAIN',

        -- TODO(evan) set location based on diary text
        pos = { x = 650, y = 650 },
        speed = 0,
        frozen = false
    }
    lives = 7
    self.__index = self
    return setmetatable(newVillain, self)
end

function Villain:update(dt)
    --self:move(dt)
    --fire
end

function Villain:loseLife()
   lives = lives - 1
   if (lives == 1) then hero.text = 'V'
   end
   if (lives == 2) then hero.text = 'VI'
   end
   if (lives == 3) then hero.text = 'VIL'
   end
   if (lives == 4) then hero.text = 'VILL'
   end
   if (lives == 5) then hero.text = 'VILLA'
   end
   if (lives == 6) then hero.text = 'VILLAI'
   end
end

return Villain

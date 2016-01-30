local Game = {}

function Game:new(screenWidth, screenHeight)
    newObj = {
        font = { font = nil, width = 0, height = 0 },
        screen = { width = screenWidth, height = screenHeight }
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Game:load_font(filename, size)
    local font = love.graphics.newFont(filename, size)
    love.graphics.setFont(font)
    local width = font:getWidth("@")
    local height = font:getHeight()

    self.font = { font = font, width = width, height = height }
end

return Game

Terrain = require('terrain')

local Game = {}

function Game:new(screenWidth, screenHeight, font_file, font_size)
    -- Load & config font
    local font = love.graphics.newFont(font_file, size)
    local fontWidth = font:getWidth("@")
    local fontHeight = font:getHeight()

    -- Create terrain
    local terrain = Terrain:new()
    terrain:addType("wall", "X", false)
    terrain:addType("floor", ".", true)
    terrain:initLayer(
        screenWidth / fontWidth,
        screenHeight / fontHeight,
        "floor")

    newObj = {
        font = { font = font, width = fontWidth, height = fontHeight },
        screen = { width = screenWidth, height = screenHeight },
        terrain = terrain
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Game:load_font(filename, size)
end

return Game

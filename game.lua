Terrain = require('terrain')
Renderer = require('renderer')

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
        math.floor(screenWidth / fontWidth),
        math.floor(screenHeight / fontHeight),
        "floor")

    newObj = {
        font = { font = font, width = fontWidth, height = fontHeight },
        screen = { width = screenWidth, height = screenHeight },
        terrain = terrain,
        renderer = Renderer:new()
    }

    self.__index = self
    return setmetatable(newObj, self)
end

return Game

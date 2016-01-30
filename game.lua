local Camera = require('camera')
local Hero = require('hero')
local Terrain = require('terrain')
local Renderer = require('renderer')
local Villain = require('villain')

local Game = {}
Game.__index = Game

function Game:new(screenWidth, screenHeight, font_file, font_size)
    local min_frame_time = 1/60

    -- Load & config font
    local font = love.graphics.newFont(font_file, font_size)
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

    local screen = { width = screenWidth, height = screenHeight }

    local newObj = {
        config = { min_frame_time = min_frame_time },
        font = { font = font, width = fontWidth, height = fontHeight },
        screen = screen,
        camera = Camera:new(screen),
        hero = Hero:new(),
        villain = Villain:new(),
        terrain = terrain,
        renderer = Renderer:new()
    }

    return setmetatable(newObj, self)
end

return Game

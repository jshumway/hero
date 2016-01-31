local Camera = require('camera')
local Hero = require('hero')
local Terrain = require('terrain')
local Renderer = require('renderer')
local Villain = require('villain')
local it = require('it')
local physics = require('physics')

local Game = {}
Game.__index = Game

function Game:new(gridWidth, gridHeight, font_file, font_size)
    local min_frame_time = 1/60

    -- Load & config font
    local font = love.graphics.newFont(font_file, font_size)
    local fontWidth = font:getWidth("@")
    local fontHeight = font:getHeight()

    -- Create terrain
    local terrain = Terrain:new()
    -- TODO: read in from data files
    terrain:addType("wall", "#", false, true)
    terrain:addType("floor", ".", true, false)

    local screen = {
        width = gridWidth * fontWidth,
        height = gridHeight * fontHeight }

    local newObj = {
        config = { min_frame_time = min_frame_time },
        font = { font = font, width = fontWidth, height = fontHeight },
        screen = screen,
        camera = Camera:new(screen),
        hero = nil,
        villain = Villain:new(),
        terrain = terrain,
        renderer = Renderer:new(),
        physics = physics
    }

    return setmetatable(newObj, self)
end

function Game:load_level(level_path)
    local terrain = {}
    local actors = {}
    local player_start = nil

    for h, line in it.enum(io.lines(level_path)) do

        for w in it.range(1, #line) do
            if h == 1 then
                terrain[w] = {}
            end

            local c = line:sub(w, w)
            local tname = "floor"

            if c == 'A' then
                table.insert(actors, {x = w, y = h})
            elseif c == '@' then
                player_start = {x = w, y = h}
            else
                tname = assert(self.terrain:getType(c),
                    "glyph matches no terrain type: " .. c)
            end

            terrain[w][h] = tname
        end
    end

    self.terrain:layerFromGrid(terrain)

    self.hero = Hero:new({
        x = player_start.x * self.font.width,
        y = player_start.y * self.font.height},
        self.font)
end

return Game

local Camera = require('camera')
local Hero = require('hero')
local Terrain = require('terrain')
local Textbox = require('textbox')
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
        terrain = Terrain:new(),
        textbox = Textbox:new(),
        renderer = Renderer:new(),
        physics = physics
    }

    return setmetatable(newObj, self)
end

function Game:load_level(level_path)
    local actors = {}
    local player_start = nil

    for h, line in it.enum(io.lines(level_path)) do
        for w in it.range(1, #line) do
            local c = line:sub(w, w)

            if c == '@' then
                player_start = {x = w, y = h}
                self.terrain:setTile(w, h, ' ', true, false)

            -- TODO: add extra things here
            elseif c == '=' then
                -- bullet emitter
                self.terrain:setTile(w, h, '=', false, true)

            elseif c == '#' then
                self.terrain:setTile(w, h, '#', false, true)

            elseif c == ' ' then
                self.terrain:setTile(w, h, ' ', true, false)

            else
                self.terrain:setTile(w, h, c, false, true)
            end
        end
    end

    self.hero = Hero:new({
        x = player_start.x * self.font.width,
        y = player_start.y * self.font.height},
        self.font)
end

return Game

local Camera = require('camera')
local Hero = require('hero')
local Terrain = require('terrain')
local Textbox = require('textbox')
local Renderer = require('renderer')
local Villain = require('villain')
local it = require('it')
local physics = require('physics')
local Trap = require('trap')
local vector = require('vector')

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
        physics = physics,
        objects = {
            traps = {},
            bullets = {}
        }
    }

    return setmetatable(newObj, self)
end

function Game:update(dt)
    local time = love.timer.getTime()

    self.hero:update(dt)

    -- update non-static objects
    for _, trap in ipairs(self.objects.traps) do
        if trap:should_shoot(time) then
            local pos = vector.add(trap.pos, vector.scale(trap.dir, 1))
            table.insert(self.objects.bullets, {
                -- TODO: Don't want to ref the trap members here, not sure
                -- if this is actually needed.
                pos = pos,
                dir = { x = trap.dir.x, y = trap.dir.y },
                speed = 5,
                radius = 5
            })
        end
    end

    self.physics.update(self, dt)

    self.textbox:update(dt)
    self.camera:update(self.hero)
end

local function load_objects(game, level_path)
    for line in io.lines(level_path .. '/objects.txt') do
        local next_word = line:gmatch("%S+")

        -- NOTE: need to read y first
        local y = tonumber(next_word())
        local x = tonumber(next_word())

        local kind = next_word()
        local dir = tonumber(next_word())
        local freq = tonumber(next_word())
        local start_delay = tonumber(next_word())

        table.insert(game.objects.traps, Trap:new(x, y, dir, freq, start_delay))
    end
end

function Game:load_level(level_path)
    local actors = {}
    local player_start = nil

    for h, line in it.enum(io.lines(level_path .. '/terrain.lvl')) do
        for w in it.range(1, #line) do
            local c = line:sub(w, w)

            if c == '@' then
                player_start = {x = w, y = h}
                self.terrain:setTile(w, h, ' ', true, false)

            -- TODO: add extra things here
            elseif c == '=' then
                -- bullet trap, do nothing
                self.terrain:setTile(w, h, ' ', false, true)

            elseif c == '#' then
                self.terrain:setTile(w, h, '#', false, true)

            elseif c == ' ' then
                self.terrain:setTile(w, h, ' ', true, false)

            else
                self.terrain:setTile(w, h, c, false, true)
            end
        end
    end

    load_objects(self, level_path)

    local time = love.timer.getTime()
    for _, trap in ipairs(self.objects.traps) do
        trap:start(time)
    end

    self.hero = Hero:new({
        x = player_start.x * self.font.width,
        y = player_start.y * self.font.height},
        self.font)
end

return Game

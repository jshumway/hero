require('debug_util')

local Game = require('game'):new(64, 24, "resources/PTM55FT.ttf", 22)
local next_time
local level

function love.load()
    love.window.setMode(Game.screen.width, Game.screen.height)

    love.graphics.setFont(Game.font.font)

    Game:load_level('data/levels/demo/terrain.lvl')

    next_time = love.timer.getTime()
    level = 0

    Game.textbox:write("Hello how are you I'm great thanks for asking woooooooo")

end

function love.update(dt)
    next_time = next_time + Game.config.min_frame_time

    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    Game.hero:update(dt)
    Game.physics.update(Game, dt)
    Game.textbox:update(dt)
    Game.camera:update(Game.hero)
end

function love.draw()
    Game.camera:set()

    Game.renderer:render(Game)

    Game.camera:unset()

    enforce_min_frame_time()
end

function enforce_min_frame_time()
    local cur_time = love.timer.getTime()
    if next_time <= cur_time then
        next_time = cur_time
        return
    end
    love.timer.sleep(next_time - cur_time)
end

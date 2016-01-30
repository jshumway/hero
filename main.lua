local Game = require('game'):new(800, 600, "resources/PTM55FT.ttf", 22)
local next_time
local level

-- Configuration
function love.conf(t)
    t.title = "Hero Game"
    t.window.width = Game.screen.width
    t.window.height = Game.screen.height
end

function love.load()
    love.graphics.setFont(Game.font.font)
    next_time = love.timer.getTime()
    level = 0

end

function love.update(dt)
    next_time = next_time + Game.config.min_frame_time

    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    Game.hero:update(dt)
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

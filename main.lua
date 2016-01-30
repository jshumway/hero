Game = require('game')

GlobalGame = Game:new(800, 600, "resources/SourceCodePro-Medium.ttf", 14)

-- Configuration
function love.conf(t)
    t.title = "Hero Game"
    t.window.width = GlobalGame.screen.width
    t.window.height = GlobalGame.screen.height
end

function love.load()
    local game = GlobalGame

    love.graphics.setFont(game.font.font)
    next_time = love.timer.getMicroTime()
end

function love.update(dt)
    local game = GlobalGame
    next_time = next_time + game.config.min_frame_time

    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    game.hero:update(dt)
end

function love.draw()
    local game = GlobalGame

    game.renderer:render(game)

    enforce_min_frame_time()
end

function enforce_min_frame_time()
    local cur_time = love.timer.getMicroTime()
    if next_time <= cur_time then
        next_time = cur_time
        return
    end
    love_timer_sleep(next_time - cur_time)
end

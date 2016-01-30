-- Configuration
function love.conf(t)
    t.title = "Hero Game"
    t.window.width = 800
    t.window.height = 600
end

function love.load()
    Game = require('game')
    Game:load_font("resources/SourceCodePro-Medium.ttf", 14)
end

function love.update(dt)
    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
end

function love.draw()
    love.graphics.print('this is maggies change', 400, 300)

    love.graphics.print('width: ' .. Game.font.width .. ' height: ' ..
        Game.font.height, 400, 400)
end

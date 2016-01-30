Game = require('game')

GlobalGame = Game:new(800, 600)

-- Configuration
function love.conf(t)
    t.title = "Hero Game"
    t.window.width = GlobalGame.screen.width
    t.window.height = GlobalGame.screen.height
end

function love.load()
    local game = GlobalGame

    game:load_font("resources/SourceCodePro-Medium.ttf", 14)
end

function love.update(dt)
    local game = GlobalGame

    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
end

function love.draw()
    local game = GlobalGame

    love.graphics.print('this is maggies change', 400, 300)

    love.graphics.print('width: ' .. game.font.width .. ' height: ' ..
        game.font.height, 400, 400)
end

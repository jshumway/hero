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
end

function love.update(dt)
    local game = GlobalGame

    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    game.hero:update(dt)
end

function love.draw()
    local game = GlobalGame

    love.graphics.print('width: ' .. game.font.width .. ' height: ' ..
        game.font.height, 400, 400)

    -- TODO(evan) Move this to the Renderer
    love.graphics.print(game.hero.text, game.hero.x, game.hero.y)
end

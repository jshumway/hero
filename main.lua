Game = {
    font = { font = nil, width = 0, height = 0 }
}

-- Configuration
function love.conf(t)
    t.title = "Hero Game"
    t.window.width = 800
    t.window.height = 600
end

function love.load()
    load_font()
end

function load_font()
    local font = love.graphics.newFont("resources/SourceCodePro-Medium.ttf", 14)
    love.graphics.setFont(font)
    local width = font:getWidth("@")
    local height = font:getHeight()

    Game.font = {font = font, width = width, height = height }
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

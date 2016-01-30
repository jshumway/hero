-- Configuration
function love.conf(t)
    t.title = "Scrolling Shooter Tutorial"
    t.window.width = 800
    t.window.height = 600
end

function love.load()
    mainFont = love.graphics.newFont("resources/SourceCodePro-Medium.ttf", 20);
    love.graphics.setFont(mainFont)
end

function love.update(dt)
    -- Exit the game with escape
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
end

function love.draw()
    love.graphics.print('this is maggies change', 400, 300)

    local fontWidth = mainFont:getWidth("@")
    local fontHeight = mainFont:getHeight()

    love.graphics.print('width: ' .. fontWidth .. ' height: ' .. fontHeight, 400, 400)
end

local Game = {
    font = { font = nil, width = 0, height = 0 }
}

function Game:load_font(filename, size)
    local font = love.graphics.newFont(filename, size)
    love.graphics.setFont(font)
    local width = font:getWidth("@")
    local height = font:getHeight()

    self.font = { font = font, width = width, height = height }
end

return Game

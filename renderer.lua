local Renderer = {}

-- TODO: does the renderer need state?

function Renderer:new()
    local newObj = {}
    self.__index = self
    return setmetatable(newObj, self)
end

function Renderer:render(game)
    -- assume there is no camera for now

    -- render terrain
    for w, h, tile in game.terrain:iter() do
        love.graphics.print(tile.repr, w * game.font.width, h * game.font.height)
    end

    -- render hero
    love.graphics.setColor(255,0,0) --red base "HERO" to track lives
    love.graphics.print('HERO', game.hero.x, game.hero.y)
    love.graphics.setColor(0,255,0) --green letters on top to show how many lives there are left
    love.graphics.print(game.hero.text, game.hero.x, game.hero.y)
    love.graphics.setColor(255,255,255) --set back to white for the dots
end

return Renderer

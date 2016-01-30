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
        -- Terrain keeps the world one-indexed, shift w, h to be zero-indexed.
        love.graphics.print(
            tile.glyph,
            -- TODO: add line height/width modifications elsewhere?
            (w - 1) * (game.font.width + 1),
            (h - 1) * (game.font.height + 1))
    end

    -- render hero
    love.graphics.setColor(255,0,0) --red base "HERO" to track lives
    love.graphics.print('HERO', game.hero.x, game.hero.y)
    love.graphics.print('VILLAIN', game.villain.x, game.villain.y)
    love.graphics.setColor(0,255,0) --green letters on top to show how many lives there are left
    love.graphics.print(game.hero.text, game.hero.x, game.hero.y)
    love.graphics.setColor(255,255,255) --set back to white for the dots
    love.graphics.print(game.villain.text, game.villain.x, game.villain.y)
end

return Renderer

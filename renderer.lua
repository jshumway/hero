local Renderer = {}

-- TODO: does the renderer need state?

function Renderer:new()
    newObj = {}
    self.__index = self
    return setmetatable(newObj, self)
end

function Renderer:render(game)
    -- assume there is no camera for now

    -- render terrain
    for w, h, tile in game.terrain:iter() do
        love.graphics.print(tile.repr, w * game.font.width, h * game.font.height)
    end
end

return Renderer

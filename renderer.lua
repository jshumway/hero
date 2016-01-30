local Renderer = {}

local function render_actor(actor, color)
    love.graphics.print({color, actor.text}, actor.pos.x, actor.pos.y)
end

function Renderer:new()
    local newObj = {}
    self.__index = self
    return setmetatable(newObj, self)
end

function Renderer:render(game)
    -- render terrain
    for w, h, tile in game.terrain:iter() do
        -- Terrain keeps the world one-indexed, shift w, h to be zero-indexed.
        love.graphics.print(
            tile.glyph,
            -- TODO: add line height/width modifications elsewhere?
            (w - 1) * (game.font.width + 1),
            (h - 1) * (game.font.height + 1))
    end

    -- render actors
    local red = {255, 0, 0}
    local green = {0, 255, 0}

    -- render hero; green letters on top to show how many lives there are left
    render_actor(game.hero, red)
    render_actor(game.hero, green)

    render_actor(game.villain, red)
end

return Renderer

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
        if tile.visible then
            -- Terrain keeps the world one-indexed, shift w, h to be zero-indexed.
            love.graphics.print(
                tile.glyph,
                -- TODO: add line height/width modifications elsewhere?
                w * (game.font.width),
                h * (game.font.height))
        end
    end

    -- render actors
    local red = {255, 0, 0}
    local green = {0, 255, 0}

    -- render hero; green letters on top to show how many lives there are left
    render_actor(game.hero, red)
    render_actor(game.hero, green)

    render_actor(game.villain, red)

    -- render debug information
    for i, fn in ipairs(DebugUtil.queue) do
        fn()
    end
    DebugUtil.queue = {}

    -- render the textbox UI
    game.textbox:draw(game)
end

return Renderer

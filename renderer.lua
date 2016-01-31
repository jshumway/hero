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
    local function fg_x(x) return x * game.font.width end
    local function fg_y(y) return y * game.font.height end

    -- render terrain
    for w, h, tile in game.terrain:iter() do
        if tile.visible then
            love.graphics.print(tile.glyph, fg_x(w), fg_y(h))
        end
    end

    -- render actors
    local red = {255, 0, 0}
    local green = {0, 255, 0}

    -- render hero; green letters on top to show how many lives there are left
    render_actor(game.hero, red)
    render_actor(game.hero, green)

    render_actor(game.villain, red)

    -- render traps
    for _, trap in ipairs(game.objects.traps) do
        love.graphics.print(
            {trap.color, '='}, fg_x(trap.pos.x), fg_y(trap.pos.y))
    end

    -- render bullets
    for _, bullet in ipairs(game.objects.bullets) do
        love.graphics.print('*', fg_x(bullet.pos.x), fg_y(bullet.pos.y))
    end

    -- render debug information
    for i, fn in ipairs(DebugUtil.queue) do
        fn()
    end
    DebugUtil.queue = {}

    -- render the textbox UI
    game.textbox:draw(game)
end

return Renderer

local physics = {}

local vector = require('vector')
local it = require('it')

local function collides_with(game, ra, rb)
    return ra.x < rb.x + rb.w and
        ra.x + ra.w > rb.x and
        ra.y < rb.y + rb.h and
        ra.y + ra.h > rb.y
end

local function potential_collisions(game, r)
    -- Quickly get a list of terrain spaces that the actor could
    -- potentially collide with.

    local function to_grid_width(x)
        return math.floor(x / game.font.width)
    end

    local function to_grid_height(x)
        return math.floor(x / game.font.height)
    end

    local targets = {}

    local topleft = {
        x = to_grid_width(r.x), y = to_grid_height(r.y) }
    local bottomright = {
        x = to_grid_width(r.x + r.w), y = to_grid_height(r.y + r.h) }

    for w in it.range(topleft.x, bottomright.x) do
        for h in it.range(topleft.y, bottomright.y) do
            local tile = game.terrain:getTile(w, h)

            if not tile.passable then
                table.insert(targets, { x = w, y = h, tile = tile })
            end
        end
    end

    return targets
end

local function update_actor(game, actor, dt)
    if actor.dir.x == 0 and actor.dir.y == 0 then
        return
    end

    local speed = actor.speed * dt
    local velocity = vector.scale(vector.normalize(actor.dir), speed)

    -- Collision with terrain
    local new_pos = vector.add(actor.pos, velocity)
    local bound = {
        x = new_pos.x, y = new_pos.y, w = actor.width, h = actor.height }

    for i, tile in ipairs(potential_collisions(game, bound)) do
        if collides_with(game, bound, {
            x = tile.x * game.font.width, y = tile.y * game.font.height,
            w = game.font.width, h = game.font.height }) then
            return
        end
    end

    -- Apply movement
    actor.pos = vector.add(actor.pos, velocity)
end

function physics.update(game, dt)
    update_actor(game, game.hero, dt)
end

return physics

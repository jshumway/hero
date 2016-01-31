local physics = {}

local vector = require('vector')
local it = require('it')

local function collides_with(ra, rb)
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
        if collides_with(bound, {
            x = tile.x * game.font.width, y = tile.y * game.font.height,
            w = game.font.width, h = game.font.height }) then
            return
        end
    end

    -- Apply movement
    actor.pos = vector.add(actor.pos, velocity)
end

function update_bullets(game, bullets, dt)
    local to_remove = {}
    local hero = game.hero
    local hero_bound = {
        x = hero.pos.x, y = hero.pos.y, w = hero.width, h = hero.height }

    for i, bullet in ipairs(bullets) do
        local speed = bullet.speed * dt
        local velocity = vector.scale(bullet.dir, speed)

        local new_pos = vector.add(bullet.pos, velocity)
        local bound = {
            x = new_pos.x * game.font.width, y = new_pos.y * game.font.height,
            w = game.font.width, h = game.font.height }

        if collides_with(bound, hero_bound) then
            print('DEATH')
        end

        for i, tile in ipairs(potential_collisions(game, bound)) do
            if collides_with(bound, {
                x = tile.x * game.font.width, y = tile.y * game.font.height,
                w = game.font.width, h = game.font.height }) then
                table.insert(to_remove, i)
            end
        end

        bullet.pos = new_pos
    end

    for c, i in ipairs(to_remove) do
        table.remove(game.objects.bullets, i - c + 1)
    end
end

function physics.update(game, dt)
    update_actor(game, game.hero, dt)
    update_bullets(game, game.objects.bullets, dt)
end

return physics

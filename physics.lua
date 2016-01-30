local physics = {}

local vector = require('vector')

local function update_actor(game, actor, dt)
    if actor.dir.x == 0 and actor.dir.y == 0 then
        return
    end

    local speed = actor.speed * dt
    local velocity = vector.scale(vector.normalize(actor.dir), speed)

    actor.pos = vector.add(actor.pos, velocity)
end

function physics.update(game, dt)
    update_actor(game, game.hero, dt)
end

return physics

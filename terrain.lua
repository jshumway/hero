local Terrain = {}
Terrain.__index = Terrain

function Terrain:new()
    local newTerrain = {
        -- The tiles in the world, organized width then height
        layer = {},
        width = width,
        height = height
    }
    return setmetatable(newTerrain, self)
end

function Terrain:getTile(x, y)
    return self.layer[x][y]
end

function Terrain:setTile(x, y, glyph, passable, visible)
    if self.layer[x] == nil then self.layer[x] = {} end

    self.layer[x][y] = {
        glyph = glyph, passable = passable, visible = visible }
end

function Terrain:iter()
    local function all_tiles()
        for w, col in ipairs(self.layer) do
            for h, tile in ipairs(col) do
                coroutine.yield({ x = w, y = h, tile = tile })
            end
        end
    end

    local co = coroutine.create(function () all_tiles() end)
    return function ()
        local code, tile = coroutine.resume(co)
        if tile ~= nil then
            return tile.x, tile.y, tile.tile
        end
    end
end

return Terrain

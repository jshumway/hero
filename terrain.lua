local Terrain = {}

function Terrain:new()
    newObj = {
        -- Types of tiles in the world
        types = {},
        -- The tiles in the world, organized width then height
        layer = {}
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Terrain:addType(name, repr, passable)
    self.types.name = { repr = repr, passable = passable }
end

function Terrain:initLayer(width, height, terainType)
    local ttype = self.types[terrainType]
    for w in 0, width do
        self.layer[w] = {}
        for h in 0, height do
            self.layer[w][h] = ttype
        end
    end
end

return Terrain

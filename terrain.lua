local Terrain = {}

function Terrain:new()
    newObj = {
        -- Types of tiles in the world
        types = {},
        -- The tiles in the world, organized width then height
        layer = {},
        width = 0,
        height = 0
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Terrain:addType(name, repr, passable)
    self.types[name] = { repr = repr, passable = passable }
end

function Terrain:initLayer(width, height, terrainType)
    self.width = width
    self.height = height

    local ttype = assert(self.types[terrainType],
        "invalid terrain tile name: " .. (terrainType or 'nil'))

    for w = 0, width do
        self.layer[w] = {}
        for h = 0, height do
            self.layer[w][h] = ttype
        end
    end
end

function Terrain:iter()
    local layer = self.layer

    local w = 0
    local h = -1
    local maxw = self.width
    local maxh = self.height

    return function()
        h = h + 1

        if h >= maxh then
            h = 0
            w = w + 1
        end

        if w >= maxw then
            return nil
        end

        return w, h, layer[w][h]
    end
end

return Terrain

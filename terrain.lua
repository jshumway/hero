local Terrain = {}

function Terrain:new()
    local newObj = {
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

function Terrain:addType(name, glyph, passable, visable)
    self.types[name] = { glyph = glyph, passable = passable, visable = visable }
end

function Terrain:getType(glyph)
    for name, ttype in pairs(self.types) do
        if glyph == ttype.glyph then return name end
    end
end

function Terrain:get(point)
    return self.layer[point.x][point.y]
end

--[[ pretty sure this is broken now, because it is zero indexed
function Terrain:layerFromTile(width, height, terrainType)
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
]]--

function Terrain:layerFromGrid(tiles)
    self.layer = {}

    -- Load the terrain layer from a 2d grid of names
    for w, col in ipairs(tiles) do
        self.layer[w] = {}
        for h, name in ipairs(col) do
            self.layer[w][h] = self.types[name]
        end
    end

    self.width = table.getn(self.layer)
    self.height = table.getn(self.layer[1])
end

function Terrain:iter()
    local layer = self.layer

    local w = 1
    local h = 0
    local maxw = self.width
    local maxh = self.height

    return function()
        h = h + 1

        if h > maxh then
            h = 1
            w = w + 1
        end

        if w > maxw then
            return nil
        end

        return w, h, layer[w][h]
    end
end

return Terrain

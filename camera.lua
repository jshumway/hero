-- Code adapated from the love2D camera tutorial at:
-- http://nova-fusion.com/2011/04/19/cameras-in-love2d-part-1-the-basics/

local Camera = {}
Camera.__index = Camera

function Camera:new(screen)
    local newCamera = {
        x = 0,
        y = 0,
        scaleX = 1,
        scaleY = 1,
        rotation = 0,
        WIDTH_2 = screen.width / 2,
        HEIGHT_2 = screen.height / 2
    }

    return setmetatable(newCamera, self)
end

function Camera:update(hero)
    local x = hero.pos.x - self.WIDTH_2
    local y = hero.pos.y - self.HEIGHT_2
    self:setPosition(x, y)
end

function Camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function Camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function Camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function Camera:rotate(dr)
  self.rotation = self.rotation + dr
end

return Camera

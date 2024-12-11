-- bullet.lua
Bullet = Entity:extend()

function Bullet:new(world, x, y, width, height)
    self.x = x --mouse spot when clicked
    self.y = y
    self.width = width or 10
    self.height = height or 10
    self.speed = 800
    self.isBullet = true
    self.toRemove = false
    self.world = world
    self.world:add(self, self.x, self.y, self.width, self.height)
end

function Bullet:update(dt)
    local actualX, actualY, cols, len = self.world:move(self, self.x, self.y)
    self.x, self.y = actualX, actualY
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

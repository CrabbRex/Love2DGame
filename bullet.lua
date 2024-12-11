-- bullet.lua
Bullet = Entity:extend()

function Bullet:new(world, playerX, playerY, targetX, targetY)
    self.x = playerX --mouse spot when clicked
    self.y = playerY
    self.width = 10
    self.height = 10
    self.speed = 800
    self.isBullet = true
    self.toRemove = false
    
    local dx = targetX - playerX
    local dy = targetY - playerY
    self.angle = math.atan2(dy, dx)
    
    self.world = world
    self.world:add(self, self.x, self.y, self.width, self.height)
end

function Bullet:update(dt)
    self.x = self.x + math.cos(self.angle) * self.speed * dt
    self.y = self.y + math.sin(self.angle) * self.speed * dt
    local actualX, actualY, cols, len = self.world:move(self, self.x, self.y)
    self.x, self.y = actualX, actualY
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

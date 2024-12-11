-- bullet.lua
Bullet = Entity:extend()

function Bullet:new(world, x, y, direction, width, height)
    self.x = x --mouse spot when clicked
    self.y = y
    self.width = width or 10
    self.height = height or 10
    self.speed = 800
    self.isBullet = true
    self.toRemove = false
    self.world = world
    
    local magnitude = math.sqrt(direction.dx^2 + direction.dy^2)
    self.direction = { dx = direction.dx / magnitude, dy = direction.dy / magnitude }
    
    self.world:add(self, self.x, self.y, self.width, self.height)
end

local bulletFilter = function(item, other)
    if other.isPlayer then
      return 'cross'
    end
    return 'slide'
end


function Bullet:update(dt)
    self.x = self.x + self.direction.dx * self.speed * dt
    self.y = self.y + self.direction.dy * self.speed * dt
    local actualX, actualY, cols, len = self.world:move(self, self.x, self.y, bulletFilter)
    self.x, self.y = actualX, actualY
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

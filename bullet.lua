-- bullet.lua
Bullet = Entity:extend()

function Bullet:new(world, x, y, direction, width, height)
    self.x = x --mouse spot when clicked
    self.y = y
    self.width = width or 5
    self.height = height or 5
    self.speed = 800
    self.isBullet = true
    self.toRemove = false
    self.world = world
    self.damageAmount = 10
    
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
    
    -- Setting bullets for removal. Removed in main (for now)
    for i=1, len do
      local col = cols[i]
      if col.other.isGround then
        self.toRemove = true
      elseif col.other.isEnemy then
        self.toRemove = true
        col.other:takeDamage(self.damageAmount)
      end
    end
    if self.x < 0 or self.x > love.graphics.getWidth() or self.y < 0 or self.y > love.graphics.getHeight() then
      self.toRemove = true
    end
    
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end



--enemy.lua
Enemy = Entity:extend()

function Enemy:new(x, y, speed, player)
    Enemy.super.new(self, x, y, 50, 50)
    self.isEnemy = true
    self.player = player
    self.speed = 100
end

function Enemy:update(dt)
    Enemy.super.update(self, dt)
    self:changeVelocityByGravity(dt)--Increases vy
    
    local playerX, playerY = self.player.x, self.player.y
    local goalX
    local goalY = self.y + self.vy * dt--Uses vy
    if self.x > playerX then
      goalX = self.x - self.speed * dt
    elseif self.x < playerX then
      goalX = self.x + self.speed * dt
    end
    
    
    local actualX, actualY, cols, len = world:move(self, goalX, goalY)
    self.x, self.y = actualX, actualY
    
    for i=1, len do
      local col = cols[i]
      if col.normal.y < 0 then
        self.vy = 0
      end
    end
end



function Enemy:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
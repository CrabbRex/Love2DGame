--enemy.lua
Enemy = Entity:extend()

function Enemy:new(world, x, y, speed, health, player)
    Enemy.super.new(self, x, y, 50, 50)
    self.world = world
    self.isEnemy = true
    self.toRemove = false
    self.player = player
    self.speed = speed
    self.health = health
    self.lastHitTime = 0
    self.hitCooldown = 1
end

local enemyFilter = function(item, other)
    if other.isEnemy then return 'cross'
    else return 'slide'
    end
    
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
    
    
    local actualX, actualY, cols, len = world:move(self, goalX, goalY, enemyFilter)
    self.x, self.y = actualX, actualY
    
    for i=1, len do
      local col = cols[i]
      local other = cols[i].other
      if col.normal.y < 0 then
        self.vy = 0
      elseif other.isPlayer then
        local currentTime = love.timer.getTime()
        if currentTime - self.lastHitTime >= self.hitCooldown then
          self.player:takeDamage("Slime")
          self.lastHitTime = currentTime
          if self.x < other.x then
            other.x = other.x + self.knockBack
          else
            other.x = other.x - self.knockBack
          end
        end 
      end
    end
end

function Enemy:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
    
end

function Enemy:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
      self:die()
    end
end


function Enemy:die()
    print("Dead")
    self.toRemove = true
end

function Enemy:destroy()
    self.world:remove(self)
end

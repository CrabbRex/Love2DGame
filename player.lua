-- player.lua
Player = Entity:extend()
require "Bullet"
function Player:new(x, y, world, camera)
    Player.super.new(self, x, y, 25, 25)
    self.isPlayer = true
    self.speed = 600
    self.jumpSpeed = -650
    self.isGrounded = false
    self.world = world
    self.camera = camera
    self.shootCooldown = 0.2
    self.lastShot = 0
    self.health = 100
end

local playerFilter = function(item, other)
    if other.isGround then return 'slide'
    elseif other.isPlayer then return 'slide'
    elseif other.isEnemy then return 'cross'
    elseif other.isSlime then return 'cross'
  end
end


function Player:update(dt)
    Player.super.update(self, dt)
    
    -- Gravity:
    if not self.isGrounded then
      self:changeVelocityByGravity(dt)
    else
      self.vy = 0
    end
    
    -- Save previous player pos for collision check.
    local goalX, goalY = self.x, self.y + self.vy * dt
    
    -- Movement
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
      goalX = goalX - self.speed * dt
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      goalX = goalX + self.speed * dt
    end
    
    if self.isGrounded and (love.keyboard.isDown("space") or love.keyboard.isDown("up") or love.keyboard.isDown("w")) then
      self.vy = self.jumpSpeed
      self.isGrounded = false
    end
    
    
    local actualX, actualY, cols, len = self.world:move(self, goalX, goalY, playerFilter)
    self.x, self.y = actualX, actualY
    for i=1, len do 
      local other = cols[i].other
      if other.isGround then
        
      elseif other.isSlime then
        local currentTime = love.timer.getTime()
        --if currentTime - self.lastHitTime >= self.hitCooldown then
          --self:takeDamage("Slime")
          --self.lastHitTime = currentTime
          --if self.x < other.x then
          --  other.x = other.x + other.knockBack
          --else
          --  other.x = other.x - other.knockBack
          --end
        --end
      end
    end
    
    self.isGrounded = false
    for i=1, len do
      local col = cols[i]
      if col.normal.y < 0 then
        self.isGrounded = true
      end
    end
    
    self.lastShot = self.lastShot + dt --DO NOT DELETE
    --Shooting:
    if love.mouse.isDown(1) and self.lastShot >= self.shootCooldown then
      local crosshairX, crosshairY = self.camera:toWorld(love.mouse.getPosition())
      local playerCenterX = self.x + self.width/2
      local playerCenterY = self.y + self.height/2
      local direction = { dx = crosshairX - playerCenterX, dy = crosshairY - playerCenterY }
      local bullet = Bullet(self.world, playerCenterX, playerCenterY, direction)
      table.insert(levelOne._entities, bullet)
      self.lastShot = 0
    end
    
end

function Player:draw()
    --Player
    love.graphics.rectangle("line", self.x, self.y, 25, 25)
    
end


function Player:takeDamage(enemyType)
    if enemyType == "Slime" then
      self.health = self.health - 10
    end
end

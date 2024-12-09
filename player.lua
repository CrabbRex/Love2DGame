-- player.lua
Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, 50, 50)
    self.isPlayer = true
    self.speed = 200
end

local playerFilter = function(item, other)
    if other.isGround then return 'slide'
    elseif other.isPlayer then return 'slide'
  end
end


function Player:update(dt)
    Player.super.update(self, dt)
    -- Save previous player pos for collision check.
    local goalX, goalY = self.x, self.y
    
    -- Movement
    if love.keyboard.isDown("left") then
      goalX = goalX - self.speed * dt
    elseif love.keyboard.isDown("right") then
      goalX = goalX + self.speed * dt
    end
    if love.keyboard.isDown("up") then
      goalY = goalY - self.speed * dt
    elseif love.keyboard.isDown("down") then
      goalY = goalY + self.speed * dt
    end
    
    local actualX, actualY, cols, len = world:move(self, goalX, goalY, playerFilter)
    self.x, self.y = actualX, actualY
    for i=1, len do 
      local other = cols[i].other
      if other.isGround then
        print("ground")
      elseif other.isPlayer then
        print("player")
      end
      
    end
    
    
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, 50, 50)
end

-- player.lua
Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, 50, 50)
    self.speed = 200
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
    
    local actualX, actualY, cols, len = world:move(self, goalX, goalY)
    self.x, self.y = actualX, actualY
    
    --[[ Collision Check
    for i,entity in ipairs(entities) do
      if self:checkCollision(entity) then
        self.x, self.y = prevX, prevY
        break
      end
    end]]--
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, 50, 50)
end

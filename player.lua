-- player.lua
Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, 50, 50)
    self.speed = 200
end

function Player:update(dt)
    Player.super.update(self, dt)
    -- Save previous player pos for collision check.
    local prevX, prevY = self.x, self.y
    
    -- Movement
    if love.keyboard.isDown("left") then
      self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
      self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("up") then
      self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("down") then
      self.y = self.y + self.speed * dt
    end
    
    -- Collision Check
    for i,entity in ipairs(entities) do
      if self:checkCollision(entity) then
        self.x, self.y = prevX, prevY
        break
      end
    end
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, 50, 50)
end
